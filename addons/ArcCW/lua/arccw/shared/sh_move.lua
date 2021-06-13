
function ArcCW.Move(ply, mv, cmd)
    local wpn = ply:GetActiveWeapon()

    if !wpn.ArcCW then return end

    local s = 1

    local sm = math.Clamp(wpn.SpeedMult * wpn:GetBuff_Mult("Mult_SpeedMult") * wpn:GetBuff_Mult("Mult_MoveSpeed"), 0, 1)

    -- look, basically I made a bit of an oopsy and uh this is the best way to fix that
    s = s * sm

    local basespd = (Vector(cmd:GetForwardMove(), cmd:GetUpMove(), cmd:GetSideMove())):Length()
    basespd = math.min(basespd, mv:GetMaxClientSpeed())

    local shotdelta = 0 -- how close should we be to the shoot speed mult
    local shottime = wpn:GetNextPrimaryFireSlowdown() - CurTime()

    local blocksprint = false

    if wpn:GetState() == ArcCW.STATE_SIGHTS or
        wpn:GetState() == ArcCW.STATE_CUSTOMIZE then
        blocksprint = true
        s = s * math.Clamp(wpn:GetBuff("SightedSpeedMult") * wpn:GetBuff_Mult("Mult_SightedMoveSpeed"), 0, 1)
    elseif shottime > 0 then
        blocksprint = true

        if wpn:GetBuff("ShootWhileSprint") then
            blocksprint = false
        end
    end

    if blocksprint then
        basespd = math.min(basespd, ply:GetWalkSpeed())
    end

    if wpn:GetInBipod() then
        s = 0.0001
    end

    if shottime > 0 then
        -- full slowdown for duration of firing
        shotdelta = 1
    else
        -- recover from firing slowdown after shadow duration
        local delay = wpn:GetFiringDelay()
        local aftershottime = -shottime / delay
        shotdelta = math.Clamp(1 - aftershottime, 0, 1)
    end
    local shootmove = math.Clamp(wpn:GetBuff("ShootSpeedMult"), 0.0001, 1)
    s = s * Lerp(shotdelta, 1, shootmove)

    mv:SetMaxSpeed(basespd * s)
    mv:SetMaxClientSpeed(basespd * s)

    wpn.StrafeSpeed = math.Clamp(mv:GetSideSpeed(), -1, 1)

end

hook.Add("SetupMove", "ArcCW_SetupMove", ArcCW.Move)

function ArcCW.CreateMove(cmd)
    local ply = LocalPlayer()
    local wpn = ply:GetActiveWeapon()

    if !wpn.ArcCW then return end

    if wpn:GetInBipod() then
        if !wpn:GetBipodAngle() then
            wpn:SetBipodPos(wpn:GetOwner():EyePos())
            wpn:SetBipodAngle(wpn:GetOwner():EyeAngles())
        end

        local bipang = wpn:GetBipodAngle()
        local ang = cmd:GetViewAngles()

        local dy = math.AngleDifference(ang.y, bipang.y)
        local dp = math.AngleDifference(ang.p, bipang.p)

        local limy_p = 75
        local limy_n = -75
        local limp_p = 30
        local limp_n = -30

        if dy > limy_p then
            ang.y = bipang.y + limy_p
        elseif dy < limy_n then
            ang.y = bipang.y + limy_n
        end

        if dp > limp_p then
            ang.p = bipang.p + limp_p
        elseif dp < limp_n then
            ang.p = bipang.p + limp_n
        end

        cmd:SetViewAngles(ang)
    end
end

hook.Add("CreateMove", "ArcCW_CreateMove", ArcCW.CreateMove)

local function tgt_pos(ent, head)
    local mins, maxs = ent:WorldSpaceAABB()
    local pos = ent:WorldSpaceCenter()
    pos.z = pos.z + (maxs.z - mins.z) * 0.2 -- Aim at chest level
    if head and ent:GetAttachment(ent:LookupAttachment("eyes")) ~= nil then
        pos = ent:GetAttachment(ent:LookupAttachment("eyes")).Pos
    end
    return pos
end

local lst = SysTime()

function ArcCW.StartCommand(ply, ucmd)
    -- Sprint will not interrupt a runaway burst
    local wep = ply:GetActiveWeapon()
    if ply:Alive() and IsValid(wep) and wep.ArcCW and wep:GetBurstCount() > 0
            and ucmd:KeyDown(IN_SPEED) and wep:GetCurrentFiremode().RunawayBurst
            and !(wep:GetBuff_Override("Override_ShootWhileSprint") or wep.ShootWhileSprint) then
        ucmd:SetButtons(ucmd:GetButtons() - IN_SPEED)
    end

    -- Holster code
    if IsValid(wep) and wep.ArcCW then
        if wep:GetHolster_Time() != 0 and wep:GetHolster_Time() <= CurTime() then
            if IsValid(wep:GetHolster_Entity()) then
                wep:SetHolster_Time(-math.huge)
                ucmd:SelectWeapon(wep:GetHolster_Entity())
            end
        end
    end

    if CLIENT and IsValid(wep) and wep.ArcCW then
        local ang2 = ucmd:GetViewAngles()
        local ft = (SysTime() - (lst or SysTime())) * GetConVar("host_timescale"):GetFloat()

        local recoil = Angle()
        recoil = recoil + (wep:GetBuff_Override("Override_RecoilDirection") or wep.RecoilDirection) * wep.RecoilAmount
        recoil = recoil + (wep:GetBuff_Override("Override_RecoilDirectionSide") or wep.RecoilDirectionSide) * wep.RecoilAmountSide
        ang2 = ang2 - (recoil * ft * 30)
        ucmd:SetViewAngles(ang2)

        local r = wep.RecoilAmount
        local rs = wep.RecoilAmountSide
        wep.RecoilAmount = math.Approach(wep.RecoilAmount, 0, ft * 20 * r)
        wep.RecoilAmountSide = math.Approach(wep.RecoilAmountSide, 0, ft * 20 * rs)
    end
    lst = SysTime()
end

hook.Add("StartCommand", "ArcCW_StartCommand", ArcCW.StartCommand)

function ArcCW.StrafeTilt(wep)
    if GetConVar("arccw_strafetilt"):GetBool() then
        local tilt = wep.StrafeSpeed or 0
        if wep:GetState() == ArcCW.STATE_SIGHTS and wep:GetActiveSights().Holosight then
            tilt = tilt * (wep:GetBuff("MoveDispersion") / 360 / 60) * 2
        end
        return tilt
    end
    return 0
end
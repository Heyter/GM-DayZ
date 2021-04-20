
function ArcCW.Move(ply, mv, cmd)
    local wpn = ply:GetActiveWeapon()

    if !wpn.ArcCW then return end

    local s = 1

    local sm = math.Clamp(wpn.SpeedMult * wpn:GetBuff_Mult("Mult_SpeedMult") * wpn:GetBuff_Mult("Mult_MoveSpeed"), 0, 1)

    -- look, basically I made a bit of an oopsy and uh this is the best way to fix that
    s = s * sm

    local basespd = (Vector(cmd:GetForwardMove(), cmd:GetUpMove(), cmd:GetSideMove())):Length()
    basespd = math.min(basespd, mv:GetMaxClientSpeed())

    local shootmove = wpn:GetBuff("ShootSpeedMult")

    local delta = 0 -- how close should we be to the shoot speed mult
    local shottime = wpn:GetNextPrimaryFireSlowdown() - CurTime()

    if shottime > 0 then -- apply full shoot move speed
        delta = 1
    else -- apply partial shoot move speed
        local delay = wpn:GetFiringDelay()
        local aftershottime = shottime / delay
        delta = math.Clamp(aftershottime, 0, 1)
    end

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

    s = s * Lerp(delta, 1, shootmove)

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
        if !wpn.BipodAngle then
            wpn.BipodPos = wpn:GetOwner():EyePos()
            wpn.BipodAngle = wpn:GetOwner():EyeAngles()
        end

        local bipang = wpn.BipodAngle
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

    local ang2 = cmd:GetViewAngles()

    -- ang2 = ang2 - (wpn.ViewPunchAngle * FrameTime() * 60)

    ang2 = ang2 - (Angle(wpn.RecoilAmount, wpn.RecoilAmountSide, 0) * FrameTime() * 30)

    cmd:SetViewAngles(ang2)
end

hook.Add("CreateMove", "ArcCW_CreateMove", ArcCW.CreateMove)

function ArcCW.StartCommand(ply, ucmd)
    -- Sprint will not interrupt a runaway burst
    local wep = ply:GetActiveWeapon()
    if ply:Alive() and IsValid(wep) and wep.ArcCW and wep:GetBurstCount() > 0
            and ucmd:KeyDown(IN_SPEED) and wep:GetCurrentFiremode().RunawayBurst
            and !(wep:GetBuff_Override("Override_ShootWhileSprint") or wep.ShootWhileSprint) then
        ucmd:SetButtons(ucmd:GetButtons() - IN_SPEED)
    end
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
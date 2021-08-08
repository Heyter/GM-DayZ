local loadingTexture = Material("icon16/arrow_rotate_anticlockwise.png")
local category = {}
category.name = "Screen capture"
category.material = "serverguard/menuicons/icon_camera.png"
category.permissions = "Screencap"

screencap = screencap or {}

function category:Create(base)
    base.quality = 75
    base.panel = base:Add("tiger.panel")
    base.panel:SetTitle("Screen capture")
    base.panel:Dock(FILL)
    base.panel.qualitySlider = base.panel:Add("DNumSlider")
    base.panel.qualitySlider:Dock(TOP)
    base.panel.qualitySlider:DockMargin(4, 0, 0, 14)
    base.panel.qualitySlider:SetText("Picture Quality")
    base.panel.qualitySlider:SetMinMax(25, 100)
    base.panel.qualitySlider:SetDecimals(0)
    base.panel.qualitySlider:SetValue(base.quality)
    base.panel.qualitySlider.Label:SizeToContentsX()
    base.panel.qualitySlider.Label:SetSkin("serverguard")
    base.panel.qualitySlider.TextArea:SetSkin("serverguard")

    function base.panel.qualitySlider:OnValueChanged(value)
        base.quality = math.ceil(value)
    end

    base.panel.list = base.panel:Add("tiger.list")
    base.panel.list:Dock(FILL)
    base.panel.list:AddColumn("PLAYER", 320)
    base.panel.list:AddColumn("STEAMID", 200)
    base.panel.list:AddColumn("VIEW & CAPTURE", 100):SetDisabled(true)

    function base.panel.list:Think()
        local players = player.GetHumans()

        for i = 1, #players do
            local pPlayer = players[i]

            if (not IsValid(pPlayer.screenPanel)) then
                local panel = base.panel.list:AddItem(serverguard.player:GetName(pPlayer), pPlayer:SteamID())
                panel.player = pPlayer
                panel.steamid64 = pPlayer:SteamID64()

                function panel:OnMousePressed()
                end

                function panel:Think()
                    if (not IsValid(self.player)) then
						screencap[self.steamid64] = nil
                        self:Remove()
                        base.panel.list:GetCanvas():InvalidateLayout()

                        timer.Simple(FrameTime() * 2, function()
                            base.panel.list:OnSort()
                        end)
					end
                end

                panel:GetLabel(1):SetUpdate(function(self) -- nameLabel
                    if (IsValid(pPlayer)) then
                        if (self:GetText() ~= serverguard.player:GetName(pPlayer)) then
                            self:SetText(serverguard.player:GetName(pPlayer))
                        end
                    end
                end)

                local lastBase = vgui.Create("Panel")
                lastBase.rotate = 0
                lastBase.SizeToColumn = true
                lastBase.capture = lastBase:Add("DImageButton")
                lastBase.capture:SetSize(16, 16)
                lastBase.capture:SetImage("icon16/film_add.png")
                lastBase.capture:SetToolTipSG("Capture Screen")
				lastBase.capture.Screencap = function(t)
					lastBase.timer = RealTime() + 30
					screencap[panel.steamid64] = nil

					net.Start("serverguard.Screencap")
						net.WriteString(panel.steamid64)
						net.WriteUInt(base.quality, 7)
					net.SendToServer()
				end

                function lastBase.capture:DoClick()
					if (screencap[panel.steamid64]) then
						util.CreateDialog("Notice", "Are you sure you want to new capture screen?", function()
							self:Screencap()
						end, "&Yes", function() end, "No")
					else
						self:Screencap()
					end
                end

                lastBase.view = lastBase:Add("DImageButton")
                lastBase.view:SetSize(16, 16)
                lastBase.view:SetImage("icon16/film_go.png")
                lastBase.view:SetToolTipSG("View Image")
				lastBase.view:SetVisible(false)

                function lastBase.view:DoClick()
                    local baseb = vgui.Create("tiger.panel")
                    baseb:SetSize(ScrW() * 0.75, ScrH() * 0.75)
                    baseb:Center()
                    baseb:SetTitle("Screen Capture of " .. pPlayer:Name() .. " (" .. pPlayer:SteamID() .. ")")
                    baseb:MakePopup()

                    local closeButton = baseb:Add("tiger.button")
                    closeButton:SetPos(4, 4)
                    closeButton:SetText("Close")
                    closeButton:SizeToContents()
                    closeButton:DockMargin(0, 0, 0, 24)

                    function closeButton:DoClick()
                        baseb:Remove()
                    end

					if (screencap[panel.steamid64]) then
						local html = baseb:Add("DHTML")
						html:Dock(FILL)
						html:OpenURL(screencap[panel.steamid64])
					end

                    function baseb:PerformLayout(w, h)
                        closeButton:SetPos(w - (closeButton:GetWide() + 24), (closeButton:GetTall() * 0.5) + 14)
                    end

                    baseb:InvalidateLayout(true)
                end

                function lastBase:Paint(w, h)
                    if (IsValid(panel.player)) then
						if (screencap[panel.steamid64]) then
							if (not self.view:IsVisible()) then
								self.view:SetVisible(true)
							end

							if (not self.capture:IsVisible()) then
								self.capture:SetVisible(true)
							end
						elseif (lastBase.timer) then
							if (lastBase.timer > RealTime()) then
								if (self.capture:IsVisible()) then
									self.capture:SetVisible(false)
								end

								if (self.view:IsVisible()) then
									self.view:SetVisible(false)
								end

								util.PaintShadow(0, 5, w - 6, 20, 3, 0.2)
								draw.MaterialRotated(12, 15, 16, 16, color_white, loadingTexture, self.rotate)
								self.rotate = self.rotate + 140 * FrameTime()

								if (self.rotate >= 360) then
									self.rotate = 0
								end
							else
								self.capture:SetVisible(true)
								lastBase.timer = nil
							end
						end
                    end
                end

                function lastBase:PerformLayout()
                    local w, h = self:GetSize()

                    if (self.view:IsVisible()) then
                        self.capture:SetPos(w / 2 + 12, h / 2 - 8)
                        self.view:SetPos(w / 2 - 12, h / 2 - 8)
                    else
                        self.capture:SetPos(w / 2 - 8, h / 2 - 8)
                    end

                    local column = panel:GetThing(3).column
                    local x = column:GetPos()
                    self:SetPos(x, 0)
                end

                panel:AddItem(lastBase)

                timer.Simple(FrameTime() * 2, function()
                    local column = panel:GetThing(3).column
                    lastBase:SetSize(column:GetWide() - 1, 30)
                    lastBase:InvalidateLayout()
                end)

                pPlayer.screenPanel = panel
				pPlayer.lastBase = lastBase
            end
        end
    end
end

serverguard.menu.AddSubCategory("Intelligence", category)
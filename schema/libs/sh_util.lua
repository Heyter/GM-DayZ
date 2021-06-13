if (SERVER) then
	function ix.util.SpawnProp(model, position, force, lifetime, angles, collision)
		-- Spawn the actual item entity.
		local entity = ents.Create("prop_physics")
		entity:SetModel(model)
		entity:Spawn()

		entity:SetCollisionGroup(collision or COLLISION_GROUP_WEAPON)
		entity:SetAngles(angles or angle_zero)

		if (type(position) == "Player") then
			position = position:GetItemDropPos(entity)
		end

		entity:SetPos(position)

		if (force) then
			local phys = entity:GetPhysicsObject()

			if (IsValid(phys)) then
				phys:ApplyForceCenter(force)
			end
		end

		if ((lifetime or 0) > 0) then
			timer.Simple(lifetime, function()
				if (IsValid(entity)) then
					entity:Remove()
				end
			end)
		end

		return entity
	end
end

if (CLIENT) then
	function ix.util.GetInjuredColor(client)
		local health_color = color_white

		if (!IsValid(client)) then
			return health_color
		end

		local health_color = color_white
		local health, healthMax = client:Health(), client:GetMaxHealth()

		if ((health / healthMax) < .95) then
			health_color = ix.util.LerpColorHSV(nil, nil, healthMax, health, 0)
		end

		return health_color
	end

    function ix.util.ScreenScaleH(n)
        return n * (ScrH() / 480)
    end
	--ScreenScale = Width scale

	function Derma_NumericRequest( strTitle, strText, strDefaultText, fnEnter, fnCancel, strButtonText, strButtonCancelText )

		local Window = vgui.Create( "DFrame" )
		Window:SetTitle( strTitle or "Message Title (First Parameter)" )
		Window:SetDraggable( false )
		Window:ShowCloseButton( false )
		Window:SetBackgroundBlur( true )
		Window:SetDrawOnTop( true )

		local InnerPanel = vgui.Create( "DPanel", Window )
		InnerPanel:SetPaintBackground( false )

		local Text = vgui.Create( "ixDLabel", InnerPanel )
		Text:SetText( strText or "Message Text (Second Parameter)" )
		Text:SizeToContents()
		Text:SetContentAlignment( 5 )
		Text:SetTextColor( color_white )

		local TextEntry = vgui.Create( "DTextEntry", InnerPanel )
		TextEntry:SetValue( strDefaultText or "" )
		TextEntry.OnEnter = function() Window:Close() fnEnter( TextEntry:GetValue() ) end
		TextEntry:SetNumeric(true)

		local ButtonPanel = vgui.Create( "DPanel", Window )
		ButtonPanel:SetTall( 30 )
		ButtonPanel:SetPaintBackground( false )

		local Button = vgui.Create( "DButton", ButtonPanel )
		Button:SetText( strButtonText or "OK" )
		Button:SizeToContents()
		Button:SetTall( 20 )
		Button:SetWide( Button:GetWide() + 20 )
		Button:SetPos( 5, 5 )
		Button.DoClick = function() Window:Close() fnEnter( TextEntry:GetValue() ) end

		local ButtonCancel = vgui.Create( "DButton", ButtonPanel )
		ButtonCancel:SetText( strButtonCancelText or L"derma_request_cancel" )
		ButtonCancel:SizeToContents()
		ButtonCancel:SetTall( 20 )
		ButtonCancel:SetWide( Button:GetWide() + 20 )
		ButtonCancel:SetPos( 5, 5 )
		ButtonCancel.DoClick = function() Window:Close() if ( fnCancel ) then fnCancel( TextEntry:GetValue() ) end end
		ButtonCancel:MoveRightOf( Button, 5 )

		ButtonPanel:SetWide( Button:GetWide() + 5 + ButtonCancel:GetWide() + 10 )

		local w, h = Text:GetSize()
		w = math.max( w, 400 )

		Window:SetSize( w + 50, h + 25 + 75 + 10 )
		Window:Center()

		InnerPanel:StretchToParent( 5, 25, 5, 45 )

		Text:StretchToParent( 5, 5, 5, 35 )

		TextEntry:StretchToParent( 5, nil, 5, nil )
		TextEntry:AlignBottom( 5 )

		TextEntry:RequestFocus()
		TextEntry:SelectAllText( true )

		ButtonPanel:CenterHorizontal()
		ButtonPanel:AlignBottom( 8 )

		Window:MakePopup()
		Window:DoModal()

		return Window

	end
end
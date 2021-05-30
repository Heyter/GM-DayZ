DEFINE_BASECLASS("DLabel")

local PANEL = {}

AccessorFunc(PANEL, "paintBackground", "PaintBackground", FORCE_BOOL)

function PANEL:Init()
	self:SetContentAlignment(5)
	self:SetExpensiveShadow(1, Color(0, 0, 0, 150))
	self:SetFont("ixGenericFont")
	self:SetTextColor(color_white)
	self:DockPadding(0, 0, 0, 0)
	self:DockMargin(0, 0, 0, 0)
end

function PANEL:PerformLayout(w, h)
	if ( IsValid( self.m_Image ) ) then
		self.m_Image:SetPos( 4, ( self:GetTall() - self.m_Image:GetTall() ) * 0.5 )
		self:SetTextInset( self.m_Image:GetWide() + 16, 0 )
	end

	DLabel.PerformLayout( self, w, h )
end

function PANEL:SetMaterial( mat )

	if ( !mat ) then

		if ( IsValid( self.m_Image ) ) then
			self.m_Image:Remove()
		end

		return
	end

	if ( !IsValid( self.m_Image ) ) then
		self.m_Image = vgui.Create( "DImage", self )
	end

	if (type(mat) == "IMaterial") then
		self.m_Image:SetMaterial( mat )
	else
		self.m_Image:SetImage( mat )
	end

	self.m_Image:SizeToContents()
	self:InvalidateLayout()

end

function PANEL:Paint(w, h)
	if (self:GetPaintBackground()) then
		derma.SkinFunc("DrawImportantBackground", 0, 0, w, h, ix.config.Get("color"))
	end
end

vgui.Register("ixDLabel", PANEL, "DLabel")
ITEM.name = "Filter"
ITEM.description = "A Gas Mask filter"
ITEM.model = "models/props_lab/rotato.mdl"
ITEM.price = 80
ITEM.isFilter = true
ITEM.filterHealth = ix.config.Get("gasmask_filter", 600)
ITEM.iconCam = {
	pos = Vector(57.318908691406, 48.096267700195, 34.891246795654),
	ang = Angle(25, 220, 0),
	fov = 6.508287169279,
}
function ITEM:OnGetDropModel(entity)
	return "models/props_lab/box01a.mdl"
end

function ITEM:GetFilterHealth()
    return self:GetData("health", self.filterHealth)
end

function ITEM:GetDescription()
	if (self.entity) then
		return L"filterDescEntity"
	else
        return L"filterDesc"
	end
end

ITEM.functions.combine = {
    OnCanRun = function(item, data)
		if (!data or !data[1]) then
			return false
		end

		return (!IsValid(item.entity) and item.isFilter)
    end,
    OnRun = function(item, data)
		if (!istable(data) or !data[1]) then return false end

        local client = item.player

        if (IsValid(client)) then
            local combineItem = ix.item.instances[data[1]]

            if (combineItem) then
                if (combineItem.isGasMask) then
                    return combineItem:ChangeFilter(client, combineItem, item)
                else
                    client:NotifyLocalized("notGasMask")
                end
            end
        end

        return false
    end,
}
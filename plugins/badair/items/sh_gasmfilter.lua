ITEM.name = "Filter"
ITEM.description = "A Gas Mask filter"
ITEM.model = "models/gmodz/equipments/gasmask_filter.mdl"
ITEM.price = 80
ITEM.isFilter = true
ITEM.filterHealth = ix.config.Get("gasmask_filter", 600)

if (CLIENT) then
	function ITEM:CanStack(combineItem)
		return combineItem:GetFilterHealth() == self:GetFilterHealth()
	end
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

            if (combineItem and combineItem.isGasMask) then
				return combineItem:ChangeFilter(client, combineItem, item)
            end
        end

        return false
    end,
}
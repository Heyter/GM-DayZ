function PLUGIN:LoadData()
	for _, v in ipairs(self:GetData() or {}) do
		local stash = ents.Create("gmodz_stash")
		stash:SetPos(v[1])
		stash:SetAngles(v[2])
		stash:Spawn()
		stash:Activate()
	end
end

function PLUGIN:SaveData()
	local data = {}

	for _, v in ipairs(ents.FindByClass("gmodz_stash")) do
		data[#data + 1] =  {v:GetPos(), v:GetAngles()}
	end

	self:SetData(data)
end
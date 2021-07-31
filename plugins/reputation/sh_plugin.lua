local PLUGIN = PLUGIN

PLUGIN.name = "Reputation"
PLUGIN.author = "STEAM_0:1:29606990"
PLUGIN.description = "Hands off!"

-- Go away, asshole.

function Schema.AddReputationRank(level, name, color, langData)
	Schema.ranks = Schema.ranks or {}

	if (CLIENT) then
		local name = "txtRep_" .. name

		for k, v in pairs(langData) do
			ix.lang.AddTable(k, { [name] = v })
		end

		Schema.ranks[level] = {name, color}
	else
		Schema.ranks[level] = {}
	end
end

function Schema.ModifyReputationRank(level, data)
	local rank = Schema.ranks[level]

	for k, v in pairs(data) do
		rank[k] = v
	end

	Schema.ranks[level] = rank
end

do
	Schema.AddReputationRank(-6, "rogue", Color(200, 0, 255), {
		english = "★ Rogue ★",
		russian = "★ Изгой ★"
	})
	Schema.ModifyReputationRank(-6, {setmodel = true})

	Schema.AddReputationRank(-5, "elite_bandit", Color(255, 0, 0), {
		english = "★ Elite Bandit ★",
		russian = "★ Элитный Бандит ★"
	})
	Schema.ModifyReputationRank(-5, {setmodel = true})

	Schema.AddReputationRank(-4, "bandit", Color(255, 0, 0), {
		english = "Bandit",
		russian = "Бандит"
	})
	Schema.ModifyReputationRank(-4, {setmodel = true})

	Schema.AddReputationRank(-3, "villain", Color(255, 0, 0), {
		english = "Villain",
		russian = "Злодей"
	})

	Schema.AddReputationRank(-2, "thug", Color(255, 0, 0), {
		english = "Thug",
		russian = "Головорез"
	})

	Schema.AddReputationRank(-1, "outlaw", Color(255, 0, 0), {
		english = "Outlaw",
		russian = "Вне Закона"
	})

	Schema.AddReputationRank(0, "survivor", color_white, {
		english = "Survivor",
		russian = "Выживший"
	})

	Schema.AddReputationRank(1, "novice", Color(0, 150, 255), {
		english = "Novice",
		russian = "Новичок"
	})

	Schema.AddReputationRank(2, "guardian", Color(0, 150, 255), {
		english = "Guardian",
		russian = "Страж"
	})

	Schema.AddReputationRank(3, "vigilante", Color(0, 150, 255), {
		english = "Vigilante",
		russian = "Линчеватель"
	})

	Schema.AddReputationRank(4, "hero", Color(0, 150, 255), {
		english = "Hero",
		russian = "Герой"
	})
	Schema.ModifyReputationRank(4, {setmodel = true})

	Schema.AddReputationRank(5, "elite_hero", Color(0, 150, 255), {
		english = "★ Elite Hero ★",
		russian = "★ Элитный Герой ★"
	})
	Schema.ModifyReputationRank(5, {setmodel = true})

	Schema.AddReputationRank(6, "legend", Color(200, 0, 255), {
		english = "★ Legend ★",
		russian = "★ Легенда ★"
	})
	Schema.ModifyReputationRank(6, {setmodel = true})

	Schema.rankLevels = #Schema.ranks
	Schema.rankScaleRep = ix.config.Get("maxReputation", 1500) / Schema.rankLevels
end

Schema.HeroModels = {}
Schema.BanditModels = {}

for _, v in ipairs({"t_arctic", "t_guerilla", "t_leet", "t_phoenix"}) do
	local i = #Schema.BanditModels + 1
	local str = "models/gmodz/characters/" .. v .. ".mdl"

	Schema.BanditModels[i] = Model(str)
	util.PrecacheModel(Schema.BanditModels[i])
	i = nil

	ix.anim.SetModelClass(str, "player")
	str = nil
end

for _, v in ipairs({"ct_gign", "ct_gsg9", "ct_sas", "ct_urban"}) do
	local i = #Schema.HeroModels + 1
	local str = "models/gmodz/characters/" .. v .. ".mdl"

	Schema.HeroModels[i] = Model(str)
	util.PrecacheModel(Schema.HeroModels[i])
	i = nil

	ix.anim.SetModelClass(str, "player")
	str = nil
end

ix.config.Add("maxReputation", 1500, "Макс. репутация", function(oldValue, newValue)
	Schema.rankScaleRep = newValue / Schema.rankLevels
end, {
	data = {min = 500, max = 9999},
	category = PLUGIN.name,
})

ix.config.Add("reputationKill", 45, "Потеря репутации за убийство невинных.", nil, {
	data = {min = 1, max = 5000},
	category = PLUGIN.name,
})

ix.config.Add("reputationSavior", 25, "Добавление репутации за убийство бандитов.", nil, {
	data = {min = 1, max = 5000},
	category = PLUGIN.name,
})

ix.config.Add("safePenalty", 120, "Штрафное время за убийство", nil, {
	data = {min = 1, max = 1200},
	category = PLUGIN.name,
})

ix.config.Add("safePenaltyMul", 2, "Множитель штрафного времени", nil, {
	data = {min = 1, max = 10},
	category = PLUGIN.name,
})

ix.config.Add("tagPVP", 120, "Штрафное время за попытку убийства", nil, {
	data = {min = 1, max = 1200},
	category = PLUGIN.name,
})

ix.config.Add("repMerchantPerc", 0.5, "Скидка/Наценка при покупке товара.", nil, {
	data = {min = 0, max = 1, decimals = 1},
	category = PLUGIN.name
})

ix.util.Include("sv_player.lua")
ix.util.Include("sv_plugin.lua")

-- PLAYER META | SHARED
do
	local function round(n)
		if (n < 0) then
			return math.ceil(n)
		else
			return math.floor(n)
		end
	end

	local playerMeta = FindMetaTable("Player")

	function playerMeta:CanEnterSafe()
		local penalty = self:GetLocalVar("penalty")

		if (penalty and penalty > CurTime()) then
			return false
		end

		return true
	end

	function playerMeta:GetPVPTime()
		return self:GetLocalVar("PVPTime", 0)
	end

	function playerMeta:GetReputation()
		return self:GetNetVar("reputation", 0)
	end

	function playerMeta:GetReputationLevel()
		return round(self:GetNetVar("reputation", 0) / Schema.rankScaleRep)
	end
end

-- HOOKS
function PLUGIN:MerchantCalculatePrice(client, price, scale, isSellingToVendor)
	if (!isSellingToVendor) then
		local rep = client:GetReputation()
		local repPerc = math.abs(rep / ix.config.Get("maxReputation", 1500))

		if (repPerc >= 0.6) then
			if (rep < 0) then -- bandit
				price = price / ix.config.Get("repMerchantPerc", 0.5)
			else
				price = price * ix.config.Get("repMerchantPerc", 0.5)
			end

			return price
		end
	end
end
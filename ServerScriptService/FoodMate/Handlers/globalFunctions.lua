local module = {}

function module.rankCheck(plr, chef)
	if require(game.ReplicatedStorage.foodMateSetup).Group.groupId == 0 then
		return true
	else
		if chef then
			return plr:GetRankInGroup(require(game.ReplicatedStorage.foodMateSetup).Group.groupId) >=  require(game.ReplicatedStorage.foodMateSetup).Group.minChefGroupRank
		else
			return plr:GetRankInGroup(require(game.ReplicatedStorage.foodMateSetup).Group.groupId) >=  require(game.ReplicatedStorage.foodMateSetup).Group.groupRank
		end
	end
end

return module

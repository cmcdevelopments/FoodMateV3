local DS = game:GetService("DataStoreService"):GetDataStore("FoodMateLocal")

game.Players.PlayerAdded:Connect(function(plr)
	local dataGet = DS:GetAsync(plr.UserId.."_pts")
	task.wait(1) -- allow other scripts u may alr have installed for leaderstats to create the folder so 2 aren't created o
	if plr:FindFirstChild('leaderstats') == nil then
		local folder = Instance.new('Folder')
		folder.Name = "leaderstats"
		folder.Parent = plr
		local pointsValue = Instance.new('IntValue')
		pointsValue.Name = "Points"
		pointsValue.Parent = folder 
		
		print('Data found under "'..plr.UserId.."_pts: "..dataGet)
		if dataGet ~= nil then
			pointsValue.Value = dataGet
		end

	else
		local folder = plr:FindFirstChild('leaderstats')

		local pointsValue = Instance.new('IntValue')
		pointsValue.Name = "Points"
		pointsValue.Parent = folder 

		if dataGet ~= nil then
			pointsValue.Value = dataGet
		end
	end



end)

local pointsAdded: number = math.random(1, 3) --If you want this to be a static amount such a 1, just replace math.random(....) with the number you want!
game.ReplicatedStorage.foodMateSetup.remotes.validatedSubmission.Event:Connect(function(_, plr)
	if typeof(plr) ~= "string" then
		plr:WaitForChild('leaderstats'):WaitForChild('Points').Value = plr:WaitForChild('leaderstats'):WaitForChild('Points').Value + pointsAdded 
	end 	
end)

game.ReplicatedStorage.foodMateSetup.remotes.orderComplete.Event:Connect(function(_, plr)
	if typeof(plr) ~= "string" then
		plr:WaitForChild('leaderstats'):WaitForChild('Points').Value = plr:WaitForChild('leaderstats'):WaitForChild('Points').Value + pointsAdded 
	end 	
end)



game.Players.PlayerRemoving:Connect(function(plr)
	print('Saving '..plr:WaitForChild('leaderstats'):WaitForChild('Points').Value..' points to player: '..plr.Name)
	DS:SetAsync(plr.UserId.."_pts", plr:WaitForChild('leaderstats'):WaitForChild('Points').Value)
end)
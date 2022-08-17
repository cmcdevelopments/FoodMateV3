local players_service = game:GetService("Players");

players_service.PlayerAdded:Connect(function(player)
	local player_gui = player:WaitForChild("PlayerGui");

	player.CharacterAdded:Connect(function(char)
		if player.Character.Humanoid.RigType == Enum.HumanoidRigType.R15 then
			local clone = script.orderingSystemUi:Clone()
			clone.Parent = char
			clone.Adornee = char:WaitForChild('UpperTorso')
		else
			local clone = script.orderingSystemUi:Clone()
			clone.Parent = char
			clone.Adornee = char:WaitForChild('Torso')
		end
		if require(script.Parent.globalFunctions).rankCheck(player, true) then
			script.foodMateChef:Clone().Parent = player_gui
		end
		if require(script.Parent.globalFunctions).rankCheck(player, false) then
			script.foodMate:Clone().Parent = player_gui
		end
	end)
end)
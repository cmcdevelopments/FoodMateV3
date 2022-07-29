game.Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function()
		if player.Character.Humanoid.RigType == Enum.HumanoidRigType.R15 then
			local clone = script.orderingSystemUi:Clone()
			clone.Parent = player.Character
			clone.Adornee = player.Character:WaitForChild('UpperTorso')
		else
			local clone = script.orderingSystemUi:Clone()
			clone.Parent = player.Character
			clone.Adornee = player.Character:WaitForChild('Torso')
		end
		if require(script.Parent.globalFunctions).rankCheck(player, true) then
			script.foodMateChef:Clone().Parent = player.PlayerGui
		end
		if require(script.Parent.globalFunctions).rankCheck(player, false) then
			script.foodMate:Clone().Parent = player.PlayerGui
		end
	end)
end)
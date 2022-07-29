script.Parent.Equipped:Connect(function()
	game.Players.LocalPlayer.PlayerGui:WaitForChild('foodMateChef').Enabled = true
end)

script.Parent.Unequipped:Connect(function()
	game.Players.LocalPlayer.PlayerGui:WaitForChild('foodMateChef').Enabled = false
end)
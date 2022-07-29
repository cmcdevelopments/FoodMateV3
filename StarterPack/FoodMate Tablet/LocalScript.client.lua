script.Parent.Equipped:Connect(function()
	game.Players.LocalPlayer.PlayerGui:WaitForChild('foodMate').Enabled = true
end)

script.Parent.Unequipped:Connect(function()
	game.Players.LocalPlayer.PlayerGui:WaitForChild('foodMate').Scripts.clickHandler.pageChange:Fire('closeMenu')
end)
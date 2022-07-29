script.Parent.changePage.Event:Connect(function(state)
	if state == 'deselect' then
		script.Parent.Font = Enum.Font.Gotham
	else
		script.Parent.Font = Enum.Font.GothamMedium
	end
end)

script.Parent.MouseButton1Click:Connect(function()
	script.Parent.Parent.Parent.Parent.Parent.Scripts.clickHandler.pageChange:Fire('changePage', script.Parent)
end)
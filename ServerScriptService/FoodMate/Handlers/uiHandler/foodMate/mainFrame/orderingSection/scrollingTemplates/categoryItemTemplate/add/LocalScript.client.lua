local debounce = false


script.Parent.MouseButton1Click:Connect(function()
	if debounce == false then
		debounce = true
		script.Parent.Parent.Parent.Parent.Parent.Parent.Scripts.clickHandler.buttonClick:Fire('addItem', script.Parent.Parent.Name)
		
		script.Parent:TweenSize(UDim2.new(0.07, 0,1.291, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.15, true)
		task.wait(0.15)
		script.Parent:TweenSize(UDim2.new(0.048, 0,0.888, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.15, true)
		task.wait(0.15)
		debounce = false
	end
end)
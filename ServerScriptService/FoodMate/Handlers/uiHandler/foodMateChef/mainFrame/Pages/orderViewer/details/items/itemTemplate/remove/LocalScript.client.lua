local debounce = false
local state = false

script.Parent.MouseButton1Click:Connect(function()
	if debounce == false then
		debounce = true
		if state == false then
			script.Parent:TweenSize(UDim2.new(0.07, 0,1.291, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.15, true)
			state = true
		else
			script.Parent:TweenSize(UDim2.new(0.048, 0,0.888, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.15, true)
			state = false
		end
		
		debounce = false
	end
end)
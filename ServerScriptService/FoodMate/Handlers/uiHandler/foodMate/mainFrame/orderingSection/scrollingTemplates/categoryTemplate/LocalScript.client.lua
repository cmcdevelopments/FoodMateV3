local TweenService = game:GetService("TweenService")

local debounce = false


script.Parent.MouseButton1Click:Connect(function()
		script.Parent.Parent.Parent.Parent.Parent.Scripts.clickHandler.buttonClick:Fire('categoryChange', script.Parent.Name)
end)

script.Parent.fade.Event:Connect(function(state)
	if state == "in"  then
		TweenService:Create(script.Parent,TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {BackgroundTransparency=0}):Play(true)
		TweenService:Create(script.Parent,TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {TextColor3=Color3.fromRGB(255, 255, 255)}):Play(true)
	else
		TweenService:Create(script.Parent,TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {BackgroundTransparency=1}):Play(true)
		TweenService:Create(script.Parent,TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {TextColor3=script.Parent.BackgroundColor3}):Play(true)
	end
end)
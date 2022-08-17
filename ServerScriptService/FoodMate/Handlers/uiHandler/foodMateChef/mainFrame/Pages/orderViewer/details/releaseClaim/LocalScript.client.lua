local TweenService = game:GetService("TweenService")
local debounce = false

script.Parent.MouseEnter:Connect(function()
	TweenService:Create(script.Parent,TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {BackgroundTransparency=0}):Play(true)
	TweenService:Create(script.Parent,TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {TextColor3=Color3.fromRGB(255, 255, 255)}):Play(true)
end)

script.Parent.MouseLeave:Connect(function()
	TweenService:Create(script.Parent,TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {BackgroundTransparency=1}):Play(true)
	TweenService:Create(script.Parent,TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {TextColor3=script.Parent.BackgroundColor3}):Play(true)
end)
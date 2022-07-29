local TweenService = game:GetService("TweenService")
local debounce = false

local moduleScript = require(game.ReplicatedStorage.foodMateSetup)
local themeColor: Color3 = moduleScript.getTheme().gradientColour2

script.Parent.MouseEnter:Connect(function()
	TweenService:Create(script.Parent,TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {BackgroundTransparency=0}):Play(true)
	TweenService:Create(script.Parent,TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {TextColor3=themeColor}):Play(true)
end)

script.Parent.MouseLeave:Connect(function()
	TweenService:Create(script.Parent,TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {BackgroundTransparency=1}):Play(true)
	TweenService:Create(script.Parent,TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {TextColor3=Color3.fromRGB(255,255,255)}):Play(true)
end)


script.Parent.MouseButton1Click:Connect(function()
	if debounce == false then
		debounce = true
		script.Parent.Parent.Parent.Parent.Scripts.clickHandler.buttonClick:Fire("submit")
		task.wait(2)
		debounce = false
	end
end)

local TweenService = game:GetService("TweenService")

local tweenInfo = TweenInfo.new(
	0.5,
	Enum.EasingStyle.Quad,
	Enum.EasingDirection.InOut,
	0,
	true,
	0 
)

local Tween = TweenService:Create(script.Parent, tweenInfo, {Size = UDim2.new(0.164, 0,0.197, 0)})
local Tween2 = TweenService:Create(script.Parent, tweenInfo, {Size = UDim2.new(0.141, 0,0.17, 0)})

while true do
	Tween:Play()
	task.wait(0.5)
	Tween2:Play()
end
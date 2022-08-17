local TweenService = game:GetService("TweenService")

local tweenInfo = TweenInfo.new(
	1.4,
	Enum.EasingStyle.Quad,
	Enum.EasingDirection.InOut,
	-1,
	false,
	0 
)

local Tween = TweenService:Create(script.Parent, tweenInfo, {Rotation = 360})
Tween:Play()

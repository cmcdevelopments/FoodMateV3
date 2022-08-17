local tweenService = game:GetService("TweenService")

script.Parent:GetPropertyChangedSignal("Visible"):Connect(function()
	if script.Parent.Visible == true then
		local closeTween = tweenService:Create(script.Parent.Parent.sideBar.close, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {ImageTransparency=1})
		closeTween:Play()
		closeTween.Completed:Connect(function()
			script.Parent.Parent.sideBar.close.Visible = false
		end)
		
		tweenService:Create(script.Parent.loadingIcon, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {ImageTransparency=0}):Play()
		tweenService:Create(script.Parent.loading, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {TextTransparency=0}):Play()
		task.wait(1)
		tweenService:Create(script.Parent.loadingIcon, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {ImageTransparency=1}):Play()
		tweenService:Create(script.Parent.loading, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {TextTransparency=1}):Play()
		task.wait(0.3)
		tweenService:Create(script.Parent.checkmark, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {ImageTransparency=0}):Play()
		tweenService:Create(script.Parent.done, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {TextTransparency=0}):Play()
		task.wait(1)
		tweenService:Create(script.Parent.checkmark, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {ImageTransparency=1}):Play()
		tweenService:Create(script.Parent.done, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {TextTransparency=1}):Play()
		task.wait(0.4)
		script.Parent.Visible = false
		script.Parent.Parent.Parent.Scripts.clickHandler.pageChange:Fire("loadDone")
		script.Parent.Parent.sideBar.close.Visible = true
		local closeTween2 = tweenService:Create(script.Parent.Parent.sideBar.close, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {ImageTransparency=0})
		closeTween2:Play()
	end
end)
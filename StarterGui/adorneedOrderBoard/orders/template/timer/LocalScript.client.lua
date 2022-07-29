function Format(Int)
	return string.format("%02i", Int)
end

function convertToHMS(Seconds)
	local Minutes = (Seconds - Seconds%60)/60
	Seconds = Seconds - Minutes*60
	return Format(Minutes)..":"..Format(Seconds)
end

local ts = game:GetService('TweenService')

script.count.Event:Connect(function(epoch)
	local theTime = game.ReplicatedStorage.foodMateSetup.remotes.serverTime:InvokeServer() - epoch
	script.Parent.Text = theTime
	while task.wait(1) do
		script.Parent.Text = convertToHMS(theTime)
		theTime = theTime + 1 
		if theTime > 180 then
			script.Parent.TextColor3 = Color3.fromRGB(255, 184, 3)
		end
		if theTime > 300 then
			script.Parent.TextColor3 = Color3.fromRGB(255, 53, 56)
		end
		if theTime >  600 then
			local returnColor: Color3 = script.Parent.Parent.BackgroundColor3
			local t = ts:Create(script.Parent.Parent, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {BackgroundColor3 = Color3.fromRGB(255, 60, 63)})
			t:Play(true)
			t.Completed:Connect(function()
				ts:Create(script.Parent.Parent, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {BackgroundColor3 = returnColor}):Play()
			end)
		end
	end
end)
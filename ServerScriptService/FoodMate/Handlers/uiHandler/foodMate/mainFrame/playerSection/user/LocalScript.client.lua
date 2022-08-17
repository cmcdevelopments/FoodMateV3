local target = 'nawh'

script.Parent.Focused:Connect(function()
	script.Parent.div:TweenSize(UDim2.new(1, 0,0.082, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.1, true)
	script.Parent.usernameText:TweenSize(UDim2.new(0.308, 0,0.747, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.1, true)
end)

script.Parent.FocusLost:Connect(function()
	if script.Parent.Text == "" then
		script.Parent.div:TweenSize(UDim2.new(0, 0,0.082, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.1, true)
		script.Parent.usernameText:TweenSize(UDim2.new(0.308, 0,1.524, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.1, true)
	end
end)

script.Parent.Parent.Parent.Parent.Scripts.clickHandler.pageChange.Event:Connect(function(req)
	if req == 'releaseFocus' then
		script.Parent.div:TweenSize(UDim2.new(0, 0,0.082, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.1, true)
		script.Parent.usernameText:TweenSize(UDim2.new(0.308, 0,1.524, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.1, true)
	end
end)

script.Parent:GetPropertyChangedSignal('Text'):Connect(function()
	script.Parent.Text = script.Parent.Text:gsub("%s","") 
	script.Parent.Text = script.Parent.Text:lower()
	if script.Parent.Text == "" then
		script.Parent.Parent.usernameFill.Visible = false
		script.Parent.Parent.usernameFill.Text = ""
		target = 'nawh'
	else 
		local found = false
		for i,v in pairs(game:GetService('Players'):GetPlayers()) do
			if string.sub(v.Name:lower(), 1, script.Parent.Text:len()) == script.Parent.Text then
				target = v
				script.Parent.Parent.usernameFill.Visible = true
				script.Parent.Parent.usernameFill.Text = v.Name:lower()
				script.Parent.Parent.Parent.Parent.Scripts.clickHandler.target.Value = v
				found = true
			end
		end
		if found == false then
			script.Parent.Parent.usernameFill.Text = ""
			script.Parent.Parent.Parent.Parent.Scripts.clickHandler.target.Value = nil
			target = 'nawh'
		end
	end
end)

game:GetService("UserInputService").InputBegan:connect(function(inputObject, gameProcessedEvent)
	if inputObject.KeyCode == Enum.KeyCode.Tab then --Also, could be written as [[inputObject.KeyCode == "R"]]
		if target ~= 'nawh' then
			task.wait(0.01)
			if script.Parent:IsFocused() then
				script.Parent.Text = target.Name
				if target.Name then
					script.Parent.CursorPosition = target.Name:len() + 1
				end
			end
		end
	end 
end)

script.Parent.clearTab.Event:Connect(function()
	target = 'nawh'
end)
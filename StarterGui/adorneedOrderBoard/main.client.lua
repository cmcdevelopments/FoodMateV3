--[[
░█████╗░███╗░░░███╗░█████╗░██████╗░███████╗██╗░░░██╗
██╔══██╗████╗░████║██╔══██╗██╔══██╗██╔════╝██║░░░██║
██║░░╚═╝██╔████╔██║██║░░╚═╝██║░░██║█████╗░░╚██╗░██╔╝
██║░░██╗██║╚██╔╝██║██║░░██╗██║░░██║██╔══╝░░░╚████╔╝░
╚█████╔╝██║░╚═╝░██║╚█████╔╝██████╔╝███████╗░░╚██╔╝░░
░╚════╝░╚═╝░░░░░╚═╝░╚════╝░╚═════╝░╚══════╝░░░╚═╝░░░
Developed by ChrisMC Developments | © CMCDEV 2022

Support Discord: https://discord.gg/NnhZDgznqc

Terms of use:
You may not claim this system as your own, the credits are all reserved to CMCDEV.
You may make changes to the system, no matter how heavy the percentage of our work ontop of yours is, you cannot claim it as your own.

Thank you for installing our system, lookout for updates!
]]

local function hasProperty(object, prop)
	local t = object[prop] --this is just done to check if the property existed, if it did nothing would happen, if it didn't an error will pop, the object[prop] is a different way of writing object.prop, (object.Transparency or object["Transparency"])
end

local getTheme = require(game.ReplicatedStorage.foodMateSetup).getTheme()

for i,v in pairs(script.Parent.orders:GetDescendants()) do
	if v.Name == "themeItem" then
		if v.Value == 'GRADIENT' then
			for int,val in pairs(v.Parent:GetChildren()) do
				if val.ClassName == "UIGradient" then
					val:Destroy()
				end
			end
			local clone = getTheme.UIGradient:Clone()
			clone.Parent = v.Parent
		else
			local success = pcall(function() hasProperty(v.Parent, v.Value) end) --this is the part checking if the transparency existed, make sure you write the property's name correctly

			if success then
				v.Parent[v.Value] = getTheme.gradientColour2
			else
				warn('Unable to find property '..v.Value..' in the type '..v.Parent.ClassName..' named '..v.Parent.Name..'. - FoodMate Theme Loader')
			end
		end
	end
end

local mainFrame = script.Parent.orders

game.ReplicatedStorage.foodMateSetup.remotes.orderDataUpdate.OnClientEvent:Connect(function(gathered)
	for i,val in pairs(gathered.currentOrders) do
		if mainFrame:FindFirstChild(i) == nil then
			local c = mainFrame.template:Clone()
			c.Parent = mainFrame
			local userId = val.customer.UserId
			local thumbType = Enum.ThumbnailType.HeadShot
			local thumbSize = Enum.ThumbnailSize.Size420x420
			local content, isReady = game.Players:GetUserThumbnailAsync(userId, thumbType, thumbSize)
			c.details.avatar.Image = content
			c.timer.LocalScript.count:Fire(val.submitTime)
			c.Name = i
			c.id.Text = '#'..string.sub(i, 1, 5)
			c.fullid.Text = i
			c.customer.Text = val.customer.Name
			c.cashier.Text = val.cashier.Name
			c.Visible = true
		else
			if val.claimed ~= false then
				mainFrame:FindFirstChild(i).claimed.claimer.Text = 'Claimed by '..val.claimed.Name
				mainFrame:FindFirstChild(i).claimed.Visible = true
			else
				mainFrame:FindFirstChild(i).claimed.Visible = false
			end
		end
	end
	for i, v in pairs(mainFrame:GetChildren()) do
		if v.ClassName == "TextButton" then
			if v.Name ~= 'template' then
				if gathered.currentOrders[v.Name] == nil then
					--print(v.Name)
					v:Destroy()
				end
			end
		end
	end
end)
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

task.wait(3)

local invokedToken = ""
game.ReplicatedStorage.foodMateSetup.remotes.invokeToken1.OnClientEvent:Connect(function(token)  -- Cashier and Chef have the same token, but they need seperate token senders so they can recieve the token at the same time :> 
	invokedToken = token
end)

local player = game:GetService("Players").LocalPlayer
local settingsModule = require(game.ReplicatedStorage.foodMateSetup)

local variables = {
	mainFrame = script.Parent.Parent:WaitForChild("mainFrame"),
	topBar = script.Parent.Parent.mainFrame:WaitForChild("topBar"),
	Camera = workspace:WaitForChild("Camera"),
	Draggable = false,
}

local services = {
	UserInputService = game:GetService("UserInputService"),
	Players = game:GetService("Players")
}

local DragMousePosition
local FramePosition

--Draggable
variables.topBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		variables.Draggable = true
		DragMousePosition = Vector2.new(input.Position.X, input.Position.Y)
		FramePosition = Vector2.new(variables.mainFrame.Position.X.Scale, variables.mainFrame.Position.Y.Scale)
	end
end)

variables.mainFrame.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		variables.Draggable = false
	end
end)

services.UserInputService.InputChanged:Connect(function(input)
	if variables.Draggable == true then
		local NewPosition = FramePosition + ((Vector2.new(input.Position.X, input.Position.Y) - DragMousePosition) / variables.Camera.ViewportSize)
		variables.mainFrame.Position = UDim2.new(NewPosition.X, 0, NewPosition.Y, 0)
	end
end)


script.Parent.Parent.mainFrame.sideBar.close.MouseButton1Click:Connect(function()
	script.Parent.Parent.Enabled = false
end)

game.Players.PlayerRemoving:Connect(function(plr)
	if script.customer.Value == plr then

	end
end)

local function hasProperty(object, prop)
	local t = object[prop] --this is just done to check if the property existed, if it did nothing would happen, if it didn't an error will pop, the object[prop] is a different way of writing object.prop, (object.Transparency or object["Transparency"])
end

local getTheme = settingsModule.getTheme()

for i,v in pairs(script.Parent.Parent.mainFrame:GetDescendants()) do
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

local mainFrame = script.Parent.Parent.mainFrame
local tweenService = game:GetService("TweenService")

script.pageChange.Event:Connect(function(req, page)
	if req == "changePage" then
		for i,v in pairs(mainFrame:GetChildren()) do
			if v.Name == 'hideText' then
				tweenService:Create(v, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {TextTransparency=1}):Play()
			end
		end
		for i,v in pairs(mainFrame.sideBar.pages:GetChildren()) do -- shush I know this is pointless... FOR NOW until I add more pages when I feel like adding things, probably when I get 9 trillion suggestions, I'll implement more stuff, tbh only if the system gets a lot of views... hopefully xd
			if v.ClassName == "TextButton" then
				if v ~= page then
					v:WaitForChild('changePage'):Fire('deselect')
				else
					v:WaitForChild('changePage'):Fire('select')
				end
				for i,v in pairs(mainFrame.Pages:GetChildren()) do
					if v.ClassName == 'CanvasGroup' then
						if v.Name == page.Name then
							v.GroupTransparency = 1
							v.Visible = true
							local tween = tweenService:Create(v, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {GroupTransparency=0})
							tween:Play()
						else
							local tween = tweenService:Create(v, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {GroupTransparency=1})
							tween:Play()
							tween.Completed:Connect(function() v.Visible = false end)
						end
					end
				end
			end
		end
	end
end)

mainFrame.sideBar.pages.orderScreen.MouseButton1Click:Connect(function()
	game.ReplicatedStorage.foodMateSetup.remotes.orderFunc:InvokeServer(invokedToken, 'getOrders')
end)

local currentlyBusy = false

local function viewOrder()
	if currentlyBusy == false then
		mainFrame.Pages.orderViewer.t1.Visible = true
		mainFrame.Pages.orderViewer.t2.Visible = true
		mainFrame.Pages.orderViewer.details.Visible = false
		for i,v in pairs(mainFrame.Pages.orderViewer.details.items:GetChildren()) do
			if v.ClassName == "Frame" then
				if v.Name ~= 'itemTemplate' then
					v:Destroy()
				end
			end
		end
	else
		script.pageChange:Fire('changePage', mainFrame.Pages.orderViewer)
		mainFrame.Pages.orderViewer.t1.Visible = false
		mainFrame.Pages.orderViewer.t2.Visible = false
		mainFrame.Pages.orderViewer.details.customer.Text = currentlyBusy.customer.Name
		mainFrame.Pages.orderViewer.details.cashier.Text = currentlyBusy.cashier.Name
		for i,v in pairs(currentlyBusy.items) do
			local c = mainFrame.Pages.orderViewer.details.items.itemTemplate:Clone()
			c.item.Text = v
			c.Name = v
			c.Parent = mainFrame.Pages.orderViewer.details.items
			c.Visible = true
		end
		mainFrame.Pages.orderViewer.details.Visible = true
	end
end



mainFrame.Pages.orderViewer.details.releaseClaim.MouseButton1Click:connect(function()
	script.pageChange:Fire('changePage', mainFrame.Pages.orderScreen)
	game.ReplicatedStorage.foodMateSetup.remotes.orderFunc:InvokeServer(invokedToken, 'updateOrder', currentlyBusy.id, false)
	currentlyBusy.customer.Character:WaitForChild('orderingSystemUi').Enabled = false
	currentlyBusy = false
	viewOrder()
end)

mainFrame.Pages.orderViewer.details.finish.MouseButton1Click:connect(function()
	script.pageChange:Fire('changePage', mainFrame.Pages.submitScreen)
	game.ReplicatedStorage.foodMateSetup.remotes.orderFunc:InvokeServer(invokedToken, 'completeOrder', currentlyBusy.id)
	currentlyBusy.customer.Character:WaitForChild('orderingSystemUi').Enabled = false
	currentlyBusy = false
	viewOrder()
end)

game.ReplicatedStorage.foodMateSetup.remotes.orderDataUpdate.OnClientEvent:Connect(function(gathered)
	local openOrderCount = 0
	local allOrders = 0
	for i,v in pairs(gathered.allOrders) do
		allOrders += 1
	end
	for i,v in pairs(gathered.currentOrders) do
		openOrderCount += 1
	end
	
	local function Format(Int)
		return string.format("%02i", Int)
	end

	local function msConvert(Seconds)
		local Minutes = (Seconds - Seconds%60)/60
		Seconds = Seconds - Minutes*60
		return Format(Minutes)..":"..Format(Seconds)
	end
	mainFrame.Pages.statusScreen.orderStats.openOrders.Text = openOrderCount
	mainFrame.Pages.statusScreen.orderStats.orderCount.Text = allOrders
	mainFrame.Pages.statusScreen.timeCompletion.averageCompletion.Text = msConvert(gathered.average)
	mainFrame.Pages.statusScreen.timeCompletion.lastOrderCompletion.Text = msConvert(gathered.lastOrder)
	for i,val in pairs(gathered.currentOrders) do
		if mainFrame.Pages.orderScreen.orders:FindFirstChild(i) == nil then
			local c = mainFrame.Pages.orderScreen.orders.template:Clone()
			c.Parent = mainFrame.Pages.orderScreen.orders
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
				mainFrame.Pages.orderScreen.orders:FindFirstChild(i).claimed.claimer.Text = 'Claimed by '..val.claimed.Name
				mainFrame.Pages.orderScreen.orders:FindFirstChild(i).claimed.Visible = true
			else
				mainFrame.Pages.orderScreen.orders:FindFirstChild(i).claimed.Visible = false
			end
		end
	end
	for i, v in pairs(mainFrame.Pages.orderScreen.orders:GetChildren()) do
		if v.ClassName == "TextButton" then
			if v.Name ~= 'template' then
				if gathered.currentOrders[v.Name] == nil then
					--print(v.Name)
					v:Destroy()
				end
			end
		end
	end

	for i,v in pairs(mainFrame.Pages.orderScreen.orders:GetChildren()) do
		if v.ClassName == 'TextButton'  then
			v.MouseButton1Click:Connect(function()
				local order = game.ReplicatedStorage.foodMateSetup.remotes.orderFunc:InvokeServer(invokedToken, 'getOrder', v.Name)
				if currentlyBusy == false and order.claimed == false then
					currentlyBusy = order
					
					game.ReplicatedStorage.foodMateSetup.remotes.orderFunc:InvokeServer(invokedToken, 'updateOrder', v.Name, game.Players.LocalPlayer)
					currentlyBusy.customer.Character:WaitForChild('orderingSystemUi').Enabled = true
					viewOrder()
				end
			end)
		end
	end

end)


game.ReplicatedStorage.foodMateSetup.remotes.orderFunc:InvokeServer(invokedToken, 'getOrders')





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

local invokedToken = ""
game.ReplicatedStorage.foodMateSetup.remotes.invokeToken2.OnClientEvent:Connect(function(token) -- Cashier and Chef have the same token, but they need seperate token senders so they can recieve the token at the same time :> 
	invokedToken = token
end)
repeat wait() until invokedToken ~= ""

script.Parent.Parent:GetPropertyChangedSignal('Enabled'):Connect(function()
	if script.Parent.Parent.Enabled == true then
		if game.Lighting.ClockTime >= 12 then
			script.Parent.Parent.mainFrame.playerSection.greetingText.Text = "Good morning,"
		else
			script.Parent.Parent.mainFrame.playerSection.greetingText.Text = "Good afternoon,"
		end
		if game.Lighting.ClockTime >= 17 then
			script.Parent.Parent.mainFrame.playerSection.greetingText.Text = 'Good evening,'
		end
	end
end)

if script.Parent.Parent.Enabled == true then
	if game.Lighting.ClockTime >= 12 then
		script.Parent.Parent.mainFrame.playerSection.greetingText.Text = "Good morning,"
	else
		script.Parent.Parent.mainFrame.playerSection.greetingText.Text = "Good afternoon,"
	end
	if game.Lighting.ClockTime >= 17 then
		script.Parent.Parent.mainFrame.playerSection.greetingText.Text = 'Good evening,'
	end
end


local player = game:GetService("Players").LocalPlayer
local settingsModule = require(game.ReplicatedStorage.foodMateSetup)

local variables = {
	mainFrame = script.Parent.Parent:WaitForChild("mainFrame"),
	topBar = script.Parent.Parent.mainFrame:WaitForChild("topBar"),
	Camera = workspace:WaitForChild("Camera"),
	Draggable = false
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

local items = {}

local orderingFrame = variables.mainFrame.orderingSection
local playerFrame = script.Parent.Parent.mainFrame.playerSection

script.Parent.Parent.mainFrame.sideBar.placeName.Text = settingsModule.PlaceName

local tweenService = game:GetService("TweenService")

local function instantFrameClear()
	script.customer.Value = nil
	playerFrame.Position = UDim2.new(0.65, 0,0.506, 0)
	playerFrame.Visible = true
	orderingFrame.Visible = false
	orderingFrame.servingPlayer.Text = ""
	for i,v in pairs(orderingFrame.categoryItems:GetChildren()) do
		if v.ClassName == "Frame" then
			v:Destroy()
		end
	end
	for i,v in pairs(orderingFrame.items:GetChildren()) do
		if v.ClassName == "Frame" then
			v:Destroy()
		end
	end
	for i,v in pairs(orderingFrame.categories:GetChildren()) do
		if v.ClassName == "TextButton" then
			v.fade:Fire('out')
		end
	end
	items = {}
end


local function clearOrderingFrame()
	script.customer.Value = nil
	tweenService:Create(orderingFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {GroupTransparency=1}):Play()
	task.wait(0.3)
	playerFrame.Position = UDim2.new(0.65, 0,-0.5, 0)
	playerFrame.GroupTransparency = 1
	playerFrame.Visible = true
	playerFrame:TweenPosition(UDim2.new(0.65, 0,0.506, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.7)
	tweenService:Create(playerFrame, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {GroupTransparency=0}):Play()
	task.wait(0.1)
	orderingFrame.Visible = false
	orderingFrame.servingPlayer.Text = ""
	for i,v in pairs(orderingFrame.categoryItems:GetChildren()) do
		if v.ClassName == "Frame" then
			v:Destroy()
		end
	end
	for i,v in pairs(orderingFrame.items:GetChildren()) do
		if v.ClassName == "Frame" then
			v:Destroy()
		end
	end
	for i,v in pairs(orderingFrame.categories:GetChildren()) do
		if v.ClassName == "TextButton" then
			v.fade:Fire('out')
		end
	end
	items = {}
end

script.Parent.Parent.mainFrame.sideBar.close.MouseButton1Click:Connect(function()
	script.Parent.Parent.Enabled = false
	instantFrameClear()
end)

script.buttonClick.Event:Connect(function(param1, param2, param3)
	if param1 == "categoryChange" then
		for i,v in pairs(orderingFrame.categories:GetChildren()) do
			if v.ClassName == "TextButton" then
				if v.Name == param2 then
					v.fade:Fire("in")
				else 
					v.fade:Fire("out")
				end
			end
		end

		for i,v in pairs(orderingFrame.categoryItems:GetChildren()) do
			if v.ClassName == "Frame" then
				v:Destroy()
			end
		end

		for i,v in pairs(settingsModule.Catagories[param2]) do
			local clone = orderingFrame.scrollingTemplates.categoryItemTemplate:Clone()
			clone.Name = v
			clone.TextLabel.Text = v
			clone.Parent = orderingFrame.categoryItems
			clone.Visible = true
		end
	end

	if param1 == "remItem"  then
		local find = table.find(items, param2)
		if find ~= nil then
			table.remove(items, find)
			param3:Destroy()
		else
			param3:Destroy()
		end
	end

	if param1 == "addItem" then
		if #items < settingsModule["Order Limit"] then
			table.insert(items, param2)
			local clone = orderingFrame.scrollingTemplates.itemTemplate:Clone()
			clone.Name = param2
			clone.TextLabel.Text = param2
			clone.Parent = orderingFrame.items
			clone.Visible = true
		else
			orderingFrame.errorText.Text = "Error, the maximum item limit is "..settingsModule["Order Limit"].."."
			orderingFrame.errorText.Visible = true
			task.wait(1)
			orderingFrame.errorText.Visible = false
		end
	end

	if param1 == "submit" then
		if game.Players:FindFirstChild(script.customer.Value.Name) ~= nil then
			if #items > 0 then
				local hashLib = require(game.ReplicatedStorage.foodMateSetup.cryptoMethod)
				local dt = DateTime.now()
				local code: string = hashLib.sha256('submitevent') -- Used to contain a different method, keeping the static key for extra bare security. / Other words: I know this is pointless, anybody can just run this through an encrypter online, but they need the invokedToken which changes every time something is submitted via that users token.
				local code2: string = hashLib.sha256(tostring(game.Players.LocalPlayer.UserId)) -- ^^^
				local function submit()
				game.ReplicatedStorage.foodMateSetup.remotes.orderSubmit:FireServer(code, code2, items, script.customer.Value, invokedToken)
				tweenService:Create(orderingFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {GroupTransparency=1}):Play()
				task.wait(0.4)
				orderingFrame.Visible = false
				script.Parent.Parent.mainFrame.submitScreen.Visible = true
				end
					
				if require(game.ReplicatedStorage.foodMateSetup).ProximityCheck == true then
					if script.customer.Value.Character.Humanoid.RigType == Enum.HumanoidRigType.R15  then
						if player:DistanceFromCharacter(script.customer.Value.Character:WaitForChild('UpperTorso').Position) < require(game.ReplicatedStorage.foodMateSetup).MaxActivationDistance then
							submit()
						else
							orderingFrame.errorText.Text = "Error, you must be close to the customer you're submitting an order for!"
							orderingFrame.errorText.Visible = true
							task.wait(1)
							orderingFrame.errorText.Visible = false
						end
						else
						if player:DistanceFromCharacter(script.customer.Value.Character:WaitForChild('Torso').Position) < require(game.ReplicatedStorage.foodMateSetup).MaxActivationDistance then
							submit()
						else
							orderingFrame.errorText.Text = "Error, you must be close to the customer you're submitting an order for!"
							orderingFrame.errorText.Visible = true
							task.wait(1)
							orderingFrame.errorText.Visible = false
						end
					end
				else
					submit()
				end
				
			else
				orderingFrame.errorText.Text = "Error, you cannot submit blank orders."
				orderingFrame.errorText.Visible = true
				task.wait(1)
				orderingFrame.errorText.Visible = false
			end
		else
			clearOrderingFrame()
		end
	end
end)

for i,v in pairs(settingsModule.Catagories) do
	local clone = orderingFrame.scrollingTemplates.categoryTemplate:Clone()
	clone.Name = i
	clone.Text = i
	clone.Parent = orderingFrame.categories
	clone.Visible = true
end

script.pageChange.Event:Connect(function(param1, param2, param3)
	if param1 == 'closeMenu' then
		script.Parent.Parent.Enabled = false
		if script.Parent.Parent.mainFrame.submitScreen.Visible == false then
			instantFrameClear()
		end
	end
	if param1 == "continueToOrder" then
		if script.target.Value ~= nil and game.Players:FindFirstChild(script.target.Value.Name) ~= nil then
			playerFrame.user.clearTab:Fire()
			playerFrame:TweenPosition(UDim2.new(1.35, 0,0.506, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.5, true)
			tweenService:Create(playerFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {GroupTransparency=1}):Play()
			task.wait(0.3)
			orderingFrame.servingPlayer.Text = script.target.Value.Name
			orderingFrame.GroupTransparency = 1
			tweenService:Create(orderingFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {GroupTransparency=0}):Play()
			orderingFrame.Visible = true
			task.wait(0.1)
			playerFrame.Visible = false
			playerFrame.GroupTransparency = 0
			playerFrame.Position = UDim2.new(0.65, 0,0.506, 0)
			script.customer.Value = script.target.Value
			playerFrame.user.Text = ""
			playerFrame.user:ReleaseFocus()
			script.pageChange:Fire("releaseFocus")
		end
	end
	if param1 == "loadDone" then
		clearOrderingFrame()
	end
	if param1 == "back" then
		clearOrderingFrame()
	end
end)

game.Players.PlayerRemoving:Connect(function(plr)
	if script.customer.Value == plr then
		clearOrderingFrame()
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
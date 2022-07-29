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

--[[
So what is this?
This is a token system used to secure client to server requests which is required with the cashier UI and chef UI as the clients need to tell the server what they are doing so the server can update other clients etc.
This system generates a token that even if you knew the way the token was generated, you'd still not be able to replicate the code as there is always a dynamic value, in this case 2 uuids ontop of multiple random numbers including the date with jumpled parameters.
But why secure simple remotes? Well would you like exploiters to mess with your system adding false orders OR even blocking new ones coming in by instantly sending a complete message to the server, best of all pretending to be another player making all the blame fall onto them when in reality, they did nothing and had their name written on all harm done.

]]

local hashLib = require(game.ReplicatedStorage.foodMateSetup.cryptoMethod)
local dt = DateTime.now()

local function generateToken(plr)
	if script.Parent.clientTokens:FindFirstChild(plr.UserId) ~= nil then
		script.Parent.clientTokens:WaitForChild(plr.UserId):Destroy()
	end
	local token: string = hashLib.sha256(DateTime.now():FormatUniversalTime("haMMYYDDYYYYHHMMMdd", "en-us")..game:GetService("HttpService"):GenerateGUID(false)..game:GetService("HttpService"):GenerateGUID(false)..math.random(0, 99999)..math.random(0, 99999)..math.random(0, 99999)..math.random(0, 99999)..math.random(0, 99999))
	local stringVal = Instance.new('StringValue')
	stringVal.Value = token
	stringVal.Name = plr.UserId
	stringVal.Parent = script.Parent.clientTokens
	game.ReplicatedStorage.foodMateSetup.remotes.invokeToken1:FireClient(plr, token)
	game.ReplicatedStorage.foodMateSetup.remotes.invokeToken2:FireClient(plr, token)
end

game.Players.PlayerAdded:Connect(function(plr)
	plr.CharacterAdded:Connect(function()
		if require(script.Parent.globalFunctions).rankCheck(plr, true) then
			generateToken(plr)
		else
			if require(script.Parent.globalFunctions).rankCheck(plr, false) then
				generateToken(plr)
			end
		end
	end)
end)

script.Parent.dynamicFunction.OnInvoke = function(req, param1)
	if req == "tokenGen" then
		generateToken(param1)
		return 'done'
	end
end
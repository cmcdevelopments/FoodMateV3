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

local replicated_storage = game:GetService("ReplicatedStorage");
local fms = replicated_storage.:WaitForChild("foodMateSetup")
local remotes = fms.remotes;

local hashLib = require(fms.cryptoMethod)
local dt = DateTime.now()

local function discordLog(items, cashier, customer)
	local function to_hex(color: Color3): string
		return string.format("%02X%02X%02X", color.R * 0xFF, color.G * 0xFF, color.B * 0xFF)
	end
	local colour = to_hex(require(game.ReplicatedStorage.foodMateSetup).getTheme().gradientColour2)
	require(script.Parent.Parent.foodMateServer.DiscordLogger).discordLog(colour, items, customer, cashier)
end

local function suspiciousRemote(suspect)
	warn('=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=')
	warn('ChrisMC Developments : FoodMate')
	warn('This can also be caused by a player submitting an order when the hour changes, this usually is only caused when the client isnt keeping up with the server such as a high ping.')
	warn('A suspicious remote has been sent from a client, the player the remote was sent as was '..suspect..'. THIS MAY OR MAY NOT BE THE PLAYER THAT INITIATED THE REQUEST, DO NOT PUNISH THIS PLAYER AS ANY EXPLOITERS CAN JUST CHANGE THE PLAYER SENT THROUGH.')
	warn('Please be on the lookout for exploiters.')
	warn('=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=')
end

remotes.serverTime.OnServerInvoke = function()
	return tick()
end

remotes.orderSubmit.OnServerEvent:Connect(function(plr, encode1, encode2, request, customer, playertoken)
	if plr ~= nil and encode1 ~= nil and encode2 ~= nil and request ~= nil and customer ~= nil and playertoken ~= nil then
		local code: string = hashLib.sha256('submitevent') -- Used to contain a different method, keeping the static key for extra bare security. / Other words: I know this is pointless, anybody can just run this through an encrypter online, but they need the invokedToken which changes every time something is submitted via that users token.
		local code2: string = hashLib.sha256(tostring(plr.UserId)) --- 			^^^^
		if script.Parent.clientTokens:FindFirstChild(plr.UserId).Value == playertoken then
			if encode1 == code then
				if encode2 == code2 then
					if require(script.Parent.Parent.foodMateServer).discordSettings.discordLogger == true then
						discordLog(request, plr.Name, customer.Name)
						end
					game.ReplicatedStorage.foodMateSetup.remotes.validSubmission:FireAllClients(request, plr, customer)
					game.ReplicatedStorage.foodMateSetup.remotes.validatedSubmission:Fire(request, plr, customer) -- Server sided communication submit
					local returnval = script.Parent.dynamicFunction:Invoke('tokenGen', plr)
					repeat task.wait() until returnval == 'done'
				else
					suspiciousRemote(plr.Name)
				end
			else
				suspiciousRemote(plr.Name)
			end
		else
			suspiciousRemote(plr.Name)
		end
	else
		suspiciousRemote('unknown player')
	end
end)
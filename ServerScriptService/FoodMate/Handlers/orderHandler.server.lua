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

local statistics = {
	allOrders = { -- all orders, why? bcuz the stats page will show how many ok cool by | its actually so we can make a order lookup via ID but ya... LATER ON DONT KILL ME CUZ I DIDNT ADD THIS QUICKER pls :'( 

	},
	completionTimes = {
		averageTimes = { -- All the completion times added up, only for fun :> JK only cuz I wanted an average completion time, why idk

		},
		lastOrder = 0 -- i dunno how long the last order took so it's 0 for now :> --> it changes later on dw dont edit this or ur system will be weird ok bye back to scripting
	},
}

local orders = {

}

local function calculateAvg(t)
	local total = 0
	for _, v in pairs(t) do
		total += v
	end
	return total / #t
end

local function suspiciousRemote(suspect, expected, got)
	if not suspect then return end
	warn('=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=')
	warn('ChrisMC Developments : FoodMate')
	warn('This can also be caused by a player submitting an order when the hour changes, this usually is only caused when the client isnt keeping up with the server such as a high ping.')
	warn('A suspicious remote has been sent from a client, the player the remote was sent as was '..suspect..'. THIS MAY OR MAY NOT BE THE PLAYER THAT INITIATED THE REQUEST, DO NOT PUNISH THIS PLAYER AS ANY EXPLOITERS CAN JUST CHANGE THE PLAYER SENT THROUGH.')
	warn('Please be on the lookout for exploiters.')
	warn('Got: '..got..' | Expected: '..expected)
	warn('=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=')
end

-- kill me alr this is the most tedious thing I've developed.... PLZ

local function loadOrders(plr)
	local gathered = {
		average = calculateAvg(statistics.completionTimes.averageTimes),
		lastOrder = statistics.completionTimes.lastOrder,
		allOrders = statistics.allOrders,
		currentOrders = orders
	}
	
	--bcuz some of u are sensitive abt ur order data getting to non staff members lmfaooo
	if not plr then
	for i,v in pairs(game.Players:GetPlayers()) do
		if require(script.Parent.globalFunctions).rankCheck(v, true) then
				game.ReplicatedStorage.foodMateSetup.remotes.orderDataUpdate:FireClient(v, gathered) -- woo hoo, no more exploiters getting how many muffins jenny ordered... cuz that really matters but security first ppl - lock those exploiters out
			else
				game.ReplicatedStorage.foodMateSetup.remotes.orderDataUpdate:FireClient(plr, gathered)
		end
		end
	end
end

game.ReplicatedStorage.foodMateSetup.remotes.orderFunc.OnServerInvoke = function (plr, playertoken, request,  p1, p2, p3, p4, p5, p6, p7, p8)
	if plr ~= nil and playertoken ~= nil and request ~= nil then
		if script.Parent.clientTokens:FindFirstChild(plr.UserId).Value == playertoken then
			if request == 'getStats' then
				local gathered = {
					average = calculateAvg(statistics.completionTimes.averageTimes),
					lastOrder = statistics.completionTimes.lastOrder,
					allOrders = statistics.allOrders,
					currentOrders = orders
				}
				return gathered

			end
			if request == 'getOrders' then
				local gathered = {
					average = calculateAvg(statistics.completionTimes.averageTimes),
					lastOrder = statistics.completionTimes.lastOrder,
					allOrders = statistics.allOrders,
					currentOrders = orders
				}
				loadOrders(plr)
				return gathered
			end
			
			if request == 'getOrder' then
				local found = false
				for i,v in pairs(orders) do
					if i == p1 then
						found = true
					end
				end
				if found == true then
					return orders[p1]
				else
					return 'notFound'
				end
			end
			
			if request == 'updateOrder' then
				if orders[p1] then
					if p2 == true then
						local found = 0
						for i,v in pairs(orders) do
							if v.claimed == plr then
								found = found + 1
							end
							if found == 0 then
								orders[p1].claimed = p2
							else
								print(found)
							end
						end
					else
						orders[p1].claimed = p2
						end
					end

					loadOrders()
				end
			end 
		if request == 'completeOrder' then
			if orders[p1] then
				table.insert(statistics.completionTimes.averageTimes, tick() - orders[p1].submitTime)
				statistics.completionTimes.lastOrder = tick() - orders[p1].submitTime
				game.ReplicatedStorage.foodMateSetup.remotes.orderComplete:Fire(orders[p1], plr)
				orders[p1] = nil
				loadOrders()
			else
				suspiciousRemote(plr.Name, script.Parent.clientTokens:FindFirstChild(plr.UserId).Value, playertoken)
			end

			local returnval = script.Parent.dynamicFunction:Invoke('tokenGen', plr)
			repeat task.wait() until returnval == 'done' 
	end
	else
		suspiciousRemote('unknown player')
	end
end

game.ReplicatedStorage.foodMateSetup.remotes.validatedSubmission.Event:Connect(function(items, cashier, customer)	
	local uuid : string = game:GetService('HttpService'):GenerateGUID(false)
	local template = {
		submitTime = tick(),
		claimed = false,
		items = items,
		cashier = cashier,
		customer = customer,
		id = uuid
	}
	orders[uuid] = template
	statistics.allOrders[uuid] = template
	loadOrders()
end)

game.Players.PlayerRemoving:Connect(function(plr)
	for i,v in pairs(orders) do
		if v.claimed == plr then
			v.claimed = false
			loadOrders()
		end
		if v.customer == plr then
			orders[i] = nil
			loadOrders()
		end
	end
end)
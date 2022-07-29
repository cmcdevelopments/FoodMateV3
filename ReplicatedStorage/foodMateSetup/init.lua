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

local Configuration = {
	["PlaceName"] = 'CMCDEV Testing Place', -- This will be displayed on the UI
	["Theme"] = "JazzBeats",
	["Order Limit"] = 3,
	["ProximityCheck"] = true, -- Upon order submission,  you must be within the studs below. (Default 15)
	["MaxActivationDistance"] = 20, -- How far away the proximity
	["Group"] = {
		["groupId"] = 0,
		["groupRank"] = 0,
		["minChefGroupRank"] = 0,
	},
	["Catagories"] = {
		["Breakfast"] = {
			"Avocado Toast w/ Tomato and Onion",
			"Eggs and Bacon",
			"\"Big Brekkie\"",
			"Gourmet Pancakes",
			"Eggs Benedict",
			"Willy Wonka's Chocolate Dessert",
		},
		["Lunch"] = {
			"Rib Eye Steak w/ Chips",
			"Rib Eye Steak w/ Salad",
			"Steak Wrap",
			"Vegan Burger",
			"Cheeseburger",
			"Hamburger",
		},
		["Sides"] = {
			"Small Chips",
			"Medium Chips",
			"Large Chips",
			"2x Hash Brown",
			"Mash Potatoes",
		},
	},
}

-- And you're done!
-- Thanks for being curious :)
function Configuration.getTheme()
	if script:FindFirstChild("Themes"):FindFirstChild(Configuration.Theme) then
		return {
			UIGradient = script.Themes:WaitForChild(Configuration.Theme),
			gradientColour2 = script.Themes:WaitForChild(Configuration.Theme).Color.Keypoints[2].Value
		}
	else
		return {
			UIGradient = script.Themes:WaitForChild('Bubbly Green'),
			gradientColor2 = script.Themes:WaitForChild('Bubbly Green').Color.Keypoints[2].Value 
		}
	end
end


return Configuration

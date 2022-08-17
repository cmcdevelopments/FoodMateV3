--[[


██╗██╗  ███╗░░██╗░█████╗░████████╗██╗░█████╗░███████╗  ██╗██╗
██║██║  ████╗░██║██╔══██╗╚══██╔══╝██║██╔══██╗██╔════╝  ██║██║
██║██║  ██╔██╗██║██║░░██║░░░██║░░░██║██║░░╚═╝█████╗░░  ██║██║
╚═╝╚═╝  ██║╚████║██║░░██║░░░██║░░░██║██║░░██╗██╔══╝░░  ╚═╝╚═╝
██╗██╗  ██║░╚███║╚█████╔╝░░░██║░░░██║╚█████╔╝███████╗  ██╗██╗
╚═╝╚═╝  ╚═╝░░╚══╝░╚════╝░░░░╚═╝░░░╚═╝░╚════╝░╚══════╝  ╚═╝╚═╝

Roblox --> Discord webhooks will only work in studio, you need your own webhook proxy if you wish to send webhooks.
You won't be given support for this system unless it's our code that fails. If you get any error other than a HTTP error you can contact us. [HTTP ERROR = FOR EXAMPLE HTTP THEN A NUMBER WHICH COULD BE HTTP 404 (Your webhook doesn't exist), HTTP 403 (forbidden request) and so many more !!]


]]


local module = {
	discordSettings = { -- TURN ON HTTP REQUESTS TO USE THIS
		discordLogger=false, -- If you wish to log your orderes to Discord, set this as true and configure the webhook below.
		discordWebhook="https://discord.com/api/webhooks/blahblahblah",
		embedColour=require(game.ReplicatedStorage.foodMateSetup).getTheme().gradientColour2, --If you don't want the colour to be the secondary colour of your chosen theme, just replace everything before the -- and after the = with Color3.fromRGB(0,0,0)
	}
	
}

return module

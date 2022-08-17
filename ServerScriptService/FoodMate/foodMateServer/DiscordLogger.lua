local module = {}

function module.discordLog(colour, items, customer, cashier)
	local itemsFormatted = table.concat(items, "\n")

	local template = {
		["content"] = "",
		["embeds"] = {{
			["title"] = "New Order",
			--['description'] = 'FoodMate Ordering Log',
			["type"] = "rich",
			["color"] = tonumber('0x'..colour),
			["fields"] = {
				{
					["name"] = "Customer",
					["value"] = customer,
					["inline"] = true
				},
				{
					["name"] = "Cashier",
					["value"] = cashier,
					["inline"] = true
				},
				{
					["name"] = "Contents",
					["value"] = itemsFormatted,
					["inline"] = false
				}
			}
		}}
	}
		game:GetService("HttpService"):PostAsync(require(script.Parent).discordSettings.discordWebhook, game:GetService("HttpService"):JSONEncode(template))
end

return module

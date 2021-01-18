local function GetTime()
	local date = os.date('*t')
	if date.day < 10 then date.day = '0' .. tostring(date.day) end
	if date.month < 10 then date.month = '0' .. tostring(date.month) end
	if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
	if date.min < 10 then date.min = '0' .. tostring(date.min) end
	if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end

	local date = date.day .. "/" .. date.month .. "/" .. date.year .. " - " .. date.hour .. " hour " .. date.min .. " min " .. date.sec .. " seconds"
	return date
end

local function LogsFunct(Color, Description, Webhook)
	local Content = {
	        {
	            ["color"] = Color,
	            ["title"] = iLogs.ServerName,
	            ["description"] = Description,
		        ["footer"] = {
	                ["text"] = GetTime(),
	                ["icon_url"] = iLogs.FooterLogo,
	            },
	        }
	    }
	PerformHttpRequest(Webhook, function() end, 'POST', json.encode({username = nil, embeds = Content}), { ['Content-Type'] = 'application/json' })
end

AddEventHandler("playerConnecting", function ()
	local identifier
	local NamePlayer = GetPlayerName(source)
	local IpJoueur = GetPlayerEndpoint(source)
	local steamhex = GetPlayerIdentifier(source)
	
	for k,v in ipairs(GetPlayerIdentifiers(source)) do
		if string.match(v, 'license:') then
			identifier = string.sub(v, 9)
			break
		end
	end
	LogsFunct(3066993, "**Nom :** "..NamePlayer.."\n**IP :** "..IpJoueur.."\n**License :** "..identifier.."\n**SteamHex :** "..steamhex, iLogs.Connecting)
end)

AddEventHandler('playerDropped', function()
	local identifier
	local NamePlayer = GetPlayerName(source)
	local IpJoueur = GetPlayerEndpoint(source)
	local steamhex = GetPlayerIdentifier(source)

	for k,v in ipairs(GetPlayerIdentifiers(source)) do
		if string.match(v, 'license:') then
			identifier = string.sub(v, 9)
			break
		end
	end
	LogsFunct(15158332, "**Nom :** "..NamePlayer.."\n**IP :** "..IpJoueur.."\n**License :** "..identifier.."\n**SteamHex :** "..steamhex, iLogs.Deconnected)
end)

AddEventHandler('onResourceStop', function (resourceName)
	Wait(50)
    LogsFunct(15158332, "**" ..resourceName.. "** a été **Arretter**", iLogs.ResourceStop)
end)

AddEventHandler('onResourceStart', function (resourceName)
	Wait(50)
    LogsFunct(3066993,"**" ..resourceName.. "** a été **Lancer** par ", iLogs.ResourceStart)
end)
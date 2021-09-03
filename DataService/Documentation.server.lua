--[[
Save Structure
	The SaveStructure module contains the default SaveStructure.
	To add something to the SaveStructure simply add an Item to the SaveStructure 
	table like this.We're going to add gems to the SaveStructure. And that's it it updates
	new and old player data structures
	
	local saveStructure = {
	Coins = 0;
	Xp = 0;
	Inventory = {};
	Gems = 0;
	
DataService:GetPlayerData(Player)
	Returns a player's data and will throw a warn if player is nil
	
	local PlayerData = DataService:GetPlayerData(Player)

	To edit the data you should not edit it directly you should use the next function
	of DataService which is SetPlayerData()
	
DataService:SetPlayerData(Player, ChangedData, Function)
	This sets the datakey to the value.

	local PlayerData = DataService:GetPlayerData(Player)

	DataService:SetPlayerData(Player, {"Coins"},   function()
        PlayerData.Coins = 100
    end)

DataService.DataChanged
	This event is fired whenever a player's data changes
	To connect this event simply do this.
	
	DataService.DataChanged:Connect(function(player, ChangedData)
		print(player.Name.. "'s data has been changed")
        print("ChangedData")

        if ChangedValues["Coins"] then
            print("Coins Changed")
        end
	end)
	
Do's and Don'ts
    If you want to update a value alot(Multiple times per second) and don't need to :Connect
    it to a change you can directly index it and edit it this will not call DataChanged and
    prevents :Connect from running or just update a variable to the value you wand and update
    the it on a differnt thread.
    
    local PlayerData = DataService:GetPlayerData(Player)
    PlayerData.LastLocation = Vector3.new(10, 01, 10)
    PlayerData["Last Location"] = Vector3.new(10, 01, 10)

    OR

    local location

    task.Spawn(function()
        local PlayerData = DataService:GetPlayerData(Player)
        wait(5)
        PlayerData["Last Location"] = location
    end)

    while wait() do 
        location = Vector3.new()
    end

    location might be updating 1000 times per second. But the actual cached data is only updated
    every 5 seconds and thus only calling the :Connect every 5 seconds.
    
Please see the basic DataServiceExampleService for a full code example
]]
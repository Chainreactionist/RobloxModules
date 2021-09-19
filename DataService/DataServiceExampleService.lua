--[[
local Knit = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Knit"))
local Players = game:GetService("Players")

local DataServiceExampleService = Knit.CreateService { Name = "DataServiceExampleService", Client = {} }

local DataService = Knit.GetService("DataService")

function DataServiceExampleService:KnitStart()
	--Waiting for you to join the game
	wait(10)
	
    local Player = Players:GetPlayers()[1]

	DataService.DataChanged:Connect(function(player, ChangedValues)
		print(player.Name .. "'s data has been changed")
        print(ChangedValues)
	end)

	local PlayerData = DataService:GetPlayerData(Player)

	DataService:SetPlayerData(Player, {"Coins"}, function()
        PlayerData.Coins = 100
    end)
end
]]
return DataServiceExampleService



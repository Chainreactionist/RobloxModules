local Knit = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Knit"))

local Players = game:GetService("Players")


local SaveStructure = require(script.SaveStructure)
local ProfileService = require(script.ProfileService)
local Signal = require(Knit.Util.Signal)


local DataService = Knit.CreateService { Name = "DataService", Client = {} }

function DataService.Client:GetPlayerData(Player)
    return DataService:GetPlayerData(Player)
end

DataService.DataChanged = Signal.new()

DataService.CachedProfiles = {}

function DataService:GetPlayerData(Player)
		assert(Player ~= nil ,"Object passed to GetPlayerData is nil")
		if DataService.CachedProfiles[Player.UserId] ~= nil then
			return DataService.CachedProfiles[Player.UserId].Data
		end
end

function DataService:SetPlayerData(Player, ChangedValues, Function)
		assert(Player ~= nil and Function ~= nil and ChangedValues ~= nil , "Object passed to GetPlayerData is nil")
		if DataService.CachedProfiles[Player.UserId] ~= nil then
            Function()
            DataService.DataChanged:Fire(Player, ChangedValues)
		end
end

function DataService:KnitInit()
	local PlayerProfileStore = ProfileService.GetProfileStore("PlayerSaveData" ,SaveStructure)

	local function PlayerAdded(player)
		local profile = PlayerProfileStore:LoadProfileAsync("Player_" .. player.UserId, "ForceLoad")

		if profile ~= nil then
            profile:AddUserId(player.UserId) 
			profile:Reconcile()
			profile:ListenToRelease(function()
				DataService.CachedProfiles[player.UserId] = nil
				player:Kick("Your profile has been loaded remotely. Please rejoin.")
			end)

			if player:IsDescendantOf(Players) then
				DataService.CachedProfiles[player.UserId] = profile
				print(player.Name .. "'s data is loaded")
			else
				profile:Release()
			end
		else
			player:Kick("Unable to load saved data. Please rejoin.")
		end
	end
	
	for _ , player in ipairs(Players:GetPlayers()) do
		task.spawn(function()
			PlayerAdded(player)
		end)
	end
	
	Players.PlayerAdded:Connect(PlayerAdded)
	
	Players.PlayerRemoving:Connect(function(player)
		local profile = DataService.CachedProfiles[player.UserId]
		if profile ~= nil then
			profile:Release()
		end
	end)
	
end

return DataService

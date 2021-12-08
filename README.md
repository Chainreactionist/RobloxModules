# RobloxModules

Just have fun lol :D

# Update
I've moved over to a custom player system. The Data is loaded and embeded in the custom player object.

# Info for advanced users

It's knit component that is applied to every player when they join and after every thing in the player is loaded, Data and Custom player properties like;

TempData = {
  Streak = 0
};

OtherInfo = 0

I'm using a service to apply this to every player and then fire my custom player added signal.

# Code Snippet from before I moved to using OOP

```lua
local PlayersTable = {}

function ObjectHasPropertyPromise(object:Instance, prop)
    return Promise.new(function(resolve, reject, onCancel)
        local t = object[prop]
        resolve()
    end)
end

local function PlayerAdded(Player:Player)
    if PlayersTable[Player] == nil then
        local PlayerTable = TableUtil.Copy(DataStructure)
        for Key, Value in pairs(DataStructure) do
            ObjectHasPropertyPromise(Player, Key):Then(function(Value)
                PlayerTable[Key] = Player[Key]
            end):Catch(function()
                PlayerTable[Key] = Value
            end)
        end
        if Player then
            PlayersTable[Player] = PlayerTable
            print(PlayersTable[Player])
        end
    end
end
```

I plan to make this open source when i'm done hopefully ;D

Also uhh don't use this data manager in a very large game. It's fine for story games and anime games where you're not doing many updates. But I don't think that might be an issue in this version. In the semi newer version of this I pass info to every changed event so if you're doing something like binding updating data to renderstepped  you would activate the check on every dataservice.DataChanged event. Just use this while you're getting good enough to make your own module. Hopefully by the time you need this my custom player object is out for Knit, Roblox-TS and of course Vanilla lua.

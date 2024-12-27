Features
Personal Stash Access:
Players can open their private stash using a nearby pillow object (v_med_pillow).

Police Stash Search:
Police officers can search other players' stashes with a 50% success chance. If successful, they can view the target player's stash.

Cooldown Mechanism:
Each stash search has a cooldown period of 20 minutes per player to prevent abuse.

Interactive Input:
Police must enter the player's ID using an input dialog to initiate a stash search.

Installation
Requirements:

A functional FiveM server with the QBCore framework installed.
qb-target for targeting interactions.
qb-input for input dialogs.
oxmysql for SQL integration.
An inventory script compatible with QBCore (e.g., qb-inventory).

## Dependencies

- qb-core - https://github.com/qbcore-framework/qb-core (Latest)
- qb-target - https://github.com/BerkieBb/qb-target



## Change Stash Item [j4-stash/client.lua]
```
Citizen.CreateThread(function()
    exports['qb-target']:AddTargetModel('v_med_pillow', {
        options = {
            {
                type = "client",
                event = "depo", 
                icon = "fas fa-box-open",
                label = "Depoyu aç", 
            },
            {
                type = "server",
                event = "j4-stash:server:SearchStash", 
                icon = "fas fa-search",
                label = "Başka birinin deposunu ara", 
                job = "police" 
            },
        },
        distance = 2.5 
    })
end)
```

exports['qb-target']:AddTargetModel('v_med_pillow', change your TargetModel
 


var global_pickup_id = 0;
var pickups = {};
var players = {};

RegisterServerEvent('esx_inventory:playerCoords')
AddEventHandler('esx_inventory:playerCoords', function(coords, forward) {
	if (players[source] == null) {
		players[source] = {}
    }

	players[source].coords = coords;
	players[source].forward = forward;
});

function createPickup(source, item, label) {
		if (players[source] == null || players[source].coords == null || players[source].forward == null) {
			console.log("Player coords unknown!");
			return false;
        	}

		global_pickup_id = global_pickup_id + 1;
		var pickup = {};
		var coords = {};
		coords.x = players[source].coords.x + players[source].forward.x * 0.2
		coords.y = players[source].coords.y + players[source].forward.y * 0.2
		coords.z = players[source].coords.z + players[source].forward.z * 0.2

		var DisintegrationZoneDist = Math.sqrt(Math.pow(-516.93 - coords.x,2) + Math.pow(-1714.29 - coords.y,2) + Math.pow(18.32 - coords.z,2))
		if (DisintegrationZoneDist < 2.5) {
			return true; // destroy item, do not create pickup
		}

		pickup.id = global_pickup_id
		pickup.prop = item.getProp()
		pickup.item = duplicateItem(item)
		pickup.label = label
		pickup.coords = coords
		pickup.source = source

		pickups[pickup.id] = pickup

		TriggerClientEvent('esx_inventory:createPickup', -1, global_pickup_id, pickup)
		return true
    }

function sendAllPickups(source) {
	for (var i in pickups) {
		var pickup = pickups[i];
		TriggerClientEvent('esx_inventory:createPickup', source, pickup.id, pickup);
	}
}


RegisterServerEvent('esx_inventory:onPickup');
AddEventHandler('esx_inventory:onPickup', function(id) {

		if (players[source] == null || players[source].coords == null || players[source].forward == null) {
			console.log("Player coords unknown!")
			return
		}

		var pickup  = pickups[id]
		var xPlayer = ESX.GetPlayerFromId(source)

		if (pickup == null) {
			console.log("Non-existent pickup id: " + id)
			return
		}

/*
		var dist = #(players[source].coords - pickup.coords)

		if (dist > 10) {
			console.log(string.format("Player %i is too far to get pickup %i", source, id))
			return
		}
*/

		TriggerClientEvent('esx_inventory:removePickup', -1, id)
		pickups[id] = null

		getInventory("pocket",xPlayer.identifier).addItem(pickup.item)
})

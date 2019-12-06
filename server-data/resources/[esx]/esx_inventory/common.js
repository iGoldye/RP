
let TriggerEvent = emit;
let TriggerClientEvent = emitNet;
let print = console.log;

function AddEventHandler(eventName, handler) {
    on(eventName, handler);
}

function RegisterServerEvent(text) {
    RegisterNetEvent(text);
}

function duplicateItem(item, modifiers) {
	var item2 = {}

	for (var k in item) {
		item2[k] = item[k]
    }

	if (modifiers != null) {
		for (var k in modifiers) {
			item2[k] = modifiers[k];
        }
    }

	return item2;
}

function tablesEqual(table1, table2) {
	if (table1 == null) {
		return table2 == null
    }

	if (table2 == null) {
		return false;
    }

	for (var k in table1) {
		if (table2[k] != table1[k]) {
			return false;
        }
    }

	for (var k in table2) {
		if (table1[k] != table2[k]) {
			return false;
        }
    }

	return true;
}

function tableSubtable(table1, table2) {
	if (table1 == null) {
		return table2 == null
    }

	if (table2 == null) {
		return false;
    }
/*
	for (var k in table1) {
		if (table2[k] != table1[k]) {
			return false;
        }
		}
		*/

	for (var k in table2) {
		if (table1[k] != table2[k]) {
			return false;
        }
    }

	return true;
}


function _U(key) {
	return global.Locales['en'][key];
}

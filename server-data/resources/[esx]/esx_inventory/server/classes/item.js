
var CreateItem = function(name, extra, amount) {
	if (ItemClasses[name] != null) {
		var myclass = ItemClasses[name];
		return new myclass(name, extra, amount);
	} else {
		return new Item_Abstract(name, extra, amount);
	}
}

var DeserializeItem = function(ser) {
	if (ser == null) {
		return null;
	}

	if (ser.serialize != null) {
		return ser;
	}

	if (typeof(ser) == "string") {
		ser = JSON.parse(ser);
	}

	return CreateItem(ser.name, ser.extra, ser.amount);
}

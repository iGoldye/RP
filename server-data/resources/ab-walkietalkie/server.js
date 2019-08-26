let ESX = null;

emit('esx:getSharedObject', (obj) => { ESX = obj });

ESX.RegisterServerCallback('ab-radio:getItemAmount', (source, cb, item) => {
  let player = ESX.GetPlayerFromId(source);

  if (player !== null) {
    let items = player.getInventoryItem(item);

    if (items === null || items.count === 0) {
      cb(0);
    } else {
      cb(items.count);
    }
  }
});
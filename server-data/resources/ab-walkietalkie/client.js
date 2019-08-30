let ESX = null;
let HasWT = false;
let GuiOpened = false;
let attachedPropRadio = 0;
let lastRadio = 0;
let playerServerId = GetPlayerServerId(PlayerId());

Delay = (ms) => new Promise(res => setTimeout(res, ms));

on('radioGui', () => {
    openGui();
});

on('destroyPropRadio', () => {
    removeAttachedPropRadio();
});

on('attachPropRadio', (attachModel, boneNumber, x, y, z, xR, yR, zR) => {
    let attachModelRadio;
    removeAttachedPropRadio();
    attachModelRadio = GetHashKey(attachModel);
    SetCurrentPedWeapon(GetPlayerPed(-1), 0xA2719263);
    let bone = GetPedBoneIndex(GetPlayerPed(-1), boneNumber);
    RequestModel(attachModelRadio);

    let HasModelLoadedLoop = setInterval(() => {
        HasModelLoadedLoopFunction()
    }, 10);

    function HasModelLoadedLoopFunction() {
        if (HasModelLoaded(attachModelRadio)) {
            attachRadio();
            clearInterval(HasModelLoadedLoop);
        }
    }

    function attachRadio() {
        attachedPropRadio = CreateObject(attachModelRadio, 1.0, 1.0, 1.0, 1, 1, 0);
        AttachEntityToEntity(attachedPropRadio, GetPlayerPed(-1), bone, x, y, z, xR, yR, zR, 1, 0, 0, 0, 2, 1);
    }
});

on('animation:radio', async (enable) => {
    let ped = GetPlayerPed(-1);
    let inRadio = enable;

    RequestAnimDict('cellphone@');
    let HasAnimDictLoadedLoop = setInterval(() => {
        HasAnimDictLoadedLoopFunction()
    }, 10);

    async function HasAnimDictLoadedLoopFunction() {
        if (!HasAnimDictLoaded('cellphone@')) {
            await Delay(1);
        } else {
            clearInterval(HasAnimDictLoadedLoop);
        }
    }

    // TODO: Если будут проблемы с анимацией запихнуть в луп.

    TaskPlayAnim(ped, 'cellphone@', 'cellphone_text_in', 2.0, 3.0, -1, 49, 0, 0, 0, 0);

    await Delay(300);
    if (inRadio) {
        emit('attachPropRadio', 'prop_cs_hand_radio', 57005, 0.14, 0.01, -0.02, 110.0, 120.0, -15.0);
        await Delay(150);
        if (!IsEntityPlayingAnim(ped, 'cellphone', 'cellphone_text_read_base', 3) && !IsEntityPlayingAnim(ped, 'cellphone', 'cellphone_swipe_screen', 3)) {
            TaskPlayAnim(ped, 'cellphone@', 'cellphone_text_read_base', 2.0, 3.0, -1, 49, 0, 0, 0, 0);
        }
    } else {
        await Delay(100);
        ClearPedTasks(GetPlayerPed(-1));
        TaskPlayAnim(ped, 'cellphone@', 'cellphone_text_out', 2.0, 1.0, 5.0, 49, 0, 0, 0, 0);
        await Delay(400);
        emit('destroyPropRadio');
        await Delay(400);
        ClearPedTasks(GetPlayerPed(-1));
    }
});

RegisterNuiCallbackType("close");
on("__cfx_nui:close", (data, cb) => {
    let testN = parseFloat(data.channel);
    let newChannel = Math.ceil(testN * 10);

    emitNet('TokoVoip:removePlayerFromRadio', lastRadio, playerServerId);
    if (newChannel !== 0) {
        emitNet('TokoVoip:addPlayerToRadio', newChannel, playerServerId);
    }
    lastRadio = newChannel;

    GuiOpened = false;
    SetNuiFocus(false, false);
    SendNuiMessage(JSON.stringify({open: false}));
    emit('animation:radio', GuiOpened);
});

onNet("ab-walkietalkie:phoneCallStartedCallback", function (){
    emitNet('TokoVoip:removePlayerFromRadio', lastRadio, playerServerId);
});

onNet("ab-walkietalkie:phoneCallEndedCallback", function (playerServerId){
    if (lastRadio !== 0) {
        emitNet('TokoVoip:addPlayerToRadio', lastRadio, playerServerId);
    }
});

setTick(() => {
    if (ESX === null) {
        emit('esx:getSharedObject', (obj) => { ESX = obj });
    }
});

setTick(() => {
    if (IsControlJustReleased(0, 168)) {
        hasWTItem((haswalkie) => {
            if (haswalkie) {
                emit('radioGui');
            }
        });
    }

    if (GuiOpened) {
        DisableControlAction(0, 1, GuiOpened);
        DisableControlAction(0, 2, GuiOpened);
        DisableControlAction(0, 14, GuiOpened);
        DisableControlAction(0, 15, GuiOpened);
        DisableControlAction(0, 16, GuiOpened);
        DisableControlAction(0, 17, GuiOpened);
        DisableControlAction(0, 99, GuiOpened);
        DisableControlAction(0, 100, GuiOpened);
        DisableControlAction(0, 106, GuiOpened);
        DisableControlAction(0, 115, GuiOpened);
        DisableControlAction(0, 116, GuiOpened);
        DisableControlAction(0, 142, GuiOpened);
    }
});

function hasWTItem(cb) {
    ESX.TriggerServerCallback('ab-radio:getItemAmount', (qt) => { cb(qt > 0) }, 'walkietalkie');
}

function removeAttachedPropRadio() {
    if (DoesEntityExist(attachedPropRadio)) {
        DeleteEntity(attachedPropRadio);
        attachedPropRadio = 0
    }
}

function openGui() {
    GuiOpened = !GuiOpened;
    emit('animation:radio', GuiOpened);

    if (GuiOpened) {
        SetNuiFocus(false, false);
        SetNuiFocus(true, true);
        SendNuiMessage(JSON.stringify({open: GuiOpened}));
    } else {
        SetNuiFocus(false, false);
        SendNuiMessage(JSON.stringify({open: GuiOpened}));
    }
}
<template>
  <v-app dark>
      <InputDialog ref="inputDialog" :title="inputBoxTitle" :hint="inputBoxHint" :active="input_dialog_active"></InputDialog>

      <Notifications ref="notifications" v-show="!hidden"></Notifications>
      <StateIcons v-show="!hidden"></StateIcons>

      <InventoryMenu
          ref="inventory"
          id="inventory"
          title="Инвентарь"
          :parent_disabled="inventory_disabled">
      </InventoryMenu>
  </v-app>
</template>

<script>
import InventoryMenu from './components/Inventory/InventoryMenu';
import InputDialog from './components/InputDialog';
import Notifications from './components/Notifications/Notifications';
import StateIcons from './components/StateIcons';


export default {
    name: 'App',
    ref: 'app',
    components: {
        InventoryMenu,
        InputDialog,
        Notifications,
        StateIcons,
    },

    watch: {
        state: function(val) {
            this.inventory_disabled = false;

            switch(val) {
                case "inventory":
                    this.$refs.inventory.show();
                    break;

                case "main":
                    this.$refs.inventory.hide();
                    break;

                case "modal":
                    this.inventory_disabled = true;
                    break;
            }
        }
    },

    data: function(){
        return {
            state: "main",
            hidden: false,
            input_dialog_active: false,
            inventory_disabled: false,

            inputBoxTitle: '',
            inputBoxHint: '',
        };
    },

    methods: {
        showInputBox: function(cb) {
            var prev_state = this.state;
            this.state = "modal";
            var that = this;

            this.$refs.inputDialog.show(function(text){
                cb(text);
                that.state = prev_state;
            });
        },

        showInventory: function(val) {
            if (val == true) {
                this.state = "inventory";
            } else if (this.state == "inventory"){
                this.state = "main";
            }
        },

        message: function(data) {
            switch(data.action) {

                    case 'showInventory':
                        this.showInventory(data.value);
                    break;

                    case 'showInputBox':
                        if (data.title) {
                        this.inputBoxTitle = data.title;
                        }else {
                        this.inputBoxTitle = 'Введите количество';
                        }
                        if (data.hint) {
                        this.inputBoxHint = data.hint;
                        } else {
                        this.inputBoxHint = 'Введите число';
                        }
                        this.showInputBox(function(text) {
                            data.text = text;
                            //this.console.log("input box returns: "+text);
                            window.post('http://sosamba_ui/inputbox', JSON.stringify(data));
                        });
                    break;

                    case 'status':
                        if (data.menuActive == false) {
                            this.state = "main";
                        }

                        this.hidden = data.hidden;
                    break;
            }
    },
  },

    created: function () {
        this.$eventHub.$on('message', this.message);
    },
    beforeDestroy() {
        this.$eventHub.$off('message');
    },
}
</script>

<style>

    html,body,#app {
        padding: 0;
        margin: 0;
        height: 100%;
        width: 100%;
        background: transparent;
        overflow-y: hidden !important;
        overflow: hidden !important;
    }

    div.tooltip {
        overflow: hidden;
    }

    .black-container {
        width: 100%;
        background-color: rgba(0, 0, 0, 0.5);
        padding: 10px;
        margin-bottom: 3px;
        order: 0;
        flex: 0 1 auto;
        align-self: auto;
        word-wrap:break-word;
    }

</style>
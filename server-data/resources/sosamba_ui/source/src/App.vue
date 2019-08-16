<template>
  <v-app dark>
      <InputDialog ref="inputDialog" :title="inputBoxTitle" :hint="inputBoxHint" :active="input_dialog_active"></InputDialog>

      <transition-group name="notifymove" id="notifications" tag="div">
        <Notification
          v-for="(notification) in notifications"
          :key="notification.id"
          :notification="notification"
          @expired="removeNotification(notification)"
          v-html="notification.text">
        </Notification>
      </transition-group>

      <div style="position: absolute; bottom:10px; left: 16%;">
        <v-icon ref="icon-armor" size="50px"  v-show="needs['armor']>0" v-bind:style="{ color: armorColor }">{{icons["shield-half-full"]}}</v-icon>
        <v-icon ref="icon-hunger" size="50px" v-show="needs['hunger']<0.5" v-bind:style="{ color: hungerColor }">{{icons["food"]}}</v-icon>
        <v-icon ref="icon-thirst" size="50px" v-show="needs['thirst']<0.5" v-bind:style="{ color: thirstColor }">{{icons["water"]}}</v-icon>
        <v-icon ref="icon-health" size="50px" v-show="needs['health']<0.9" v-bind:style="{ color: healthColor }">{{icons["medical-bag"]}}</v-icon>
      </div>

      <InventoryMenu
          ref="inventory"
          id="inventory"
          title="Инвентарь"
          :items="items"
          :parent_disabled="disabled"
          v-on:item_clicked="list_item_clicked">
      </InventoryMenu>
  </v-app>
</template>

<script>
import InventoryMenu from './components/InventoryMenu';
import InputDialog from './components/InputDialog';
import Notification from './components/Notification';
import { mdiFood, mdiWater, mdiMedicalBag, mdiShieldHalfFull } from '@mdi/js'


export default {
  name: 'App',
  ref: 'app',
  components: {
      InventoryMenu,
      InputDialog,
      Notification,
  },
  computed: {
    armorColor: function() {
      var alpha = this.needs["armor"];
      if (alpha === undefined) alpha = 0;

       return 'rgba(255,128,0, ' + alpha*0.7 + ')';
    },
    hungerColor: function() {
      var alpha = this.needs["hunger"];
      var thresh = 0.5;
      if (alpha > thresh) alpha = thresh;
      alpha = (thresh-alpha)/thresh;
      if (alpha === undefined) alpha = 0;
      return 'rgba(255,128,0, ' + alpha*0.7 + ')';
    },
    thirstColor: function() {
      var alpha = this.needs["thirst"];
      var thresh = 0.5;
      if (alpha > thresh) alpha = thresh;
      alpha = (thresh-alpha)/thresh;
      if (alpha === undefined) alpha = 0;
      return 'rgba(255,128,0, ' + alpha*0.7 + ')';
    },
    healthColor: function() {
      var red = 255 - this.needs["health"]*255;
      if (red < 0) {
        red = 0;
      }
      var green = this.needs["health"]*255.0;
      if (green>255) {
        green = 255;
      }

      var alpha = this.needs["health"];
      var thresh = 0.9;
      if (alpha > thresh) alpha = thresh;
      alpha = Math.sqrt((thresh-alpha)/thresh);
      if (alpha === undefined) alpha = 0;
      return 'rgba('+red+','+green+',0, ' + alpha*0.7 + ')';
    },
  },

  props: {
  },

  data: function(){
    return {
      items: {},
      input_dialog_active: false,
      disabled: false,

      inputBoxTitle: '',
      inputBoxHint: '',

      notificationIndex: 0,
      notifications: [],
      needs: {},
      icons: {
        "food": mdiFood,
        "water": mdiWater,
        "medical-bag": mdiMedicalBag,
        "shield-half-full": mdiShieldHalfFull,
      }
    };
  },

  methods: {

		createNotification(text){
			this.notifications.push({id: this.notificationIndex++, text: text})
		},
		removeNotification(notification) {
			this.notifications.splice(this.notifications.indexOf(notification), 1)
		},
    showInputBox: function(cb) {
        this.disabled = true;
        var that = this;

        this.$refs.inputDialog.show(function(text){
            cb(text);
            that.disabled = false;
        });
    },

    list_item_clicked: function(item) {
        var item2 = this.items[item.key];
        alert(JSON.stringify(item2));
    },
    gta_message: function(data) {

      switch(data.action) {
            case 'setNeeds':
                this.needs = data;
//                this.$refs["icon-hunger"].style.color = 'rgba(  0,128,255, '+this.needs.hunger+')';
              break;

            case 'showNotification':
                this.createNotification(data.text);
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

            case 'updateInventory':
                this.items = data.items;

                if (!this.items) {
                  this.items = {};
                }
              break;

            case 'showInventory':
                if (!this.items) {
                  this.items = {};
                }
        //        alert(JSON.stringify(data));
                this.$refs.inventory.show();
              break;

            case 'hideInventory':
                this.$refs.inventory.hide();
              break;

            case 'menuActive':
                var inv_shown = this.$refs.inventory.shown();
                if (data.value == true && !inv_shown ) {
                  this.$refs.inventory.show();
                } else
                if (data.value == false && inv_shown ) {
                  this.$refs.inventory.hide();
                }
              break;
      }
    },

    hide_inventory: function() {
        this.$refs["inventory"].hide();
    },
/*
    key_down: function(event) {
//        if (this.disabled == false && (event.keyCode == 8 || event.keyCode == 27)) { // BACKSPACE or ESC
//            this.$refs.inventory.back_clicked();
//        }
        //alert(event.keyCode);
      //   console.log(event.keyCode);
    },*/
  },

  created: function () {
      this.$eventHub.$on('gta_message', this.gta_message);
//      this.$eventHub.$on('key_down', this.key_down);
  },
  beforeDestroy() {
      this.$eventHub.$off('gta_message');
//      this.$eventHub.$off('key_down');
  },
}
</script>

<style>
/*
 else if (this.$refs["itemMenu"].shown())  { // in main menu
                    this.$refs["itemMenu"].hideDialog();
                }
  */


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

#notifications {
    position: absolute;
    top: 25%;
    bottom: 19%;
    width: 350px;
    min-height: 300px;

/*    font-family: 'Open Sans Semibold'; */
    font-size: 15px;
    color: white;

    display: flex;
    flex-direction: column;
    flex-wrap: nowrap;
    justify-content: flex-start;
    align-content: stretch;
    align-items: stretch;
}

.notification-container {
    width: 100%;
    background-color: rgba(0, 0, 0, 0.5);
    padding: 10px;
    margin-bottom: 3px;
    order: 0;
    flex: 0 1 auto;
    align-self: auto;
    word-wrap:break-word;
}

.notify-red {
	color: #F92652;
}
.notify-blue {
	color: #66D9EF;
}
.notify-green {
	color: #A6E22E;
}
.notify-yellow {
	color: #E6DB74;
}
.notify-purple {
	color: #AE81FF;
}
.notify-orange {
	color: #FD971F;
}
.notify-gray {
	color: #BCA3A3;
}
.notify-darkgray {
	color: #8F8F8F;
}
.notify-black {
	color: black;
}
.notify-white {
	color: white;
}
.notify-default {
	color: #F8F8F2;
	font-weight: normal;
}
.notify-bold {
	font-weight: bold;
}

.notifymove-enter-active {
  transition: all .5s;
}

.notifymove-leave-active {
  transition: all .5s;
}
.notifymove-enter, .notifymove-leave-to {
/*  opacity: 0;*/
  transform: translateX(-400px);
}

.notifymove-move {
  transition: transform 0.5s;
}

</style>
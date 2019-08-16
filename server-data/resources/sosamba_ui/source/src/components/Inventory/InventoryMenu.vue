<template>
<v-container>
    <v-layout v-show="shown()" style="position: absolute; right: 100px; top: 10%; width: 400px; height: 70%">
        <v-dialog scrollable modal max-width="400px" no-click-animation v-model="dialogVisible"
            content-class="inventory-dialog-content"
            transition="inventory-transition"
            :disabled="disabled"
            hide-overlay persistent>
                <ListMenu ref="actionMenu" title="Действия"
                        :items="currentActions"
                        :parent_disabled="disabled"
                        v-on:item_clicked="action_clicked"
                        v-on:back_clicked="back_clicked"
                        back_button
                >
                    <template v-for="(item,i) in currentActions" :slot="'content-'+i">
                        <v-list-item-avatar v-if="item.icon"
                            v-bind:key="'icon-'+i"
                        >
                            <v-icon v-html="icons[item.icon]"></v-icon>
                <!--            <v-img :src="item.icon"></v-img> -->
                        </v-list-item-avatar>
                        <v-list-item-content
                            v-bind:key="'content-'+i"
                        >
                            <v-list-item-title>{{item.label}}</v-list-item-title>
                            <v-list-item-subtitle></v-list-item-subtitle>
                        </v-list-item-content>
                    </template>

                </ListMenu>
                <ListMenu ref="itemMenu" title="Инвентарь"
                        :items="items"
                        :parent_disabled="disabled"
                        v-on:item_clicked="item_clicked"
                        v-on:back_clicked="back_clicked"
                        filter_title
                        back_button
                    >

                    <template v-for="(item,i) in items  " :slot="'avatar-'+i">
                        <InventoryItemAvatarPane
                            v-bind:key="'avatar-'+i"
                            :item="item"
                        >
                        </InventoryItemAvatarPane>
                    </template>

                    <template v-for="(item,i) in items  " :slot="'content-'+i">
                        <InventoryItemContentPane
                            v-bind:key="'content-'+i"
                            :item="item"
                        >
                        </InventoryItemContentPane>
                    </template>


                    <template v-for="(item,i) in items  " :slot="'action-'+i">
                        <InventoryItemActionPane
                            v-bind:key="'action-'+i"
                            :item="item"
                        >
                        </InventoryItemActionPane>
                    </template>
                </ListMenu>
        </v-dialog>
    </v-layout>
</v-container>
</template>

<script>
//    <InputDialog ref="inventoryInputDialog" title="Введите количество" hint="Введите число" :active="state == 'modal'"></InputDialog>
import ListMenu from '../ListMenu/ListMenu';
import InventoryItemActionPane from './InventoryItem/InventoryItemActionPane';
import InventoryItemContentPane from './InventoryItem/InventoryItemContentPane';
import InventoryItemAvatarPane from './InventoryItem/InventoryItemAvatarPane';

import { mdiCloseCircle, mdiKeyboardReturn } from '@mdi/js'

/*
function roundTo(value, decimals) {
    return Number(Math.round(value+'e'+decimals)+'e-'+decimals);
}*/

export default {
    components: {
      ListMenu,
      InventoryItemActionPane,
      InventoryItemContentPane,
      InventoryItemAvatarPane,
    },
    props: {
        parent_disabled: {
            type: Boolean,
            default: false,
        },
    },

    data: () => ({
        filter_string: "",
        state: "hide",
        _disabled: false,
        currentItem: null,
        currentActions: [],
        items: {},
        icons: {
            "close-circle": mdiCloseCircle,
            "keyboard-return": mdiKeyboardReturn,
        },
        dialogVisible: false,
    }),

    computed: {
        disabled: {
            get: function() {
                return this._disabled || this.parent_disabled;
            },
            set: function(val) {
                this._disabled = val;
            }
        }
    },

     watch: {
         currentItem: function(val) {
             this.actions = this.generate_actions(val);
         },
         disabled: function(new_state) {
//            this.console.log("Disabled state changed: "+new_state);
         },
         //state machine
        state: function (new_state/*, old_state*/) {
//            this.console.log("Inventory state changed to: "+new_state);
            this.dialogVisible = (new_state != "hide");

            this.$nextTick(function() {
                switch (new_state) {
                    case "items":
                            this.$refs["actionMenu"].hideDialog();
                            this.$refs["itemMenu"].showDialog();
                        break;

                    case "actions":
                        this.$refs["actionMenu"].showDialog();
                        this.$refs["itemMenu"].hideDialog();
                        break;

                    case "hide":
                        window.post('http://sosamba_ui/close');
                        this.$refs["actionMenu"].hideDialog();
                        this.$refs["itemMenu"].hideDialog();
                        break;

                    default:
                        this.console.error("Incorrect inventory state! State: "+this.state);
                }
            })
        }
    },

    methods: {
        message: function(data) {
            switch (data.action) {
                case 'updateInventory':
                    this.items = data.items;

                    if (!this.items) {
                        this.items = {};
                    }
                break;

            }
        },

        show: function() {
            if (this.state == "hide") {
                this.state = "items";
            }
        },

        hide: function() {
            this.state = "hide";
        },

        shown: function() {
            return this.state != "hide";
        },

        key_down: function(event) {
            if (this.state == "hide" || this.disabled == true) {
                return;
            }

            if (this.$refs.itemMenu.filter_focus) {
                return;
            }

            if (event.keyCode == 37) { // LEFT
                this.back_clicked();
            }

            if (event.keyCode == 39) { // RIGHT
                if (this.state == "items")  {
                    this.state = "actions";
                }
            }

            if (event.keyCode == 8 || event.keyCode == 27) { // BACKSPACE or ESC
                this.back_clicked();
            }
        },

        item_clicked: function(item, key) {
//            this.console.log("item_clicked "+item+" "+key);
            if (this.state == "hide" || this.disabled == true) {
                return;
            }

            if (!(key in this.items)) {
                this.console.error("Item not in list!");
                return;
            }
            this.currentItem = key;

            this.currentActions = [];

            for (var action in this.items[key].actions) {
                var aobj = this.items[key].actions[action];
                aobj.item = this.items[key].item;
                this.currentActions.push(aobj);
            }

            this.$refs["actionMenu"].$forceUpdate();
            this.state = "actions";
            this.$refs["actionMenu"].selection_set(0);
        },

        do_action: function(itemId, act) {
            if (act.name == "return") {
                return;
            }

            var str =JSON.stringify(act);
            window.post('http://sosamba_ui/do_action', str);
        },

        action_clicked: function(act) {
//            this.console.log("action_clicked");
            if (this.state == "hide" || this.disabled == true) {
                return;
            }

            if (act != null) {
                this.do_action(this.currentItem, act);
            }

            this.state = "items";
        },

        back_clicked: function() {
//            this.console.log("back_clicked");
            if (this.state == "hide" || this.disabled == true) {
                return;
            }

            if (this.state == "actions") {
                this.state = "items";
            } else if (this.state == "items") {
                this.state = "hide";
            }
        },

        generate_actions: function(itemKey) {
            var inv_item  = this.items[itemKey];

            if (inv_item == null) return [];

            var res = [];

            for (var key in inv_item.actions) {
                var act = inv_item.actions[key];

                res.push({
                    text: {
                        title: act.label,
                    },
                    icon: act.icon,
                    key: key,
                    item: inv_item.item,
                });
            }
            return res;
        },

        generate_items: function(elements) {
            var res = [];

            for (var key in elements) {
                var elem = elements[key];

                var subtitle_text = elem.description;
                var counter_html = "";
                if (elem.count>1) {
                    counter_html = '<span class="grey--text text--lighten-1"> x'+ elem.count +"</span>";
                }

                var right_text = "";

                res.push({
                    text: {
                        title: elem.label + counter_html,
                        subtitle: subtitle_text,
                        right: right_text,
                    },
                    key: key,
                    enter: false,
                });
            }

            return res;
        },
    },

    created: function () {
        this.$eventHub.$on('key_down', this.key_down);
        this.$eventHub.$on('message', this.message);
    },
    beforeDestroy() {
        this.$eventHub.$off('key_down');
        this.$eventHub.$off('message');
    },
};

</script>
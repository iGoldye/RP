<template>
      <v-card v-show="show" elevation="0"
        tile>
        <v-card-title class="pa-0">
        <v-toolbar dark :extended="description != ''" extension-height=32>
            <template v-if="description != ''" #extension>
                <v-toolbar-items>
                    <v-text-field
                        @focus="filter_focus = true"
                        @blur="filter_focus = false"
                        ref="filterField"
                        v-show="filter_title"
                        class="pt-0 mt-0"
                        label="Поиск"
                        append-icon="mdi-magnify"
                        height="30px"
                        style="width: 370px"
                        v-on:input="search_field_changed($event)"
                    ></v-text-field>
                </v-toolbar-items>
            </template>

          <v-btn v-show="back_button"
            v-on:click="$emit('back_clicked')"
            ref="backButton"
            small
            text
            icon
            color="white">
              <v-icon>{{mdi_arrow_left}}</v-icon>
          </v-btn>

          <v-toolbar-title style="user-select: none;">{{title}}</v-toolbar-title>
          <v-spacer></v-spacer>
          <v-toolbar-items>
            <span class="white--text title pa-4">{{description}}</span>
          </v-toolbar-items>
        </v-toolbar>
        </v-card-title>
        <v-card-text ref="list-card-text">
        <v-list nav >
            <v-list-item-group v-model="selected_index" color="primary">
            <TextListItem
                ref="list-item"
                v-for="(item,i) in items"
                :key="i"
                :item="item"
                v-on:click="$emit('item_clicked', item, i)"
                :value="i"
                v-show="filtered(item)"
            >
                <template v-slot:avatar>
                    <slot :name="'avatar-'+i"></slot>
                </template>

                <template v-slot:content>
                    <slot :name="'content-'+i"></slot>
                </template>

                <template v-slot:action>
                    <slot :name="'action-'+i"></slot>
                </template>

            </TextListItem>
            </v-list-item-group>
        </v-list>
        </v-card-text>
      </v-card>
</template>

<script>
import TextListItem from './TextListItem';
import { mdiArrowLeft } from '@mdi/js'

export default {
    components: {
      TextListItem,
    },
    props: {
        title:{
            type: String,
            default: ""
        },

        description: {
            type: String,
            default: "",
        },

        items:{
//            type: Array,
            default:  () => { return []; },
        },

        filter_title: {
            type: Boolean,
            default: false,
        },

        parent_disabled: {
            type: Boolean,
            default: false,
        },

        back_button: {
            type: Boolean,
            default: false,
        },
    },

    data: () => ({
        selected_index: 0,
        show: false,
        filter_string: "",
        filter_focus: false,
        _disabled: false,

// icons
        mdi_arrow_left: mdiArrowLeft,
    }),

    computed: {
        disabled: {
            get: function() {
                return this._disabled || this.parent_disabled || !this.shown();
            },
            set: function(val) {
                this._disabled = val;
            }
        }
    },

    watch: {
        show: function(val) {
            this.$nextTick(function() {
                if (this.$refs["backButton"]) {
                    this.$refs["backButton"].$el.blur();
                }
            });
        },
    },

    methods: {
        key_down: function(event) {
            if (this.disabled) return;

            if (event.keyCode == 38) {
                this.selection_prev();
            }

            if (event.keyCode == 40) {
                this.selection_next();
            }

            if (event.keyCode == 13) {
                this.selection_apply();
            }
        },

        shown: function() {
            return this.show;
        },

        showDialog: function() {
            this.show = true;
        },

        hideDialog: function() {
            this.show = false;
        },

        filterItems: function(items) {
            if (items === undefined) {
                this.console.error("ListMenu: undefined items in filter!");
                return {};
            }
            if (items.filter == undefined) {
                return {};
            }

            var filtered = items.filter(item => this.filtered(item));
            return filtered;
        },

        filtered: function(item) {
            return new String(item.label).toLowerCase().includes(this.filter_string.toLowerCase());
        },

        search_field_changed: function(text) {
            this.selected_index = 0;
            this.filter_string = text;
        },

        toString: function(i) {
            return i.toString();
        },

        moveScroll: function() {
            if (!this.selected_index) {
                this.selected_index = 0;
            }

            if (this.items.length <= this.selected_index || this.selected_index < 0) {
                return;
            }

            if (this.$refs["list-item"]) {
                var comp = this.$refs["list-item"][this.selected_index];
                this.$refs["list-card-text"].scrollTop = comp.$el.offsetTop;
            }

        },

        selection_set: function(val) {
            this.selected_index = val;
            this.moveScroll();
        },

        selection_next: function() {
            if (this.disabled) return;

            if (this.selected_index < this.items.length-1) {
                this.selected_index = this.selected_index + 1;
            }
            this.moveScroll();
        },

        selection_prev: function() {
            if (this.disabled) return;

            if (this.selected_index > 0) {
                this.selected_index = this.selected_index - 1;
            }
            this.moveScroll();
        },

        selection_apply: function() {
            if (this.disabled) return;

            var item = this.items[this.selected_index];
            if (item) {
                this.$emit('item_clicked', item, this.selected_index);
            }
        }
    },

    created: function () {
        this.$eventHub.$on('key_down', this.key_down);
    },
    beforeDestroy() {
        this.$eventHub.$off('key_down');
    },
};
</script>

<style>
.inventory-dialog-content {
    position: absolute;
    right: 100px;
    top: 3%;
    width: 400px;
    height: 85%;
}
</style>
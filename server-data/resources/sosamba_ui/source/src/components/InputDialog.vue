<template>
  <v-layout justify-center>
    <v-dialog v-model="active" persistent modal max-width="290" ref="dialog">
      <v-card>
        <v-card-title class="title">{{title}}</v-card-title>
        <v-card-text>
            <v-text-field :label="hint" ref="textfield" v-if="active" v-model="text" autofocus></v-text-field>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="green darken-1" text @click="hide()">OK</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-layout>
</template>

<script>
export default {
    props: {
        title: {
            type: String,
            default: "",
        },
        hint: {
            type: String,
            default: "",
        },
    },

    data () {
      return {
        callback: undefined,
        active: false,
        text: "",
      }
    },

    methods: {
        key_down: function(event) {
          if (this.active == false) {
            return;
          }
          if (event.key == "Enter") {
            this.hide();
          }
        },

        show: function(callback) {
            this.callback = callback;
            this.active = true;
            data.text = "";

            this.$refs.textfield.$el.click();

            this.$nextTick(function() {
                this.$refs.textfield.$el.click();
            })
        },

        hide: function() {
            this.active = false;
            if (this.callback) {
                this.callback(data.text);
            }
        },

    },

    created: function () {
        this.$eventHub.$on('key_down', this.key_down);
    },

    beforeDestroy() {
        this.$eventHub.$off('key_down');
    },

}

</script>


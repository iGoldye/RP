<template>

      <div style="position: absolute; bottom:10px; left: 16%;">
        <v-icon ref="icon-seatbelt" size="50px"  v-show="needs['seatbelt']>0" v-bind:style="{ color: 'rgba(255,0,0,0.5)' }">{{icons["seatbelt"]}}</v-icon>
        <v-icon ref="icon-armor" size="50px"  v-show="needs['armor']>0" v-bind:style="{ color: armorColor }">{{icons["shield-half-full"]}}</v-icon>
        <v-icon ref="icon-hunger" size="50px" v-show="needs['hunger']<0.3" v-bind:style="{ color: hungerColor }">{{icons["food"]}}</v-icon>
        <v-icon ref="icon-thirst" size="50px" v-show="needs['thirst']<0.3" v-bind:style="{ color: thirstColor }">{{icons["water"]}}</v-icon>
        <v-icon ref="icon-health" size="50px" v-show="needs['health']<0.9" v-bind:style="{ color: healthColor }">{{icons["medical-bag"]}}</v-icon>
      </div>

</template>

<script>
import { mdiFood, mdiWater, mdiMedicalBag, mdiShieldHalfFull, mdiSeatbelt } from '@mdi/js';


export default {
    data: function() {
        return {
            icons: {
                "food": mdiFood,
                "water": mdiWater,
                "medical-bag": mdiMedicalBag,
                "shield-half-full": mdiShieldHalfFull,
                "seatbelt": mdiSeatbelt,
            },

            needs: {},
        }
    },

    methods: {
        message: function(data) {
            if (data.action == 'setNeeds') {
                this.needs = data;
            }
        }
    },

    computed: {
        armorColor: function() {
            var alpha = this.needs["armor"];
            if (alpha === undefined) alpha = 0;

            return 'rgba(255,128,0, ' + Math.floor(alpha*0.7*255)/255.0 + ')';
        },
        hungerColor: function() {
            var alpha = this.needs["hunger"];
            var thresh = 0.3;
            if (alpha > thresh) alpha = thresh;
            alpha = (thresh-alpha)/thresh;
            if (alpha === undefined) alpha = 0;

            var green = Math.floor(this.needs["hunger"]*255.0);

            return 'rgba(255,'+Math.floor(green)+',0, ' + Math.floor(alpha*0.7*255)/255.0 + ')';
        },
        thirstColor: function() {
            var alpha = this.needs["thirst"];
            var thresh = 0.3;
            if (alpha > thresh) alpha = thresh;
            alpha = (thresh-alpha)/thresh;
            if (alpha === undefined) alpha = 0;

            var green = this.needs["thirst"]*255.0

            return 'rgba(255,'+Math.floor(green)+',0, ' + Math.floor(alpha*0.7*255)/255.0 + ')';
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
            return 'rgba('+Math.floor(red)+','+Math.floor(green)+',0, ' + Math.floor(alpha*0.7*255)/255.0 + ')';
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

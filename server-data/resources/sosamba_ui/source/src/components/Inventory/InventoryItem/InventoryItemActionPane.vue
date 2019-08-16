<template>
             <v-list-item-action>
               <v-list-item-action-text class="font-weight-medium">
                       <v-layout align-end justify-space-around column fill-height>
                        <v-flex v-if="item.name === 'money' || item.name === 'account_money'  || item.name === 'black_money'">
                            <v-flex class='subtitle-1 text-end green--text text--darken-2'>$ {{formatted_money(item.count)}}</v-flex>
                        </v-flex>
                        <v-flex v-else>
                            <v-flex v-show="item.weight >= 0.005" class='text-end'>{{item.weight}} кг</v-flex>
                            <v-flex v-show="(item.name === 'weapon' || item.name === 'equipped_weapon') && !item.melee">
                                <v-icon dense small>{{ mdi_bullet }}</v-icon><span class="mt-1">{{item.ammo}}</span>
                            </v-flex>
                        </v-flex>
                    </v-layout>
               </v-list-item-action-text>
             </v-list-item-action>
</template>

<script>
 import { mdiBullet } from '@mdi/js'

export default {
    data: () => ({
        mdi_bullet: mdiBullet,
    }),
    props: {
        item: {
            default: null,
        },
    },
    methods: {
        formatted_money: function(val) {
            return number_format(val, val >= 10 ? 0:2, '.', ' ')
        }
    }
}

function number_format(number, decimals, dec_point, thousands_sep) {
    var n = !isFinite(+number) ? 0 : +number, 
        prec = !isFinite(+decimals) ? 0 : Math.abs(decimals),
        sep = (typeof thousands_sep === 'undefined') ? ',' : thousands_sep,
        dec = (typeof dec_point === 'undefined') ? '.' : dec_point,
        toFixedFix = function (n, prec) {
            // Fix for IE parseFloat(0.55).toFixed(0) = 0;
            var k = Math.pow(10, prec);
            return Math.round(n * k) / k;
        },
        s = (prec ? toFixedFix(n, prec) : Math.round(n)).toString().split('.');
    if (s[0].length > 3) {
        s[0] = s[0].replace(/\B(?=(?:\d{3})+(?!\d))/g, sep);
    }
    if ((s[1] || '').length < prec) {
        s[1] = s[1] || '';
        s[1] += new Array(prec - s[1].length + 1).join('0');
    }
    return s.join(dec);
}
</script>

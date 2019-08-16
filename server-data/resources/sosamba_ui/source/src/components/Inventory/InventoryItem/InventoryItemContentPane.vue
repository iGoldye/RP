<template>
           <v-list-item-content>
            <v-list-item-title>
                <span class="font-weight-medium blue-grey--text text--darken-4" v-html="item.label"></span>
                <span class="grey--text text--lighten-1" 
                    v-show="item.count > 1 && item.name != 'money' && item.name != 'account_money' && item.name != 'black_money'"> x{{item.count}}</span>
            </v-list-item-title>
            <v-list-item-subtitle>{{item.description}}</v-list-item-subtitle>
            </v-list-item-content>
</template>

<script>
 import { mdiAmmunition } from '@mdi/js'

export default {
    data: () => ({
        mdi_ammunition: mdiAmmunition,
    }),
    props: {
        item: {
            default: null,
        },
    },
    methods: {
    }
}

</script>

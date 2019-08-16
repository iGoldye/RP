<template>
          <v-list-item-avatar v-if="item.icon">
            <v-icon>{{item.icon}}</v-icon>
<!--            <v-img :src="item.icon"></v-img> -->
          </v-list-item-avatar>
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

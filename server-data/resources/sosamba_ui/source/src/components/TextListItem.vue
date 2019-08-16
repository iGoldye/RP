<template>
        <v-list-item         
            :item="item"
            v-on:click="$emit('click')"
            :value="value"
          >

          <slot name="avatar"></slot>
          <slot name="content"></slot>
          <slot name="action"></slot>
        </v-list-item>
</template>

<script>
export default {
  props: {
        item: {
          type: Object,
          default: () => {},
        },
        onclick: {
          type: Object,
          default: null,
        },
        value:{
          type:Number,
          default: 0,
        },
      },
  data: () => ({
    
    }),
    methods: {
    }
};
</script>

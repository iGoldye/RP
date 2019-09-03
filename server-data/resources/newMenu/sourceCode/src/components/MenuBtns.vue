<template lang="pug">
  .menu__submenu
    a.menu__submenu-item(href='#', v-for='item in elements')
</template>

<script>
export default {
  name: "MenuBtns",
  data() {
    return {
      elements: {}
    };
  },
  methods: {
    open(namespace, name, data) {
      this.elements = data;
      console.log(this.elements);
    }
  }
};
</script>

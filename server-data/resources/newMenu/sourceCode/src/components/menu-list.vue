<template lang="pug">
  .menu__wrapper-standalone
    .menu__list
      .menu__list-head
        p.menu__list-header Паспорт
      .menu__list-body
        a.menu__list-item(href='#', v-for='item in elements')
</template>

<script>
export default {
  name: "MenuList",
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

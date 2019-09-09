<template lang="pug">
  .menu__wrapper
    .menu__wrapper-standalone
      .menu__list
        .menu__list-head
          p.menu__list-header {{ header }}
        .menu__list-body
          a.menu__list-item(:href="'#' + item.value", v-for='(item, index) in elements' :data-index="index" :key='item')
            span(v-html='item.label')
</template>

<style lang="scss">
@import "menu.scss";
</style>

<script>
import axios from "axios";

export default {
  name: "MenuList",
  data() {
    return {
      elements: {},
      header: {},
      namespace: {},
      name: {},
      mockData: {}
    };
  },
  mounted() {
    window.addEventListener("message", event => {
      if (event.data.action == "openMenu") {
        this.open(event.data.namespace, event.data.name, event.data.data);
      }
      if (event.data.action == "closeMenu") {
        this.close();
      }
      this.$nextTick(() => {
        this.focus(event);
      });
    });
  },
  methods: {
    open(namespace, name, data) {
      this.elements = data.elements;
      this.header = data.title;
      this.namespace = namespace;
      this.name = name;
      this.mockData = data;

      document.querySelector(".menu__list").classList.add("is-active");

      this.$nextTick(() => {
        document.querySelector(".menu__list-body").firstChild.focus();
        document
          .querySelector(".menu__list-body")
          .firstChild.classList.add("is-active");
      });
    },
    menu_change() {
      axios
        .post(
          "http://menu-list/menu_change",
          JSON.stringify({
            _namespace: this.namespace,
            _name: this.name,
            current: this.mockData,
            elements: this.elements
          })
        )
        .then(response => {
          // console.log(response);
        })
        .catch(error => {
          // console.log(error.response);
        });
    },
    menu_submit() {
      axios
        .post(
          "http://menu-list/menu_submit",
          JSON.stringify({
            _namespace: this.namespace,
            _name: this.name,
            current: this.elements[document.activeElement.dataset.index],
            elements: this.elements
          })
        )
        .then(response => {
          // console.log(response);
        })
        .catch(error => {
          // console.log(error.response);
        });
    },
    menu_cancel() {
      axios
        .post(
          "http://menu-list/menu_cancel",
          JSON.stringify({
            _namespace: this.namespace,
            _name: this.name
          })
        )
        .then(response => {
          // console.log(response);
        })
        .catch(error => {
          // console.log(error.response);
        });
    },
    close() {
      document.querySelector(".menu__list").classList.remove("is-active");
    },
    focus(event) {
      let mainMenu = document.querySelector(".menu__list-body");
      let next = document.activeElement.nextSibling;
      let prev = document.activeElement.previousSibling;
      let items = document.querySelectorAll(".menu__list-item");
      let targets = this.elements;

      if (
        document.querySelector(".menu__list").classList.contains("is-active")
      ) {
        switch (event.data.action) {
          case "closeMenu":
            this.close();
            break;
          case "controlPressed":
            switch (event.data.control) {
              case "DOWN":
                if (next) {
                  items.forEach(item => {
                    item.classList.remove("is-active");
                  });
                  next.focus();
                  document.activeElement.classList.add("is-active");
                  this.menu_change();
                  targets.forEach(target => {
                    target.selected = false;
                  });
                  this.elements[next.dataset.index].selected = true;
                }
                break;
              case "TOP":
                if (prev) {
                  items.forEach(item => {
                    item.classList.remove("is-active");
                  });
                  prev.focus();
                  document.activeElement.classList.add("is-active");
                  this.menu_change();
                  targets.forEach(target => {
                    target.selected = false;
                  });
                  this.elements[prev.dataset.index].selected = true;
                }
                break;
              case "ENTER":
                this.menu_submit();
                this.$nextTick(() => {
                  // items.forEach(item => {
                  //   item.classList.remove("is-active");
                  // });
                  // mainMenu.children[0].focus();
                  // mainMenu.children[0].classList.add("is-active");
                });
                break;
              case "BACKSPACE":
                this.close();
                break;
            }
        }
      }
    }
  }
};
</script>

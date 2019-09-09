<template lang="pug">
  .skincreator__wrapper
    .skincreator__outer
      .tab__wrapper
        a.tab__link(href='#', v-for='tab in tabs', :data-link='tab.link', :class="[tab.name, { active : tab.isActive}]") {{ tab.label }}
      .tab__content-wrapper
        .tab__content(v-for='tab in tabs', :class="['tab-'+ tab.link, { active : tab.isActive}]")
          .tab__outer(v-if="tab.name == 'face'")
            h2.tab__header {{ tab.header }}
            .tab__group
              h3.tab__group-header Отец
              label.tab__group(v-for='(father, index) in fathers', :for="'father-' + index", class='parent__group')
                input(type='radio', name='father', :value='father.value', :id="'father-' + index", class='parent-input', :checked='father.isChecked')
                img.parent-img(:src='father.img')
            .tab__group
              h3.tab__group-header Мать
              label.tab__group(v-for='(mother, index) in mothers', :for="'mother-' + index", class='parent__group')
                input(type='radio', name='mother', :value='mother.value', :id="'mother-' + index", class='parent-input', :checked='mother.isChecked')
                img.parent-img(:src='mother.img')
            .tab__group
              h3.tab__group-header Генетика Отец / Мать
              .range__wrapper
                input(type='range', min='0', max='16', value='8', class='range')
                .range--arrows
                  input(type='button', value='<', class='range--arrows__button')
                  input(type='button', value='>', class='range--arrows__button')



</template>

<style lang="scss" scoped>
@import "../scss/style";
</style>

<script>
export default {
  name: "SkinCreator",
  data() {
    return {
      activeClass: "is-active",
      tabs: [
        {
          name: "face",
          label: "Лицо",
          link: "face",
          activeClass: "is-active",
          isActive: true,
          header: "Морфология"
        },
        {
          name: "hair",
          label: "Волосы",
          link: "hair",
          activeClass: "is-active",
          isActive: false,
          header: "Морфология"
        },
        {
          name: "clothes",
          label: "Одежда",
          link: "clothes",
          activeClass: "is-active",
          isActive: false,
          header: "Морфология"
        }
      ],
      fathers: [
        {
          value: 0,
          img: "./assets/img/heritage/Face-0.jpg",
          isChecked: true
        },
        {
          value: 1,
          img: "./assets/img/heritage/Face-1.jpg",
          isChecked: false
        },
        {
          value: 2,
          img: "./assets/img/heritage/Face-2.jpg",
          isChecked: false
        },
        {
          value: 3,
          img: "./assets/img/heritage/Face-3.jpg",
          isChecked: false
        },
        {
          value: 4,
          img: "./assets/img/heritage/Face-4.jpg",
          isChecked: false
        },
        {
          value: 5,
          img: "./assets/img/heritage/Face-5.jpg",
          isChecked: false
        },
        {
          value: 6,
          img: "./assets/img/heritage/Face-6.jpg",
          isChecked: false
        },
        {
          value: 7,
          img: "./assets/img/heritage/Face-7.jpg",
          isChecked: false
        },
        {
          value: 8,
          img: "./assets/img/heritage/Face-8.jpg",
          isChecked: false
        },
        {
          value: 9,
          img: "./assets/img/heritage/Face-9.jpg",
          isChecked: false
        },
        {
          value: 10,
          img: "./assets/img/heritage/Face-10.jpg",
          isChecked: false
        },
        {
          value: 11,
          img: "./assets/img/heritage/Face-11.jpg",
          isChecked: false
        },
        {
          value: 12,
          img: "./assets/img/heritage/Face-12.jpg",
          isChecked: false
        },
        {
          value: 13,
          img: "./assets/img/heritage/Face-13.jpg",
          isChecked: false
        },
        {
          value: 14,
          img: "./assets/img/heritage/Face-14.jpg",
          isChecked: false
        },
        {
          value: 15,
          img: "./assets/img/heritage/Face-15.jpg",
          isChecked: false
        },
        {
          value: 16,
          img: "./assets/img/heritage/Face-16.jpg",
          isChecked: false
        },
        {
          value: 17,
          img: "./assets/img/heritage/Face-17.jpg",
          isChecked: false
        },
        {
          value: 18,
          img: "./assets/img/heritage/Face-18.jpg",
          isChecked: false
        },
        {
          value: 19,
          img: "./assets/img/heritage/Face-19.jpg",
          isChecked: false
        },
        {
          value: 20,
          img: "./assets/img/heritage/Face-20.jpg",
          isChecked: false
        },
        {
          value: 20,
          img: "./assets/img/heritage/Face-20.jpg",
          isChecked: false
        },
        {
          value: 42,
          img: "./assets/img/heritage/Face-42.jpg",
          isChecked: false
        },
        {
          value: 43,
          img: "./assets/img/heritage/Face-43.jpg",
          isChecked: false
        },
        {
          value: 44,
          img: "./assets/img/heritage/Face-44.jpg",
          isChecked: false
        }
      ],
      mothers: [
        {
          value: 21,
          img: "./assets/img/heritage/Face-21.jpg",
          isChecked: false
        },
        {
          value: 22,
          img: "./assets/img/heritage/Face-22.jpg",
          isChecked: false
        },
        {
          value: 23,
          img: "./assets/img/heritage/Face-23.jpg",
          isChecked: false
        },
        {
          value: 24,
          img: "./assets/img/heritage/Face-24.jpg",
          isChecked: false
        },
        {
          value: 25,
          img: "./assets/img/heritage/Face-25.jpg",
          isChecked: false
        },
        {
          value: 26,
          img: "./assets/img/heritage/Face-26.jpg",
          isChecked: false
        },
        {
          value: 27,
          img: "./assets/img/heritage/Face-27.jpg",
          isChecked: false
        },
        {
          value: 28,
          img: "./assets/img/heritage/Face-28.jpg",
          isChecked: false
        },
        {
          value: 29,
          img: "./assets/img/heritage/Face-29.jpg",
          isChecked: false
        },
        {
          value: 30,
          img: "./assets/img/heritage/Face-30.jpg",
          isChecked: false
        },
        {
          value: 31,
          img: "./assets/img/heritage/Face-31.jpg",
          isChecked: false
        },
        {
          value: 32,
          img: "./assets/img/heritage/Face-32.jpg",
          isChecked: false
        },
        {
          value: 33,
          img: "./assets/img/heritage/Face-33.jpg",
          isChecked: false
        },
        {
          value: 34,
          img: "./assets/img/heritage/Face-34.jpg",
          isChecked: false
        },
        {
          value: 35,
          img: "./assets/img/heritage/Face-35.jpg",
          isChecked: false
        },
        {
          value: 36,
          img: "./assets/img/heritage/Face-36.jpg",
          isChecked: false
        },
        {
          value: 37,
          img: "./assets/img/heritage/Face-37.jpg",
          isChecked: false
        },
        {
          value: 38,
          img: "./assets/img/heritage/Face-38.jpg",
          isChecked: false
        },
        {
          value: 39,
          img: "./assets/img/heritage/Face-39.jpg",
          isChecked: false
        },
        {
          value: 40,
          img: "./assets/img/heritage/Face-40.jpg",
          isChecked: false
        },
        {
          value: 41,
          img: "./assets/img/heritage/Face-41.jpg",
          isChecked: false
        },
        {
          value: 45,
          img: "./assets/img/heritage/Face-45.jpg",
          isChecked: false
        }
      ]
    };
  }
};
</script>

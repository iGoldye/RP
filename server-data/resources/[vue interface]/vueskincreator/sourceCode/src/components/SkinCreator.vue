<template lang="pug">
  .skincreator__wrapper
    form.skincreator__outer
      .tab__wrapper
        a.tab__link(href='#', v-for='tab in tabs', :data-link='tab.link', :name="tab.name", :class="[tab.name, { active : tab.isActive}]", @click='switchPane') {{ tab.label }}
      .tab__content-wrapper
        .tab__content(v-for='tab in tabs', :class="{ active : tab.isActive}", :id="'tab-' + tab.link")
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
                input(type='range', :min='genetics.min', :max='genetics.max', step='1', class='range', v-model='genetics.value', :name='genetics.name')
                .range--arrows
                  input(type='button', value='<', class='range--arrows__button', @click='genetics.value > genetics.min ? genetics.value-- : genetics.min')
                  input(type='button', value='>', class='range--arrows__button', @click='genetics.value < genetics.max ? genetics.value++ : genetics.max')
            .tab__group
              h3.tab__group-header Цвет глаз
              .radio__wrapper
                label.radio__outer(v-for="color in eyeColors", :for="'eye'+color.id")
                  input(type='radio', name='eyecolor', class='radio', :checked='color.checked', :value='color.value', :id="'eye'+color.id")
                  span.radio__color(:data-color='color.color')
            h2.tab__header Кожа
            .tab__group
              h3.tab__group-header Цвет кожи
              .radio__wrapper
                label.radio__outer(v-for="color in skinColors", :for="'skin'+color.id")
                  input(type='radio', name='skincolor', class='radio', :checked='color.checked', :value='color.value', :id="'skin'+color.id")
                  span.radio__color(:data-color='color.color')
            .tab__group(v-for='item in skinGroupSliders')
              .tab__group-head
                h3.tab__group-header {{ item.header }}
                .tab__group-legend
                  span.tab__group-legend-current {{ item.value }}
                  | /
                  span.tab__group-legend-total {{ item.max }}
              .range__wrapper
                input(type='range', :min='item.min', :max='item.max', step='1', class='range', v-model='item.value', :name='item.name')
                .range--arrows
                  input(type='button', value='<', class='range--arrows__button ', @click='item.value > item.min ? item.value-- : item.min')
                  input(type='button', value='>', class='range--arrows__button ', @click='item.value < item.max ? item.value++ : item.max')
            h2.tab__header Лицо
            .tab__group(v-for='item in faceGroupSliders')
              .tab__group-head
                h3.tab__group-header {{ item.header }}
                .tab__group-legend
                  span.tab__group-legend-current {{ item.value }}
                  | /
                  span.tab__group-legend-total {{ item.max }}
              .range__wrapper
                input(type='range', :min='item.min', :max='item.max', step='1', class='range', v-model='item.value', :name='item.name')
                .range--arrows
                  input(type='button', value='<', class='range--arrows__button ', @click='item.value > item.min ? item.value-- : item.min')
                  input(type='button', value='>', class='range--arrows__button ', @click='item.value < item.max ? item.value++ : item.max')
          .tab__outer(v-if="tab.name == 'hair'")
            h2.tab__header {{ tab.header }}
            .tab__group
              h3.tab__group-header Цвет волос
              .radio__wrapper
                label.radio__outer(v-for="color in hairColors", :for="'hair'+color.id")
                  input(type='radio', name='haircolor', class='radio', :checked='color.checked', :value='color.value', :id="'hair'+color.id")
                  span.radio__color(:data-color='color.color')
            .tab__group(v-for='item in hairGroupSliders')
              .tab__group-head
                h3.tab__group-header {{ item.header }}
                .tab__group-legend
                  span.tab__group-legend-current {{ item.value }}
                  | /
                  span.tab__group-legend-total {{ item.max }}
              .range__wrapper
                input(type='range', :min='item.min', :max='item.max', step='1', class='range', v-model='item.value', :name='item.name')
                .range--arrows
                  input(type='button', value='<', class='range--arrows__button ', @click='item.value > item.min ? item.value-- : item.min')
                  input(type='button', value='>', class='range--arrows__button ', @click='item.value < item.max ? item.value++ : item.max')
            .tab__group
              h3.tab__group-header Цвет бороды
              .radio__wrapper
                label.radio__outer(v-for="color in beardColors", :for="'beard'+color.id")
                  input(type='radio', name='beardcolor', class='radio', :checked='color.checked', :value='color.value', :id="'beard'+color.id")
                  span.radio__color(:data-color='color.color')
          .tab__outer(v-if="tab.name == 'clothes'")
            h2.tab__header {{ tab.header }}
            .tab__group(v-for='item in clothesGroupSliders')
              .tab__group-head
                h3.tab__group-header {{ item.header }}
                .tab__group-legend
                  span.tab__group-legend-current {{ item.value }}
                  | /
                  span.tab__group-legend-total {{ item.max }}
              .range__wrapper
                input(type='range', :min='item.min', :max='item.max', step='1', class='range', v-model='item.value', :name='item.name')
                .range--arrows
                  input(type='button', value='<', class='range--arrows__button ', @click='item.value > item.min ? item.value-- : item.min')
                  input(type='button', value='>', class='range--arrows__button ', @click='item.value < item.max ? item.value++ : item.max')
      .skincreator__submit
        button.skincreator__submit-btn(type='button') Применить

</template>

<style lang="scss">
@import "../scss/style";
</style>

<script>
import axios from "axios";

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
          header: "Волосы"
        },
        {
          name: "clothes",
          label: "Одежда",
          link: "clothes",
          activeClass: "is-active",
          isActive: false,
          header: "Одежда"
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
          isChecked: true
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
      ],
      genetics: {
        value: 5,
        min: 0,
        max: 10,
        name: "genetics"
      },
      eyeColors: [
        {
          value: 0,
          id: 1,
          color: "#525e37",
          checked: true
        },
        {
          value: 1,
          id: 2,
          color: "#263419",
          checked: false
        },
        {
          value: 2,
          id: 3,
          color: "#83b7d5",
          checked: false
        },
        {
          value: 3,
          id: 4,
          color: "#3e66a3",
          checked: false
        },
        {
          value: 4,
          id: 5,
          color: "#8d6833",
          checked: false
        },
        {
          value: 5,
          id: 6,
          color: "#523711",
          checked: false
        },
        {
          value: 6,
          id: 7,
          color: "#d08418",
          checked: false
        },
        {
          value: 8,
          id: 9,
          color: "#bebebe",
          checked: false
        },
        {
          value: 12,
          id: 13,
          color: "#0d0d0c",
          checked: false
        }
      ],
      skinColors: [
        {
          value: 12,
          id: 1,
          color: "#ecc8ae",
          checked: true
        },
        {
          value: 25,
          id: 2,
          color: "#ce9874",
          checked: false
        },
        {
          value: 19,
          id: 3,
          color: "#925a41",
          checked: false
        },
        {
          value: 14,
          id: 4,
          color: "#4e3a26",
          checked: false
        }
      ],
      skinGroupSliders: [
        {
          name: "acne",
          header: "Угри",
          value: 0,
          min: 0,
          max: 23
        },
        {
          name: "skinProblems",
          header: "Проблемы кожи",
          value: 0,
          min: 0,
          max: 23
        },
        {
          name: "freckles",
          header: "Веснушки",
          value: 0,
          min: 0,
          max: 17
        },
        {
          name: "wrinkles",
          header: "Морщины",
          value: 0,
          min: 0,
          max: 14
        },
        {
          name: "wrinklesDepth",
          header: "Глубина морщин",
          value: 0,
          min: 0,
          max: 10
        }
      ],
      hairColors: [
        {
          value: 0,
          id: 1,
          color: "#1D1D1A",
          checked: true
        },
        {
          value: 2,
          id: 2,
          color: "#4B392D",
          checked: false
        },
        {
          value: 4,
          id: 3,
          color: "#7A3B1F",
          checked: false
        },
        {
          value: 6,
          id: 4,
          color: "#A35631",
          checked: false
        },
        {
          value: 8,
          id: 5,
          color: "#A96F49",
          checked: false
        },
        {
          value: 10,
          id: 6,
          color: "#A96F49",
          checked: false
        },
        {
          value: 12,
          id: 7,
          color: "#CBA66F",
          checked: false
        },
        {
          value: 14,
          id: 8,
          color: "#E8BE78",
          checked: false
        },
        {
          value: 16,
          id: 9,
          color: "#D09E6A",
          checked: false
        },
        {
          value: 18,
          id: 10,
          color: "#993524",
          checked: false
        },
        {
          value: 20,
          id: 11,
          color: "#9C1611",
          checked: false
        },
        {
          value: 22,
          id: 12,
          color: "#D1381E",
          checked: false
        },
        {
          value: 24,
          id: 13,
          color: "#C85831",
          checked: false
        },
        {
          value: 26,
          id: 14,
          color: "#947A67",
          checked: false
        },
        {
          value: 28,
          id: 15,
          color: "#D8C1AC",
          checked: false
        },
        {
          value: 30,
          id: 16,
          color: "#734F61",
          checked: false
        },
        {
          value: 32,
          id: 17,
          color: "#AD476A",
          checked: false
        },
        {
          value: 35,
          id: 18,
          color: "#FFAEBC",
          checked: false
        },
        {
          value: 36,
          id: 19,
          color: "#089A8D",
          checked: false
        },
        {
          value: 40,
          id: 20,
          color: "#309060",
          checked: false
        },
        {
          value: 43,
          id: 21,
          color: "#A3C015",
          checked: false
        },
        {
          value: 45,
          id: 22,
          color: "#EEC85C",
          checked: false
        },
        {
          value: 48,
          id: 23,
          color: "#FE8B10",
          checked: false
        },
        {
          value: 53,
          id: 24,
          color: "#D40B0E",
          checked: false
        }
      ],
      hairGroupSliders: [
        {
          name: "hairstyle",
          header: "Прическа",
          value: 0,
          min: 0,
          max: 74
        },
        {
          name: "eyebrowsShape",
          header: "Форма бровей",
          value: 0,
          min: 0,
          max: 34
        },
        {
          name: "eyebrowsTickness",
          header: "Толщина бровей",
          value: 0,
          min: 0,
          max: 10
        },
        {
          name: "beardType",
          header: "Тип бороды",
          value: 0,
          min: 0,
          max: 28
        },
        {
          name: "beardTickness",
          header: "Толщина бороды",
          value: 0,
          min: 0,
          max: 10
        }
      ],
      beardColors: [
        {
          value: 0,
          id: 1,
          color: "#1D1D1A",
          checked: true
        },
        {
          value: 2,
          id: 2,
          color: "#4B392D",
          checked: false
        },
        {
          value: 4,
          id: 3,
          color: "#7A3B1F",
          checked: false
        },
        {
          value: 6,
          id: 4,
          color: "#A35631",
          checked: false
        },
        {
          value: 8,
          id: 5,
          color: "#A96F49",
          checked: false
        },
        {
          value: 10,
          id: 6,
          color: "#BD8D5E",
          checked: false
        },
        {
          value: 12,
          id: 7,
          color: "#CBA66F",
          checked: false
        },
        {
          value: 14,
          id: 8,
          color: "#E8BE78",
          checked: false
        },
        {
          value: 16,
          id: 9,
          color: "#D09E6A",
          checked: false
        },
        {
          value: 24,
          id: 13,
          color: "#C85831",
          checked: false
        },
        {
          value: 26,
          id: 14,
          color: "#947A67",
          checked: false
        },
        {
          value: 28,
          id: 15,
          color: "#D8C1AC",
          checked: false
        }
      ],
      clothesGroupSliders: [
        {
          name: "head",
          header: "Голова",
          value: 0,
          min: 0,
          max: 32
        },
        {
          name: "glass",
          header: "Очки",
          value: 0,
          min: 0,
          max: 11
        },
        {
          name: "bejelwes",
          header: "Бижутерия",
          value: 0,
          min: 0,
          max: 15
        },
        {
          name: "shirts",
          header: "Верхняя одежда",
          value: 0,
          min: 0,
          max: 118
        },
        {
          name: "pants",
          header: "Штаны",
          value: 0,
          min: 0,
          max: 57
        },
        {
          name: "shoes",
          header: "Обувь",
          value: 0,
          min: 0,
          max: 50
        },
        {
          name: "watches",
          header: "Часы",
          value: 0,
          min: 0,
          max: 7
        }
      ],
      faceGroupSliders: [
        {
          name: "nose_width",
          header: "Ширина носа",
          value: 0,
          min: -10,
          max: 10
        },
        {
          name: "nose_peak_height",
          header: "Длина носа",
          value: 0,
          min: -10,
          max: 10
        },
        {
          name: "nose_peak_length",
          header: "Выступ кончика носа",
          value: 0,
          min: -10,
          max: 10
        },
        {
          name: "nose_peak_lowering",
          header: "Высота кончика носа",
          value: 0,
          min: -10,
          max: 10
        },
        {
          name: "nose_bone_height",
          header: "Высота переносицы",
          value: 0,
          min: -10,
          max: 10
        },
        {
          name: "nose_peak_twist",
          header: "Искривление носа",
          value: 0,
          min: -10,
          max: 10
        },
        {
          name: "eyebrow_height",
          header: "Высота бровей",
          value: 0,
          min: -10,
          max: 10
        },
        {
          name: "eyebrow_forward",
          header: "Выступ бровей",
          value: 0,
          min: -10,
          max: 10
        },
        {
          name: "cheeks_bone_height",
          header: "Высота скул",
          value: 0,
          min: -10,
          max: 10
        },
        {
          name: "cheeks_bone_width",
          header: "Ширина скул",
          value: 0,
          min: -10,
          max: 10
        },
        {
          name: "cheeks_width",
          header: "Полнота щек",
          value: 0,
          min: -10,
          max: 10
        },
        {
          name: "eyes_opening",
          header: "Разрез глаз",
          value: 0,
          min: -10,
          max: 10
        },
        {
          name: "lips_thickness",
          header: "Полнота губ",
          value: 0,
          min: -10,
          max: 10
        },
        {
          name: "jaw_bone_width",
          header: "Ширина челюсти",
          value: 0,
          min: -10,
          max: 10
        },
        {
          name: "jaw_bone_back_length",
          header: "Высота челюсти",
          value: 0,
          min: -10,
          max: 10
        },
        {
          name: "jaw_bone_back_length",
          header: "Подчелюстной выступ",
          value: 0,
          min: -10,
          max: 10
        },
        {
          name: "chimp_bone_lowering",
          header: "Высота подбородка",
          value: 0,
          min: -10,
          max: 10
        },
        {
          name: "chimp_bone_length",
          header: "Длина подбородка",
          value: 0,
          min: -10,
          max: 10
        },
        {
          name: "chimp_bone_width",
          header: "Ширина подбородка",
          value: 0,
          min: -10,
          max: 10
        },
        {
          name: "chimp_hole",
          header: "Ямочка на подбородке",
          value: 0,
          min: -10,
          max: 10
        },
        {
          name: "neck_thickness",
          header: "Полнота шеи",
          value: 0,
          min: -10,
          max: 10
        }
      ]
    };
  },
  mounted() {
    //select active radio
    let spans = document.querySelectorAll(".radio__color");
    spans.forEach(item => {
      let color = item.dataset.color;
      item.style.backgroundColor = color;
    });
    // post events
    document.addEventListener("DOMContentLoaded", () => {
      let inputs = document.querySelectorAll("input");
      inputs.forEach(input => {
        input.addEventListener("change", event => {
          this.postData(event);
        });
      });

      let arrows = document.querySelectorAll(".range--arrows__button");
      arrows.forEach(button => {
        button.addEventListener("click", event => {
          this.postData(event);
        });
      });

      let submit = document.querySelector(".skincreator__submit-btn");
      submit.addEventListener("click", event => {
        this.submitData(event);
      });
    });

    window.addEventListener("message", event => {
      if (event.data.openSkinCreator == true) {
        document
          .querySelector(".skincreator__wrapper")
          .classList.add("is-active");
      }
      if (event.data.openSkinCreator == false) {
        document
          .querySelector(".skincreator__wrapper")
          .classList.remove("is-active");
      }
      //      if (event.data.type == "click") {
      //        triggerClick(cursorX - 1, cursorY - 1);
      //      }
    });
  },
  methods: {
    switchPane(event) {
      event.preventDefault();
      let siblings = document.querySelectorAll(".tab__link");
      let targets = document.querySelectorAll(".tab__content");

      targets.forEach(item => {
        item.classList.remove("active");
      });

      siblings.forEach(item => {
        item.classList.remove("active");
        if (event.target == item) {
          let target = item.dataset.link;
          document.querySelector("#tab-" + target).classList.add("active");
          item.classList.add("active");
        }
      });

      axios.post(
        "http://vueskincreator/zoom",
        JSON.stringify({ zoom: event.target.name })
      );
    },
    postData(event) {
      event.preventDefault();
      axios.post(
        "http://vueskincreator/updateSkin",
        JSON.stringify({
          value: false,
          dad: document.querySelector("input[name=father]:checked").value,
          mum: document.querySelector("input[name=mother]:checked").value,
          dadmumpercent: document.querySelector("input[name=genetics]").value,
          skin: document.querySelector("input[name=skincolor]:checked").value,
          eyecolor: document.querySelector("input[name=eyecolor]:checked")
            .value,
          acne: document.querySelector("input[name=acne]").value,
          skinproblem: document.querySelector("input[name=skinProblems]").value,
          freckle: document.querySelector("input[name=freckles]").value,
          wrinkle: document.querySelector("input[name=wrinkles]").value,
          wrinkleopacity: document.querySelector("input[name=wrinklesDepth]")
            .value,
          hair: document.querySelector("input[name=hairstyle]").value,
          haircolor: document.querySelector("input[name=haircolor]:checked")
            .value,
          eyebrow: document.querySelector("input[name=eyebrowsShape]").value,
          eyebrowopacity: document.querySelector("input[name=eyebrowsTickness]")
            .value,
          beard: document.querySelector("input[name=beardType]").value,
          beardopacity: document.querySelector("input[name=beardTickness]")
            .value,
          beardcolor: document.querySelector("input[name=beardcolor]:checked")
            .value,
          // Clothes
          hats: document.querySelector("input[name=head]").value,
          glasses: document.querySelector("input[name=glass]").value,
          ears: document.querySelector("input[name=bejelwes]").value,
          tops: document.querySelector("input[name=shirts]").value,
          pants: document.querySelector("input[name=pants]").value,
          shoes: document.querySelector("input[name=shoes]").value,
          watches: document.querySelector("input[name=watches]").value,
          // face extended
          nose_width: document.querySelector("input[name=nose_width]").value,
          nose_peak_height: document.querySelector(
            "input[name=nose_peak_height]"
          ).value,
          nose_peak_length: document.querySelector(
            "input[name=nose_peak_length]"
          ).value,
          nose_bone_height: document.querySelector(
            "input[name=nose_bone_height]"
          ).value,
          nose_peak_lowering: document.querySelector(
            "input[name=nose_peak_lowering]"
          ).value,
          nose_peak_twist: document.querySelector("input[name=nose_peak_twist]")
            .value,
          eyebrow_height: document.querySelector("input[name=eyebrow_height]")
            .value,
          eyebrow_forward: document.querySelector("input[name=eyebrow_forward]")
            .value,
          cheeks_bone_height: document.querySelector(
            "input[name=cheeks_bone_height]"
          ).value,
          cheeks_bone_width: document.querySelector(
            "input[name=cheeks_bone_width]"
          ).value,
          cheeks_width: document.querySelector("input[name=cheeks_width]")
            .value,
          eyes_opening: document.querySelector("input[name=eyes_opening]")
            .value,
          lips_thickness: document.querySelector("input[name=lips_thickness]")
            .value,
          jaw_bone_width: document.querySelector("input[name=jaw_bone_width]")
            .value,
          jaw_bone_back_length: document.querySelector(
            "input[name=jaw_bone_back_length]"
          ).value,
          chimp_bone_lowering: document.querySelector(
            "input[name=chimp_bone_lowering]"
          ).value,
          chimp_bone_length: document.querySelector(
            "input[name=chimp_bone_length]"
          ).value,
          chimp_bone_width: document.querySelector(
            "input[name=chimp_bone_width]"
          ).value,
          chimp_hole: document.querySelector("input[name=chimp_hole]").value,
          neck_thickness: document.querySelector("input[name=neck_thickness]")
            .value
        })
      );
    },
    submitData(event) {
      event.preventDefault();
      axios.post(
        "http://vueskincreator/updateSkin",
        JSON.stringify({
          value: true,
          dad: document.querySelector("input[name=father]:checked").value,
          mum: document.querySelector("input[name=mother]:checked").value,
          dadmumpercent: document.querySelector("input[name=genetics]").value,
          skin: document.querySelector("input[name=skincolor]:checked").value,
          eyecolor: document.querySelector("input[name=eyecolor]:checked")
            .value,
          acne: document.querySelector("input[name=acne]").value,
          skinproblem: document.querySelector("input[name=skinProblems]").value,
          freckle: document.querySelector("input[name=freckles]").value,
          wrinkle: document.querySelector("input[name=wrinkles]").value,
          wrinkleopacity: document.querySelector("input[name=wrinklesDepth]")
            .value,
          hair: document.querySelector("input[name=hairstyle]").value,
          haircolor: document.querySelector("input[name=haircolor]").value,
          eyebrow: document.querySelector("input[name=eyebrowsShape]").value,
          eyebrowopacity: document.querySelector("input[name=eyebrowsTickness]")
            .value,
          beard: document.querySelector("input[name=beardType]").value,
          beardopacity: document.querySelector("input[name=beardTickness]")
            .value,
          beardcolor: document.querySelector("input[name=beardcolor]").value,
          // Clothes
          hats: document.querySelector("input[name=head]").value,
          glasses: document.querySelector("input[name=glass]").value,
          ears: document.querySelector("input[name=bejelwes]").value,
          tops: document.querySelector("input[name=shirts]").value,
          pants: document.querySelector("input[name=pants]").value,
          shoes: document.querySelector("input[name=shoes]").value,
          watches: document.querySelector("input[name=watches]").value,
          // face extended
          nose_width: document.querySelector("input[name=nose_width]").value,
          nose_peak_height: document.querySelector(
            "input[name=nose_peak_height]"
          ).value,
          nose_peak_length: document.querySelector(
            "input[name=nose_peak_length]"
          ).value,
          nose_bone_height: document.querySelector(
            "input[name=nose_bone_height]"
          ).value,
          nose_peak_lowering: document.querySelector(
            "input[name=nose_peak_lowering]"
          ).value,
          nose_peak_twist: document.querySelector("input[name=nose_peak_twist]")
            .value,
          eyebrow_height: document.querySelector("input[name=eyebrow_height]")
            .value,
          eyebrow_forward: document.querySelector("input[name=eyebrow_forward]")
            .value,
          cheeks_bone_height: document.querySelector(
            "input[name=cheeks_bone_height]"
          ).value,
          cheeks_bone_width: document.querySelector(
            "input[name=cheeks_bone_width]"
          ).value,
          cheeks_width: document.querySelector("input[name=cheeks_width]")
            .value,
          eyes_opening: document.querySelector("input[name=eyes_opening]")
            .value,
          lips_thickness: document.querySelector("input[name=lips_thickness]")
            .value,
          jaw_bone_width: document.querySelector("input[name=jaw_bone_width]")
            .value,
          jaw_bone_back_length: document.querySelector(
            "input[name=jaw_bone_back_length]"
          ).value,
          chimp_bone_lowering: document.querySelector(
            "input[name=chimp_bone_lowering]"
          ).value,
          chimp_bone_length: document.querySelector(
            "input[name=chimp_bone_length]"
          ).value,
          chimp_bone_width: document.querySelector(
            "input[name=chimp_bone_width]"
          ).value,
          chimp_hole: document.querySelector("input[name=chimp_hole]").value,
          neck_thickness: document.querySelector("input[name=neck_thickness]")
            .value
        })
      );
    }
  }
};
</script>

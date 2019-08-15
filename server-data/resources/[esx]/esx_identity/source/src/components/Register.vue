<template lang="pug">
	.register
		img(src="assets/img/logo.jpg", alt="alt")
		form.register__form(@submit.prevent="submit")
			.register__form-row
				input.register__form-input(:class="{ 'is-error': $v.firstname.$error }", type="text", name="name", placeholder="Имя", id="firstname", v-model="firstname", onfocus="this.placeholder=''" onblur="this.placeholder='Имя'")
			.register__form-row
				input.register__form-input(:class="{ 'is-error': $v.lastname.$error }",type="text", name="lastname", placeholder="Фамилия", id="lastname", v-model="lastname", onfocus="this.placeholder=''" onblur="this.placeholder='Фамилия'")
			.register__form-row
				input.register__form-input(:class="{ 'is-error': $v.age.$error }",type="number", name="age", placeholder="Возраст", id="age", v-model="age", onfocus="this.placeholder=''" onblur="this.placeholder='Возраст'")
			.register__form-row
				select.register__form-select(:class="{ 'is-error': $v.sex.$error }", v-model="selected")
					option(v-for="item in sex" :value="item.value" :hidden='item.isHidden') {{item.name}}
				input.register__form-input--mini(:class="{ 'is-error': $v.height.$error }",type="number", v-model="height", placeholder="Рост", id="height", onfocus="this.placeholder='140 - 200'" onblur="this.placeholder='Рост'")
			.register__form-row
				button.register__form-submit(type="Submit") Войти в мир
</template>

<style lang="scss">
body {
  display: none;
}

.register {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  width: 100%;
  max-width: 500px;
  padding: 0 55px;
  height: 100vh;
  background-color: rgba(46, 48, 51, 0.85);

  &__form {
    width: 100%;
    margin-top: 20px;

    &-row {
      display: flex;
      justify-content: space-between;
      width: 100%;
    }

    &-input {
      width: 100%;
      height: 65px;
      margin-bottom: 20px;
      background: #2e3033;

      border: none;
      border-radius: 4px;
      text-align: center;
      font-family: "Roboto", sans-serif;
      font-style: normal;
      font-weight: 500;
      font-size: 16px;
      line-height: 19px;
      color: rgba(255, 255, 255, 0.5);
      text-transform: capitalize;

      &:focus {
        outline: none;
        box-shadow: 0px 0px 10px 5px rgba(245, 164, 23, 0.38);
      }

      &::-webkit-inner-spin-button,
      &::-webkit-outer-spin-button {
        appearance: none;
        margin: 0;
      }

      &.is-error {
        box-shadow: 0px 0px 10px 5px rgba(245, 23, 23, 0.883);
      }

      &--mini {
        @extend .register__form-input;
        max-width: 185px;

        &.is-error {
          box-shadow: 0px 0px 10px 5px rgba(245, 23, 23, 0.883);
        }
      }
    }

    &-select {
      @extend .register__form-input--mini;
      padding: 0 65px;
    }

    &-submit {
      width: 100%;
      height: 65px;
      border: none;
      background: #84b372;

      border-radius: 4px;
      font-family: "Roboto", sans-serif;
      font-style: normal;
      font-weight: 500;
      font-size: 16px;
      line-height: 19px;
      color: rgba(255, 255, 255, 0.9);
      text-align: center;
    }
  }
}
</style>

<script>
import {
  required,
  minLength,
  maxLength,
  minValue,
  maxValue
} from "vuelidate/lib/validators";
import axios from "axios";

export default {
  name: "Example",
  data() {
    return {
      firstname: "",
      lastname: "",
      age: "",
      sex: [
        {
          name: "М",
          value: "m",
          isHidden: false
        },
        {
          name: "Ж",
          value: "f",
          isHidden: false
        },
        {
          name: "Пол",
          value: "sex",
          isHidden: true
        }
      ],
      height: "",
      selected: "sex"
    };
  },
  mounted() {
    window.addEventListener("message", this.showUi());
  },
  methods: {
    showUi() {
      if (event.data.type == "enableui") {
        document.body.style.display = event.data.enable ? "block" : "none";
      }
    },
    submit() {
      console.log("submit!");
      this.$v.$touch();
      if (this.$v.$invalid) {
        this.submitStatus = "ERROR";
      } else {
        // do your submit logic here
        this.submitStatus = "PENDING";
        // axios.post(
        //   "http://esx_identity/register",
        //   JSON.stringify({
        //     firstname: this.firstname,
        //     lastname: this.lastname,
        //     dateofbirth: this.age,
        //     sex: this.sex,
        //     height: this.height
        //   })
        // );
        console.log(
          JSON.stringify({
            firstname: this.firstname,
            lastname: this.lastname,
            dateofbirth: this.age,
            sex: document.querySelector("select").value,
            height: this.height
          })
        );
      }
    }
  },
  validations: {
    firstname: {
      required
    },
    lastname: {
      required
    },
    age: {
      required,
      minLength: minLength(2),
      maxLength: maxLength(2),
      minValue: 18,
      maxValue: 99
    },
    sex: {
      required
    },
    height: {
      required,
      minLength: minLength(3),
      maxLength: maxLength(3),
      minValue: 140,
      maxValue: 200
    }
  }
};
</script>

<template>
    <div class="black-container font-weight-medium"><slot></slot></div>
</template>

<script>
import Vue from 'vue'
export default Vue.extend({
    props: ["notification"],
    mounted() {
        setTimeout(() => this.$emit('expired', alert), 10000)
    }

})
</script>

<style>
    .notify-red {
        color: #F92652;
    }
    .notify-blue {
        color: #66D9EF;
    }
    .notify-green {
        color: #A6E22E;
    }
    .notify-yellow {
        color: #E6DB74;
    }
    .notify-purple {
        color: #AE81FF;
    }
    .notify-orange {
        color: #FD971F;
    }
    .notify-gray {
        color: #BCA3A3;
    }
    .notify-darkgray {
        color: #8F8F8F;
    }
    .notify-black {
        color: black;
    }
    .notify-white {
        color: white;
    }
    .notify-default {
        color: #F8F8F2;
        font-weight: normal;
    }
    .notify-bold {
        font-weight: bold;
    }
</style>
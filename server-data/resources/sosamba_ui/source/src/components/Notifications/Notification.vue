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


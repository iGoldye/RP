<script>
import { createSimpleTransition } from 'vuetify/es5/util/helpers'
const myTransition = createSimpleTransition('inventory-transition')
Vue.component('inventory-transition', myTransition)
</script>

<style>
.inventory-transition-leave-active {
    position: absolute;
}
/*
.inventory-transition-enter-active, .inventory-transition-leave, .inventory-transition-leave-to {
    transition: $primary-transition;
}*/

.inventory-transition-enter, .inventory-transition-leave-to {
    opacity: 0;
}

</style>
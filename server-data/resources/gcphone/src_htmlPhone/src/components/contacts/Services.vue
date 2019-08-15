<template>
  <div class="contact">
    <list :list='callList' :title="IntlString('APP_SERVICES_TITLE')" :disable='ignoreControls' v-on:select="onSelect" @back="back"></list>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import List from './../List.vue'
import Modal from '@/components/Modal/index.js'

export default {
  name: 'Services',
  components: { List },
  data () {
    return {
      ignoreControls: false
    }
  },
  computed: {
    ...mapGetters(['IntlString', 'config']),
    callList () {
      return this.config.serviceCall || []
    }
  },
  methods: {
    onSelect (itemSelect) {
      if (this.ignoreControls === true) return
      this.ignoreControls = true
      Modal.CreateModal({choix: [...itemSelect.subMenu, {title: 'Назад'}]}).then(rep => {
        this.ignoreControls = false
        if (rep.title === 'Назад') return
        this.$phoneAPI.callEvent(rep.eventName, rep.type)
        this.$router.push({name: 'home'})
      })
    },
    back () {
      if (this.ignoreControls === true) return
      this.$router.push({ name: 'home' })
    }
  },
  created () {
    if (!this.useMouse) {
      this.$bus.$on('keyUpBackspace', this.back)
    }
  },

  beforeDestroy () {
    this.$bus.$off('keyUpBackspace', this.back)
  }
}
</script>

<style scoped>
.contact{
  position: relative;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
}
</style>

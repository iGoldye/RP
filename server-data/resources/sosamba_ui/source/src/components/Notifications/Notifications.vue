<template>
      <transition-group name="notifymove" id="notifications" tag="div">
        <Notification
          v-for="(notification) in notifications"
          :key="notification.id"
          :notification="notification"
          @expired="removeNotification(notification)"
          v-html="notification.text">
        </Notification>
      </transition-group>

</template>

<script>
import Notification from './Notification';

export default {

    components: {
      Notification,
    },

    data: function() {
        return {
            notifications: [],
            notificationIndex: 0,
        }
    },

    methods: {
        message(data) {
            if (data.action == 'showNotification') {
                this.createNotification(data.text);
            }
        },

		createNotification(text){
			this.notifications.push({id: this.notificationIndex++, text: text})
        },

		removeNotification(notification) {
			this.notifications.splice(this.notifications.indexOf(notification), 1)
		},
    },

    created: function () {
        this.$eventHub.$on('message', this.message);
    },
    beforeDestroy() {
        this.$eventHub.$off('message');
    },
}
</script>

<style scoped>
    #notifications {
        position: absolute;
        top: 25%;
        bottom: 19%;
        width: 350px;
        min-height: 300px;

    /*    font-family: 'Open Sans Semibold'; */
        font-size: 15px;
        color: white;

        display: flex;
        flex-direction: column;
        flex-wrap: nowrap;
        justify-content: flex-start;
        align-content: stretch;
        align-items: stretch;
    }

    .notifymove-enter-active {
    transition: all .5s;
    }

    .notifymove-leave-active {
    transition: all .5s;
    }
    .notifymove-enter, .notifymove-leave-to {
    /*  opacity: 0;*/
    transform: translateX(-400px);
    }

    .notifymove-move {
    transition: transform 0.5s;
    }


</style>
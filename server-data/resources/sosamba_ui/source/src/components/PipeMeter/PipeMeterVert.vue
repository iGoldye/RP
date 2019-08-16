<template>
    <div class="pipe-meter-container"
            v-bind:style="{'background': 'linear-gradient(to right,  hsl('+hue+', 100%, 41%) 0%, hsl('+hue+', 100%, 55%) 50%, hsl('+hue+', 100%, 41%) 100%)',
                        'border-color': 'hsl('+hue+', 45%, 27%)',
                        'width': width+'px',
                        'height': height+'px'
                        }">
            <div class="pipe-meter-value"
                v-bind:style="{'height': (1-value)*100+'%',
            'background': 'linear-gradient(to right,  hsl('+hue+', 100%, 21%) 0%, hsl('+hue+', 100%, 10%) 50%, hsl('+hue+', 100%, 21%) 100%)'
                            }">
            </div>
            <div class="pipe-meter-label"
            ><slot></slot></div>
    </div>
</template>

<script>
export default {
  props: {
        value: {
            type: Number,
            default: 0,
        },
        hue: {
            type: Number,
            default: 0,
        },
        width: {
            type: Number,
            default: 0,
        },
        height: {
            type: Number,
            default: 0,
        },
      },
  data: () => ({
    
    }),
    methods: {
    }
};
</script>

<style>
/* meters */
.pipe-meter-container {
  position: relative;
  width: 20px;
  height: 40px;
  background: #00d18b;
  border: 1px solid;
  border-radius: 5px;
  box-shadow: 1px;
  box-shadow: 0 0 1px 1px rgba(0,55,0,0.2);
}

.pipe-meter-value {
  position: absolute;
  top: 0;
  width: 100%;
  border-radius: 3px 3px 3px 3px;
  background: #006e2e;
}

.pipe-meter-label {
  position: relative;
  top: 3px;
  width: 100%;
  text-align: center;
  z-index: 2;
  color: white;
  text-shadow: 1px 1px 2px black;
  font-size: 14px;
}
</style>
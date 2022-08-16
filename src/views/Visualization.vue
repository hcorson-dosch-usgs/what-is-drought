<template>
  <div id="visualization">
    <DroughtThresholds />
    <References />
  </div>
</template>

<script>

export default {
    name: 'Visualization',
    components: {
      DroughtThresholds: () => import( /* webpackPreload: true */ /*webpackChunkName: "section"*/ "./../components/DroughtThresholds"),
     References: () => import( /*webpackChunkName: "References"*/ "./../components/References")
    },
    computed: {
    },
    mounted(){
    },
    methods:{
    }
} 
</script>

<style lang="scss">
#visualization {
  //height: calc(100vh);
  margin: 2.5%;
  position: relative;

}

</style>

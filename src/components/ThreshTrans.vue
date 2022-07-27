<template>
  <section id="DroughtThresholds" class="section">
    <SectionTitle
      :title="title"
      />
    <div class="container">
    <!--   <svg id="threshold-svg" /> -->
    <ThresholdTransition />
    </div>
  </section>
</template>
<script>
import * as d3Base from 'd3';
import { store } from '../store/store.js'
import { isMobile } from 'mobile-device-detect';
import ThresholdTransition from "../components/ThresholdTransition";

export default {
  name: "thresholds",
    components: {
      ThresholdTransition
    },
    props: {
    },
    data() {
      return {
        title: 'Streamflow drought',
        publicPath: process.env.BASE_URL, // this is need for the data files in the public folder, this allows the application to find the files when on different deployment roots
        d3: null,
        store,
        mobileView: isMobile, // test for mobile
        step: 1,

        // dimensions
        w: store.state.windowWidth,
        h: store.state.windowHeight,
        margin: { top: 50, right: 50, bottom: 50, left: 50 },
        svg_chart: null,

        sources: [

        ]
        }
  },
  mounted(){      
      this.d3 = Object.assign(d3Base);
      this.loadData()
      
      this.svg_chart = this.d3.select('#threshold-svg')
          .attr("viewBox", "0 0 " + (this.w*0.95) + " " + (this.h*0.75))
          .attr("style", "max-width: 100%; max-height: 100%; height: auto;")
          .append("g")
          .attr("id", "threshold-chart")

      this.step = 1;

    },
    methods:{
      nextStep() {
        this.step ++;
        console.log(this.step)
        this.toSamples()
      },
      backStep() {
        this.step --;
        console.log(this.step)
      },
      isMobile() {
              if(/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)) {
                  return true
              } else {
                  return false
              }
          },
       loadData() {
        const self = this;
        // read in data 
        let promises = [
          self.d3.csv(self.publicPath + "genus_total.csv",  this.d3.autotype)
        ];
        Promise.all(promises).then(self.callback); // once it's loaded
        
      },
      callback(data) {
        const self = this;
        // assign data

      }
    }
}
</script>
<style scoped lang="scss">
@import url('https://fonts.googleapis.com/css2?family=Source+Sans+Pro:wght@200;300;400;500;600;700;800&display=swap');
$SourceSans: 'Source Sans Pro', sans-serif;

section {
  background-color: pink;
}

</style>
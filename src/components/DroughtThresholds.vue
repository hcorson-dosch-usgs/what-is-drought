<template>
  <div class="another-container">
    <div class="chart-container">
      <div id="title-container">
        <h2 class="knockout-text">What is streamflow drought?</h2>
      </div>
      <div class = 'chevronContainer'>
        <div class = 'chevron'></div>
        <div class = 'chevron'></div>
        <div class = 'chevron'></div>
      </div>
      <!-- read in frames dynamically -->
      <img
        v-for="frame in frames" 
        :id="`step-${frame.id}`"
        :key="frame.id"
        class="hydro-chart" 
        :src="require(`@/assets/images/threshold-chart/${frame.id}.png`)"
      >
    </div>
    <!-- create a scrolling div for each frame -->
    <div id="scroll-container">
      <div
        v-for="frame in frames" 
        :key="frame.id"
        :class="`scrolly scroll-step-${frame.id}`"
      >
        <div class="text-container">
          <p>{{ frame.text }}</p>
        </div>
      </div>
    </div>
    <div id="spacer" />
  </div>
</template>
<script>
import { store } from '../store/store.js'
import { isMobile } from 'mobile-device-detect';
import { ScrollTrigger } from "gsap/ScrollTrigger"; // animated scroll events
import { TimelineMax } from "gsap/all";
import scrollyText from "@/assets/text/scrollyText";  // step text
export default {
  name: "DroughtThresholds",
    components: {
    },
    props: {
    },
    data() {
      return {
        publicPath: process.env.BASE_URL, // allows the application to find the files when on different deployment roots
        mobileView: isMobile, // test for mobile
        frames: scrollyText.frames, // scrolling text

        // dimensions
        w: store.state.windowWidth,
        h: store.state.windowHeight,
        margin: { top: 50, right: 50, bottom: 50, left: 50 },

        // show scroll trigger markers on the page?
        marker_on: false,

        }
  },
  mounted(){      
    // register plugins for global use
      this.$gsap.registerPlugin(ScrollTrigger, TimelineMax); 

      // create the scrolling timeline
      let tl = this.$gsap.timeline(); 

      // things that go before containers
            // use class to set trigger
         tl.to('.knockout-text', {
          scrollTrigger: {  
            markers: false,
            trigger: '.knockout-text',
            start: "top center",
            end: "top 10%",
            toggleClass: {targets: `.knockout-text`, className:"bigger"}, // adds class to target when triggered
            toggleActions: "restart none none none" // onEnter onLeave ... ...
            /*
            onEnter - scrolling down, start meets scroller-start
            onLeave - scrolling down, end meets scroller-end
            onEnterBack - scrolling up, end meets scroller-end
            onLeaveBack - scrolling up, start meets scroller-start
            */
          }
        })  



      // find all scrolly divs
      const containers = this.$gsap.utils.toArray(".scrolly");

      //  add scroll trigger to timeline for each step
      containers.forEach((container) => {

        // get unique ID and class for frame. Scroll frame classes follow the pattern `scrolly scroll-step-${frame.id}`
        let classList = container.className
        let scrollClass = classList.split(' ')[1]
        console.log(scrollClass.split('-')[2])
        let scrollID = scrollClass.split('-')[2] // ending of class is unique ID from scrollyText.js

      // use class to set trigger
        tl.to(`.${scrollClass}`, {
          scrollTrigger: {
            markers: this.marker_on,
            trigger: `.${scrollClass}`,
            start: "top 50%",
            toggleClass: {targets: `#step-${scrollID}`, className:"onTop"}, // adds class to target when triggered
            toggleActions: "restart none none none" 
            /*
            onEnter - scrolling down, start meets scroller-start
            onLeave - scrolling down, end meets scroller-end
            onEnterBack - scrolling up, end meets scroller-end
            onLeaveBack - scrolling up, start meets scroller-start
            */
          }
        }) 
      })

    },
    methods:{
      isMobile() {
              if(/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)) {
                  return true
              } else {
                  return false
              }
          }
    }
}
</script>
<style scoped lang="scss">
// handwriting font
@import url('https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=swap');
$writeFont: 'Nanum Pen Script', cursive;
$base: 0.6rem; //for chevron scroll animation
// frames are stacked and class is added on an off w/ scroll trigger to bring to front
img {
  max-width: 80vw;
}
#title-container {
  position: fixed;
  background-image: url("https://labs.waterdata.usgs.gov/visualizations/images/dry_drought_soil_publicDomain.jpg");
  background-size: cover;
}
#scroll-container {
  z-index: 200;
}
.text-container {
  z-index: 500;
  border-radius: 25px;
  background: #EC8176;
  max-width: 400px;
  p{
    padding: 25px;
  }
}
.knockout-text {
  font-size: 3.75em;
  font-weight: bold;
  font-family: Roboto, 'Helvetica Neue', Arial, sans-serif;
  color: #FFE3AD;
  background: #5BA5B3;
  //mix-blend-mode: lighten;
  padding: 0 0 0 50px;
}

.smaller {
  font-size: 3.75em;
}
.bigger {
  font-size: 20vh;
}
.hydro-chart {
  height: auto;
  margin-top: 10%;
  margin-left: 10%;
  background-color: #999999;
  max-height: 700px;
    max-width: 1000px;
    opacity: 0;
    width: 65vw;
}

// stacking all images and using toogleClass to change visibility with scrolling
.hydro-chart {
  position: fixed;
  top: 10%;
  left: 35vh;
  @media screen and (max-width: 600px) {
    top: 25%;
  }
}
.chart-container {
  //background-position: top;
  height: 85vh;
  max-height: 700px;
  width: 50vw;
  position: relative;
  top:10vh;
  left: 0vh;
  margin-bottom: 5%;
  max-width: 800px;
}
// currently empty scoll-by divs used to trigger animation
.scrolly {
  height: 100vh;
   z-index: 100;
  p {
    max-width: 700px;
    color: black;
  }
}
.onTop {
  visibility: visible;
  z-index: 10;
  opacity: 1;
}
#spacer {
  height: 30vh;
}
.unstuck {
  position: relative;
}

.chevronContainer {
  position: fixed;
  display: flex;
  justify-contents: center;
  align-items: center;
  width: 100%;
  height: 10vh;
}
.chevron {
  position: absolute;
  width: $base * 3.5;
  height: $base * 0.8;
  opacity: 0;
  transform: scale(0.3);
  animation: move-chevron 3s ease-out infinite;
}
.chevron:first-child {
  animation: move-chevron 3s ease-out 1s infinite;
}
.chevron:nth-child(2) {
  animation: move-chevron 3s ease-out 2s infinite;
}
.chevron:before,
.chevron:after {
  content: '';
  position: absolute;
  top: 0;
  height: 100%;
  width: 50%;
  background: #FFE3AD;
}

.chevron:before {
  left: 0;
  transform: skewY(30deg);
}
.chevron:after {
  right: 0;
  width: 50%;
  transform: skewY(-30deg);
}

@keyframes move-chevron {
  25% {
    opacity: 1;
  }
  33.3% {
    opacity: 1;
    transform: translateY($base * 3.8);
  }
  66.6% {
    opacity: 1;
    transform: translateY($base * 5.2);
  }
  100% {
    opacity: 0;
    transform: translateY($base * 8) scale(0.5);
  }
}

</style>
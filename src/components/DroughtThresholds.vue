<template>
  <div class="another-container">
    <div class="chart-container">
      <div id="title-container">
        <h2>What is hydrological drought?</h2>
      </div>
      <!--     stack all frames on top of each other -->
      <img 
        id="step-a" 
        class="hydro-chart onTop"
        src="@/assets/images/threshold-chart/a.png"
      >
      <img 
        id="step-b" 
        class="hydro-chart"
        src="@/assets/images/threshold-chart/b.png"
      >
      <img 
        id="step-c" 
        class="hydro-chart"
        src="@/assets/images/threshold-chart/c.png"
      >
      <img 
        id="step-d" 
        class="hydro-chart"
        src="@/assets/images/threshold-chart/d.png"
      >
      <img 
        id="step-e" 
        class="hydro-chart"
        src="@/assets/images/threshold-chart/e.png"
      >
      <img 
        id="step-f" 
        class="hydro-chart"
        src="@/assets/images/threshold-chart/f.png"
      >
      <img 
        id="step-g" 
        class="hydro-chart"
        src="@/assets/images/threshold-chart/g.png"
      >
      <img 
        id="step-h" 
        class="hydro-chart"
        src="@/assets/images/threshold-chart/h.png"
      >
    <!-- this isn't working. pngs don't read in correctly -->
      <!--  <img v-for="frame in frames" 
        :key="frame.id"
        class="hydro-chart"
        :id="`stepy-${frame.id}`" 
        v-bind:src="`@/assets/images/threshold-chart/${frame.id}.png`" /> -->
    </div>
    <!--  spacing and scrolling text goes here -->
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

      // find all scrolly divs
      const containers = this.$gsap.utils.toArray(".scrolly");

      // loop through and add scroll trigger to timeline for each step (not working)
      containers.forEach((container) => {
        /* tl.to(container, {
          scrollTrigger: {
            markers: this.marker_on,
            trigger: container,
            start: "top 50%",
            toggleClass: {targets: ""}

          }
        }) */
      })

      // add events
      tl.to(".scroll-step-b", { // focal element
        scrollTrigger: {
          markers: this.marker_on,
          trigger: ".scroll-step-b", // what the trigger is associated with
          start: "top 50%", // when the scroll event happens - when the top of the trigger is 50% up
          end:() => `+=${document.querySelector(".scroll-step-b").offsetHeight}`, // when center of trigger is 20% down of top of vp, trigger ends
          toggleClass: {targets: "#step-b", className: "onTop" }, // trigger adds and removes a class from the target
          toggleActions: "restart none none none" // onEnter onLeave ... ...
        }
        }).to(".scroll-step-c", {
        scrollTrigger: {
          markers: this.marker_on,
          trigger: ".scroll-step-c",
          start: "top 50%", // when the animation starts
          end:() => `+=${document.querySelector(".scroll-step-c").offsetHeight}`, 
          toggleClass: {targets: "#step-c", className: "onTop" }, // add a class at trigger
          toggleActions: "restart none none none"
        }
        }).to(".scroll-step-d", {
        scrollTrigger: {
          markers: this.marker_on,
          trigger: ".scroll-step-d",
          start: "top 50%", // when the animation starts
          end:() => `+=${document.querySelector(".scroll-step-d").offsetHeight}`, 
          toggleClass: {targets: "#step-d", className: "onTop" },
          toggleActions: "restart none none none"
        }
        }).to(".scroll-step-e", {
        scrollTrigger: {
          markers: this.marker_on,
          trigger: ".scroll-step-e",
          start: "top 50%", // when the animation starts
          end:() => `+=${document.querySelector(".scroll-step-e").offsetHeight}`, 
          toggleClass: {targets: "#step-e", className: "onTop" },
          toggleActions: "restart none none none"
        }
        }).to(".scroll-step-f", {
        scrollTrigger: {
          markers: this.marker_on,
          trigger: ".scroll-step-f",
          start: "top 50%", // when the animation starts
          end:() => `+=${document.querySelector(".scroll-step-f").offsetHeight}`, 
          toggleClass: {targets: "#step-f", className: "onTop" },
          toggleActions: "restart none none none"
        }
        }).to(".scroll-step-g", {
        scrollTrigger: {
          markers: this.marker_on,
          trigger: ".scroll-step-g",
          start: "top 50%", // when the animation starts
          end:() => `+=${document.querySelector(".scroll-step-g").offsetHeight}`, 
          toggleClass: {targets: "#step-g", className: "onTop" },
          toggleActions: "restart none none none"
        }
        }).to(".scroll-step-h", {
        scrollTrigger: {
          markers: this.marker_on,
          trigger: ".scroll-step-h",
          start: "top 50%", // when the animation starts
          end:() => `+=${document.querySelector(".scroll-step-h").offsetHeight}`, 
          toggleClass: {targets: "#step-h", className: "onTop" },
          toggleActions: "restart none none pause"
        }
      }).to("#spacer", {
        scrollTrigger: {
          markers: this.marker_on,
          trigger: "#spacer",
          start: "top 50%", // when the animation starts
          toggleClass: {targets: ".hydro-chart", className: "unstuck" },
          toggleActions: "restart none none none"
        }
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
// frames are stacked and class is added on an off w/ scroll trigger to bring to front
img {
  max-width: 80vw;
}
#title-container {
  position: fixed;
}
#scroll-container {
  z-index: 200;
}
.text-container {
  z-index: 500;
  border-radius: 25px;
  background-color: #333534;
  max-width: 400px;
  p{
    padding: 25px;
  }
}
.hydro-chart {
  height: auto;
  margin-top: 10%;
  margin-left: 10%;
  background-color: white;
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
    color: white;
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
</style>
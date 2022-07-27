<template>
<div class="another-container">
  <div class="chart-container">
    <div id="title-container">
      <h2>What is hydrological drought?</h2>
    </div>
<!--     stack all frames on top of each other -->
      <img 
      class="hydro-chart onTop" 
      id="step-a"
      src="@/assets/images/threshold-chart/a.png"
    />
     <img 
      class="hydro-chart" 
      id="step-b"
      src="@/assets/images/threshold-chart/b.png"
    />
     <img 
      class="hydro-chart" 
      id="step-c"
      src="@/assets/images/threshold-chart/c.png"
    />
     <img 
      class="hydro-chart" 
      id="step-d"
      src="@/assets/images/threshold-chart/d.png"
    />
     <img 
      class="hydro-chart" 
      id="step-e"
      src="@/assets/images/threshold-chart/e.png"
    />
     <img 
      class="hydro-chart" 
      id="step-f"
      src="@/assets/images/threshold-chart/f.png"
    />
     <img 
      class="hydro-chart" 
      id="step-g"
      src="@/assets/images/threshold-chart/g.png"
    />
    <!-- this isn't working. pngs don't read in correctly -->
   <!--  <img v-for="frame in frames" 
        :key="frame.id"
        class="hydro-chart"
        :id="`stepy-${frame.id}`" 
        v-bind:src="`@/assets/images/threshold-chart/${frame.id}.png`" /> -->
    
  </div>
 <!--  spacing and scrolling text goes here -->
    <!-- create a scrolling div for each frame -->
    <div v-for="frame in frames" 
        :key="frame.id"
        :class="`scrolly scroll-step-${frame.id}`" >
<!--       <p>{{frame.text}}</p> -->
      </div>
  </div>
</template>
<script>
import { store } from '../store/store.js'
import { isMobile } from 'mobile-device-detect';
import { ScrollTrigger } from "gsap/ScrollTrigger"; // animated scroll events
import { TimelineMax } from "gsap/all";

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

        // dimensions
        w: store.state.windowWidth,
        h: store.state.windowHeight,
        margin: { top: 50, right: 50, bottom: 50, left: 50 },

        // show scroll trigger markers on the page?
        marker_on: true,

        // storing unique id and text for each scroll step
        // TODO: move outside of component to separate json
        frames: [
          {
            id: 'a',
            text: 'A hydrological drought means that streamflow is abnormally low.'
          },
          {
            id: 'b',
            text: 'Here, "abnormally low" is set as a threshold'
          },
          {
            id: 'c',
            text: 'You might be wondering, what happens if there is an abnormally dry spring when we expect more rain?'
          },
          {
            id: 'd',
            text: 'Periods of severe drought happen whenever daily streamflow is below the threshold.'
          },
          {
            id: 'e',
            text: 'And let our threshold change week to week'
          },
          {
            id: 'f',
            text: 'Well, then we need to determine periods when rainfall is abnormally low for a specific week'
          },
          {
            id: 'g',
            text: 'This variable threshold changes the timing and number of droughts.'
          }
        ]

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
          toggleActions: "restart none none pause"
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
// frames are stacked and class is added on an off w/ scroll trigger to bring to front
img {
  max-width: 80vw;
}
#title-container {
  position: fixed;
}
.hydro-chart {
  height: auto;
  margin-top: 10%;
  margin-left: 10%;
}

// stacking all images and using toogleClass to change visibility with scrolling
#step-a, #step-b, #step-c, #step-d, #step-e, #step-f, #step-g {
  position: fixed;
  top: 10%;
  left: 0;
}
.chart-container {
  height: 90vh;
  position: relative;
  top:10vh;
  left: 0;
  margin-bottom: 5%;
  max-width: 1200px;
}
// currently empty scoll-by divs used to trigger animation
.scrolly {
  height: 100vh;
  p {
    max-width: 700px;
    z-index: 1000;
  }
}
.onTop {
  visibility: visible;
  z-index: 100;
}
</style>
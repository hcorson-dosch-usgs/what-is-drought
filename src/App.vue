<template>
  <div id="app">
    <WindowSize v-if="checkTypeOfEnv === '-test build-'" />
    <HeaderUSGS class="sticky-header" ref="headerUSGS" />
      <InternetExplorerPage v-if="isInternetExplorer" />
      <!-- an empty string in this case means the 'prod' version of the application   -->
      <router-view
        v-if="!isInternetExplorer"
      />
      <PreFooterCodeLinks v-if="!isInternetExplorer" />
      <FooterUSGS />
  </div>
</template>

<script>
    import WindowSize from "./components/WindowSize";
    import HeaderUSGS from './components/HeaderUSGS';
    import { isMobile } from 'mobile-device-detect';
    export default {
        name: 'App',
        components: {
            WindowSize,
            HeaderUSGS,
            InternetExplorerPage: () => import( /* webpackPrefetch: true */ /*webpackChunkName: "internet-explorer-page"*/ "./components/InternetExplorerPage"),
            PreFooterCodeLinks: () => import( /* webpackPrefetch: true */ /*webpackChunkName: "pre-footer-links-code"*/ "./components/PreFooterCodeLinks"),
            FooterUSGS: () => import( /* webpackPrefetch: true */ /*webpackChunkName: "usgs-footer"*/ "./components/FooterUSGS") // Have Webpack put the footer in a separate chunk so we can load it conditionally (with a v-if) if we desire
        },
        data() {
            return {
                isInternetExplorer: false,
                title: process.env.VUE_APP_TITLE,
                publicPath: process.env.BASE_URL, // this is need for the data files in the public folder
                mobileView: isMobile,
            }
        },
        computed: {
          checkTypeOfEnv() {
              return process.env.VUE_APP_TIER
          },
          windowWidth: function() {
            return this.$store.state.windowWidth
          },
          windowHeight: function () {
              return this.$store.state.windowHeight
          }
        },
        mounted(){
       
        },
        created() {
            // We do not support for Internet Explorer. This tests if the browser used is IE.
            this.$browserDetect.isIE ? this.isInternetExplorer = true : this.isInternetExplorer = false;
            // Add window size tracking by adding a listener and a way to store the values in the Vuex state
            window.addEventListener('resize', this.handleResize);
            this.handleResize();
        },
        destroyed() {
            window.removeEventListener('resize', this.handleResize);
        },
        methods:{
          handleResize() {
                this.$store.commit('recordWindowWidth', window.innerWidth);
                this.$store.commit('recordWindowHeight', window.innerHeight);
            },
        }
    }
</script>

<style lang="scss">
// Fonts
@import url('https://fonts.googleapis.com/css2?family=Source+Sans+Pro:wght@200;300;400;500;600;700;800&display=swap');
$SourceSans: 'Source Sans Pro', sans-serif;
$textcolor: #333534;

// whole page except header fit within viewport - no scrolling
#app {
  width: 100%;
  height: calc(100vh + 85.7px); //85.7 is the height of the USGS header
}

// Type
html,
body {
      height: 100%;
      background-color: white;
      margin: 0;
      padding: 0;
      line-height: 1.2;
      font-size: 16px;
      font-weight: 300;
      -webkit-font-smoothing: antialiased;
      -moz-osx-font-smoothing: grayscale;
      width: 100%;
      @media screen and (max-width: 600px) {
        font-size: 16px;
      }
  }
h1{
  font-size: 4.5em;
  font-weight: 500;
  font-family: $SourceSans;
  line-height: 1;
  text-align: left;
  text-shadow: 1px 1px 100px rgba(0,0,0,.8);
    color: $textcolor;
  @media screen and (max-width: 600px) {
    font-size: 4.75em;
  }
}
h2{
  font-weight: 700;
  text-align: left;
  font-family: $SourceSans;
  font-size: 3em;
  margin-top: 5px;
  line-height: 1.2;
    color: $textcolor;
  @media screen and (max-width: 600px) {
    font-size: 2.75em;
  }
}
h3{
  font-size: 2.25em;
  padding-top: .25em;
  font-family: $SourceSans;
  font-weight: 300;
    color: $textcolor;
  @media screen and (max-width: 600px) {
      font-size: 2em;
  }  
}
p, text {
  padding: 1em 0 0 0; 
  font-family: $SourceSans;
  color: $textcolor;
}
input[type=button] {
        font-family: $SourceSans;
    }

// General Layout  
  section {
    padding: 3em 0 3em 0;
  }
  .text-content {
    min-width: 300px;
    max-width: 700px;
    margin: 0 auto;
    padding: 10px;   
    @media screen and (max-width: 600px) {
        padding: 10px;
    }  
  }
  .flex-container {
    display: flex;
    flex-wrap: wrap;
    align-items: flex-start;
    justify-content: space-evenly;
    align-content: space-around;
    max-width: 30%;
    margin: auto;
    @media screen and (max-width: 600px) {
        max-width: 100%;
    }
  }
  .flex-item {
    padding: 20px;
    min-width: 400px;
    flex: 0 0 auto;
    align-self: center;
  }
  @media (max-width: 600px) {
    .flex-container {
      flex-direction: column;
    }
    .flex-item {
      flex: none;
      padding: 0 0 1em 0;
      height: 100%;
    }
  }
  .figure-content {
    border: 1px white;
    display: flex;
    flex-wrap: wrap;
    align-items: flex-start;
    justify-content: space-evenly;
    align-content: space-around;
    max-width: 100%;
    margin: auto;
    @media screen and (max-width: 600px) {
        padding: 0px; 
    }
  }
.viz-title-wrapper {
  max-width: 100%;
  z-index: 100;
  @media screen and (max-width: 600px) {
        max-width: 90%;
  }
}
.viz-title {
  // box-shadow: -5px -5px $monotoneBlue5;
  font-size: 1.4em;
  font-weight: 700;
  color: darkGrey;
  margin-bottom: 0;
  @media screen and (max-width: 600px) {
       font-size: 1.2em;
       line-height: 1.2em;
  }
}
.viz-subtitle {
  color: black;
  font-size: .8em;
  text-align: left;
  font-weight: 100;
  margin-bottom: 0;
  @media screen and (max-width: 600px) {
        font-size: .6em;
  }
}
.legend-text {
    fill: black;
    font-family: $SourceSans;
    font-size: 16px;
  }
.viz-comment {
  font-family: $SourceSans;
  font-size: 26px;
  font-weight: 400;
  fill:rgb(224, 222, 222);
}
.viz-emph {
  font-weight:700;
  fill: white;
  font-family: $SourceSans;
  font-size: 26px;
}
.emph {
  font-weight: bold;
}
.italic {
  font-style: italic;
}
.pseudo-caption {
  font-size: .9em;
  margin: 0 10px;
}
// Link Styling
a:link { 
  text-decoration: underline;
  font-weight: bold;
  color: dodgerBlue;
  padding: 5px 0;
} 
a:visited { 
  color: dodgerBlue; 
} 
a:hover {
  text-decoration:none;
  text-shadow: 0 0 2px lightGrey;  
  cursor: pointer;
} 
a:focus { 
    text-shadow: 0 0 2px lightGrey;
}
a:active {
  padding-top: 3px;
}
sup {
  opacity: .4;
}
.sticky-header {
  position: fixed;
  top: 0;
  left: 0;
  width: 100vw;
}

</style>

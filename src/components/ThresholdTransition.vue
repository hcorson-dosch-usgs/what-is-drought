<template>
  <div id="threshold-transition">
    <div id="threshold-image-container-outer">
      <div id="threshold-image-container-inner">
          <img
          id="threshold-image-7"
          src="@/assets/images/threshold-chart/g.png"
          alt=""
        >
         <img
          id="threshold-image-6"
          src="@/assets/images/threshold-chart/f.png"
          alt=""
        >
        <img
          id="threshold-image-5"
          src="@/assets/images/threshold-chart/e.png"
          alt=""
        >
        <img
          id="threshold-image-4"
          src="@/assets/images/threshold-chart/d.png"
          alt=""
        >
        <img
          id="threshold-image-3"
          src="@/assets/images/threshold-chart/c.png"
          alt=""
        >
        <img
          id="threshold-image-2"
          src="@/assets/images/threshold-chart/b.png"
          alt=""
        >
        <img
          id="threshold-image-1"
          src="@/assets/images/threshold-chart/a.png"
          alt=""
        >
      </div>
    </div>
    <div
      id="threshold-text-container"
      class="text-content-side"
    >
      <div
        id="threshold-text-and-title-1"
        v-observe-visibility="{
          callback: visibilityChanged,
          intersection: {
            rootMargin: '-49% 0% -50% 0%',
            threshold: 0
          }
        }"
        class="scrolly-chunk"
      >
        <div
          id="p-container-1"
          class="p-container text-content-side text-chunk"
        >
          <h3
            id="threshold-title-1"
          >
            Managing River Flows
          </h3>
          <p> </p>
        </div>
      </div>

      <div
        id="threshold-text-and-title-2"
        v-observe-visibility="{
          callback: visibilityChanged,
          intersection: {
            rootMargin: '-49% 0% -50% 0%',
            threshold: 0
          }
        }"
        class="scrolly-chunk"
      >
        <div
          id="p-container-2"
          class="p-container text-content-side text-chunk"
        >
          <h3
            id="threshold-title-2"
          >
            Reservoirs
          </h3>
          <p></p>
        </div>
      </div>
      <div
        id="threshold-text-and-title-3"
        v-observe-visibility="{
          callback: visibilityChanged,
          intersection: {
            rootMargin: '-49% 0% -50% 0%',
            threshold: 0
          }
        }"
        class="scrolly-chunk"
      >
        <div
          id="p-container-3"
          class="p-container text-content-side text-chunk"
        >
          <h3
            id="threshold-title-3"
          >
            Using the Reservoirs
          </h3>
          <p>
            .</p>
        </div>
      </div>
      <div
        id="threshold-text-and-title-4"
        v-observe-visibility="{
          callback: visibilityChanged,
          intersection: {
            rootMargin: '-49% 0% -50% 0%',
            threshold: 0
          }
        }"
        class="scrolly-chunk"
      >
        <div
          id="p-container-4"
          class="p-container text-content-side text-chunk"
        >
          <h3
            id="threshold-title-4"
          >
            Summer Lows
          </h3>
          <p></p>
        </div>
      </div>
      <div
        id="threshold-text-and-title-5"
        v-observe-visibility="{
          callback: visibilityChanged,
          intersection: {
            rootMargin: '-49% 0% -50% 0%',
            threshold: 0
          }
        }"
        class="scrolly-chunk"
      >
        <div
          id="p-container-5"
          class="p-container text-content-side text-chunk"
        >
          <h3
            id="threshold-title-5"
          >
            Reservoir Releases
          </h3>
          <p> </p>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'ThresholdTransition',
  methods: {
    visibilityChanged(isVisible, entry) {
      const imageElement = document.getElementById('threshold-image-' + entry.target.id[entry.target.id.length - 1]);
      const paragraphContainerTargetId = 'p-container-' + entry.target.id[entry.target.id.length - 1];
      const paragraphContainerTargetElement = document.querySelector('#' + paragraphContainerTargetId);
      if (isVisible === true) {
        imageElement.classList.add('visible');
        paragraphContainerTargetElement.classList.add('visible');
      } else if (isVisible === false) {
        imageElement.classList.remove('visible');
        paragraphContainerTargetElement.classList.remove('visible');
      }
    }
  }
}
</script>

<style scoped lang="scss">
#threshold-transition {
  display: grid;
  grid-template-columns: 1fr 1fr;
  #threshold-image-container-inner {
    position: sticky;
    top: 10%;
    display: grid;
    grid-template-columns: 1fr;
    justify-items: center;
    #threshold-image-1 {
      grid-column: 1;
      grid-row: 1;
      align-self: start;
    }
    #threshold-image-2 {
      grid-column: 1;
      grid-row: 1;
      align-self: start;
    }
    #threshold-image-3 {
      grid-column: 1;
      grid-row: 1;
      align-self: start;
    }
    #threshold-image-4 {
      grid-column: 1;
      grid-row: 1;
      align-self: start;
    }
    #threshold-image-5 {
      grid-column: 1;
      grid-row: 1;
      align-self: start;
    }
    img {
      opacity: 0;
      transition: opacity .5s;
      max-height: 80vh;
    }
    img.visible {
      opacity: 1;
    }
  }
  // controls the text fades
  .p-container {
    opacity: 0;
    transition: opacity .5s;
  }
  .p-container.visible {
    opacity: 1;
  }
}
@media only screen and (max-width: 992px) {
  #threshold-transition {
    display: grid;
    grid-template-columns: 1fr;
    justify-items: center;
    #threshold-text-container {
      z-index: 2;
    }
  }
  #threshold-image-container-outer {
    z-index: 1;
    position: sticky;
    top: 0;
    grid-column: 1;
    grid-row: 1;
    align-self: start;
  }
  #threshold-text-container {
    grid-column: 1;
    grid-row: 1;
    align-self: start;
  }
}
</style>
import { time } from "vue-analytics";

export default {
      frames: [
        {
          // id is used to source image files with the same naming
          // and used to assign classes to scrolling text
          id: 'aa02',
          text: 'text aa01: There are many different types of drought, with varying effects on our daily lives.'
        },
        {
          // id is used to source image files with the same naming
          // and used to assign classes to scrolling text
          id: 'aa03',
          text: 'text aa02: Drought often begins as meterological drought, which means that there is less rain or snow melt than expected.'
        },
        {
          // id is used to source image files with the same naming
          // and used to assign classes to scrolling text
          id: 'aa04',
          text: 'text aa03: Meterological drought can lead to agricultural drought, which is where soil moisture becomes depleted and our crops and livestock begin to suffer and farmers rely on using irrigation.'
        },
        {
          // id is used to source image files with the same naming
          // and used to assign classes to scrolling text
          id: 'aa05',
          text: 'text aa04: Prolonged agricultural drought can begin to cause hydrological drought, which affects deeper soil layers and eventually reduces streamflow. Streamflow drought is one type of hydrological drought.'
        },
        {
          // id is used to source image files with the same naming
          // and used to assign classes to scrolling text
          id: 'a',
          text: 'text a: Although we have been hearing a lot about drought in the western US lately, drought can happen anywhere. For example, here\'s one severe streamflow drought that occurred at a site in Ohio in late summer of 1963.'
        },
        {
          id: 'b',
          text: 'text b: Streamflow droughts like this occur whenever streamflow gets below a certain threshold. The threshold can be defined based on typical streamflow rates over the year or by day. Let\’s explore how changing the threshold affects when we detect streamflow droughts at this site.'
        },
        {
          id: 'c',
          text: 'text c: To begin, start with a hydrograph, which is a plot of streamflow over time. Here, we are looking at daily streamflow during the growing season of 1963. '
        },
        {
          id: 'd',
          text: 'text d: A \"fixed\" threshold is created by first calculating average streamflow across all years and days and then calculating 10% of this annual average streamflow as the threshold.'
        },
        {
          id: 'e',
          text: 'text e: That\'s how these periods of drought were defined. These dry-season droughts are especially important to detect for hydropower production and for aquatic ecosystems that rely on water year-round.'
        },
        {
          id: 'f',
          text: 'text f: But droughts can also occur in the spring and winter when we expect wetter conditions and greater streamflow from rain showers and snow melt! To understand this, let\'s zoom out and look at the average daily streamflow for the last 70 years or so.'
        },
        {
          id: 'g',
          text: 'text g: In 1963, spring streamflow was much lower than a typical spring.'
        },
        {
          id: 'h',
          text: 'text h: To detect droughts in wetter seasons like this, we have to calculate a variable threshold as 10% of the average daily streamflow.'
        },
        {
          id: 'i',
          text: 'text i: By zooming back in, now we detect several droughts that happened in the spring. These wetter-season droughts are important to identify for city water managers trying to fill their reservoirs or for farmers planting early season crops.'
        },
        {
          id: 'j',
          text: 'text j: When we use both ways of looking at drought, we can identify droughts during the spring when streamflow is higher and during the summer when streamflow is extremely low. Having this ability to know when drought is occurring throughout the year makes it easier to use water sustainably.'
        },
        {
          id: 'k',
          text: 'text k: These seasonal patterns are even more distinct when we look at the whole year.'
        },
        {
          id: 'l',
          text: 'text l: And even more recognizable across the past 70 years.'
        },
        {
          id: 'm',
          text: 'text m: And even more recognizable across the past 70 years.'
        },
        {
          id: 'n',
          text: 'text n: And even more recognizable across the past 70 years.'
        },
        {
          id: 'o',
          text: 'text o: And even more recognizable across the past 70 years.'
        },
        {
          id: 'p',
          text: 'text p: And even more recognizable across the past 70 years.'
        },
        {
          id: 'q',
          text: 'text q: And even more recognizable across the past 70 years.'
        }
        ]
  };
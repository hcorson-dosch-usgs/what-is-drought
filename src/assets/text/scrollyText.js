import { time } from "vue-analytics";

export default {
      frames: [
        {
          // id is used to source image files with the same naming
          // and used to assign classes to scrolling text
          id: 'a',
          text: 'text a: Although we have been hearing a lot about drought in the western US lately, drought can happen anywhere. For example, here\'s one severe streamflow drought that occurred at a site in Ohio in late summer.'
        },
        {
          id: 'b',
          text: 'text b: Streamflow droughts like this occur whenever streamflow gets below a certain threshold. The threshold can be defined based on typical streamflow rates over the year or by day. Let’s explore how changing the threshold affects when we detect streamflow droughts at this site.'
        },
        {
          id: 'c',
          text: 'text c: To begin, let\'s start with a hydrograph, which is a plot of streamflow over time. We can compare typical values as the daily average streamflow to actual values, represented by daily streamflow.'
        },
        {
          id: 'd',
          text: 'text d: A \"fixed\" threshold is created by first calculating average streamflow across all years and days.'
        },
        {
          id: 'e',
          text: 'text e: And then calculating 10% of this annual average streamflow as the threshold. A drought is defined here as any time when streamflow is below 10% of the annual average streamflow.'
        },
        {
          id: 'f',
          text: 'text f: That\'s how these periods of drought were defined. These dry-season droughts are especially important to detect for hydropower or water system intakes where the absolute water level at any time of the year is really important.'
        },
        {
          id: 'g',
          text: 'text g: But droughts can also occur in the spring and winter when we expect wetter conditions and greater streamflow from rain showers and snow melt!'
        },
        {
          id: 'h',
          text: 'text h: For example, in this year, spring streamflow was much lower than a typical spring.'
        },
        {
          id: 'i',
          text: 'text i: To detect droughts in wetter seasons, we have to calculate a variable threshold as 10% of the average daily streamflow.'
        },
        {
          id: 'j',
          text: 'text j: Now we detect several droughts that happened in the spring. These wetter-season droughts are important to identify for city water managers trying to fill their reservoirs or for farmers planting early season crops.'
        },
        {
          id: 'k',
          text: 'text k: When we use both ways of looking at drought, we can identify droughts during the spring when streamflow is higher and during the summer when streamflow is extremely low. Having this ability to know when drought is occurring throughout the year makes it easier to use water sustainably.'
        },
        {
          id: 'l',
          text: 'text l: These seasonal patterns are even more distinct when we look at the whole year.'
        },
        {
          id: 'm',
          text: 'text m: And even more recognizable across the past 70 years.'
        }
        ]
  };
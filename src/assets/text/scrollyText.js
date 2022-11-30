import { time } from "vue-analytics";

export default {
      frames: [
        {
          // id is used to source image files with the same naming
          // and used to assign classes to scrolling text
          id: 'a',
          text: 'Drought is increasing for regions worldwide, threatening our water security and affecting our daily lives. What starts with reduced rain and snowfall can progress to impacts on soil moisture and streamflow.'
        },
        {
          // id is used to source image files with the same naming
          // and used to assign classes to scrolling text
          id: 'b',
          text: 'When there is less rain or snowfall than typical, this is known as meteorological drought.'
        },
        {
          // id is used to source image files with the same naming
          // and used to assign classes to scrolling text
          id: 'c',
          text: 'If meteorological drought continues, soil moisture becomes depleted and agricultural drought sets in. To keep crops and livestock healthy, farmers might use more water for irrigation. Extensive irrigation can impair water supplies and quality for local communities.'
        },
        {
          // id is used to source image files with the same naming
          // and used to assign classes to scrolling text
          id: 'd',
          text: 'As these conditions persist, less water moves into and through streams. Reduced streamflow has significant impact on plants, animals, and humans. When streamflow levels are unusually low, this is defined as streamflow drought. But what does "unusually low" really mean?'
        },
        {
          // id is used to source image files with the same naming
          // and used to assign classes to scrolling text
          id: 'e',
          text: 'Consider this Ohio streamgage site in the late summer of 1963. On August 15th there was a severe streamflow drought.'
        },
        {
          id: 'f',
          text: 'We can say that streamflow is "unusually low" whenever streamflow drops below a certain level or threshold. Here, that threshold was defined as 45 cubic feet per second (cfs). Why 45 cfs? There are two methods to choose that threshold, depending on the questions we are trying to answer.'
        },
        {
          id: 'g',
          text: 'To begin, we need to consider historical conditions. Over the past 70 years at this site in Ohio, average daily streamflow ranged from 100 to 2700 cfs, with August through October typically having the lowest daily streamflows during the year.'
        },
        {
          id: 'h',
          text: 'When considering records across the whole year, streamflow levels that fall below a threshold of 45 cfs are in the lowest 10%. This fixed threshold of 45 cfs is constant from day-to-day and identifies these streamflow drought events during the dry season when the lowest streamflow levels typically occur.'
        },
        {
          id: 'i',
          text: 'Using a 10% fixed threshold identifies two streamflow drought events for 1963 in the dry season. Unusually low flow at this time of year can reduce hydropower production, impair water quality, and require reservoir releases to provide water to communities. Notice that even if streamflow goes over the threshold for a brief time (up to about 5 days), this is still one drought event'
        },
        {
          id: 'j',
          text: 'But streamflow drought can also occur during wetter seasons if streamflow levels are unusually low for that time of year. To identify seasonal drought events, let\'s zoom out and look at the average daily streamflow for the last 70 years.'
        },
        {
          id: 'k',
          text: 'In 1963, spring streamflow was much lower than in a typical spring but still not as low as during the dry season.'
        },
        {
          id: 'l',
          text: 'To identify streamflow drought events during wetter times of the year, a variable threshold can be used to compare streamflow to typical conditions at that time of the year. Here, streamflow drought occurs if streamflow falls below the lowest 10% of observations ever recorded for that particular day. The result is a threshold that varies from day to day.'
        },
        {
          id: 'm',
          text: 'The variable threshold detects several streamflow drought events in the spring during the wet season. Low stream levels in the spring can reduce inflow to water supply reservoirs, affect the behavior and survival of aquatic species, and impact early season crops. This method also detects the drought in August, when streamflow was unusually low for even the dry season.'
        },
        {
          id: 'n',
          text: 'By pairing the two methods, we get a more comprehensive understanding of streamflow drought. This complete picture of drought patterns can inform water management, guide drought prediction, and help us use water more sustainably throughout the year.'
        }
        ]
  };
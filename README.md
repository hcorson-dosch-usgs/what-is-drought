# What is streamflow drought?

> _A newer version of the software may be available. See https://code.usgs.gov/wma/vizlab/what-is-drought/-/releases to view all releases._

This repo uses R and javascript to build a data visualization website about how USGS streamgages can be used to characterize streamflow drought. 

**The data visualization website can be viewed at [https://water.usgs.gov/vizlab/what-is-drought](https://water.usgs.gov/vizlab/what-is-drought).**

## Building the website locally

Clone the repo. In the directory, run `npm install` to install the required modules. Once the dependencies have been installed, run `npm run dev` to run locally from your browser.

To build the website locally you'll need `node.js` `v22.14.0` and `npm` `v10.9.2` or higher installed. To manage multiple versions of `npm`, you may [try using `nvm`](https://betterprogramming.pub/how-to-change-node-js-version-between-projects-using-nvm-3ad2416bda7e).

## Citation

B13.	Archer, A., Corson-Dosch, H., and Nell, C. June 1, 2023. What is streamflow drought? https://labs.waterdata.usgs.gov/visualizations/what-is-drought/index.html 

## Consulting subject matter experts
John Hammond and Caelan Simeone consulted on the development of this website as subject matter experts.

## Additional information
* We welcome contributions from the community. See the [guidelines for contributing](https://github.com/DOI-USGS/{app_title}/) to this repository on GitHub.
* [Disclaimer](https://code.usgs.gov/wma/vizlab/{app_title}/-/blob/main/DISCLAIMER.md)
* [License](https://code.usgs.gov/wma/vizlab/{app_title}/-/blob/main/LICENSE.md)


### Set up ScienceBase credentials 

In order to download the data from ScienceBase, you will need to first set up local credentials by running the following chunk of code with your own ScienceBase username. You will be prompted for a password (this should be your AD password if you are a USGS employee) in a separate dialogue box. This only needs to be run once for as long as your username and password are valid. Re-run when you need to update your password.

```r
library(secret);library(dplyr)
source("0_config/src/authentication_helpers.R")
set_up_auth("your_email@usgs.gov")
```

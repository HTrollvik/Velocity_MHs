# Velocity_MHs

This repository provides information and dataset that allow the reproduction of the results found in the manuscript “Velocity of magnetic holes in the solar wind from cluster multipoint measurements” under consideration in Geophysical Research Letter (GRL) journal. 

[![Publication: Under Consideration](https://img.shields.io/badge/Publication-Under%20Review-yellow?style=flat&logo=openaccess)](https://github.com/HTrollvik/Velocity_MHs)

## Data availability
Data for reproducing the analysis of the manuscript and the figures are accessible freely online. Cluster data are available through the Cluster repository. 

## General instructions
In the irfu-package there are examples of all the plots that are included in the manuscript with documentation and extensive descriptions. Cluster examples are located here: https://github.com/irfu/irfu-matlab/tree/master/plots  
In all the figures, the special notation was done by editing vector graphic files exported from MATLAB with Inkscape.
Inkscape is an open source vector graphic software, available on https://inkscape.org/.
Below we provide instructions for the reproduction of every figure

## Figure 1
Download data from the Cluster archive using the date bellow. 
The products are a)	flux__C1_CP_CIS_HIA_HS_1D_PEF, b)	'B_vec_xyz_gse__C1_CP_FGM_5VPS' , c)	Norm of b), d)	'Electron_Density__C1_CP_WHI_ELECTRON_DENSITY', e)	'temperature__C1_CP_CIS_HIA_ONBOARD_MOMENTS', f)	'velocity_gse__C1_CP_CIS_HIA_ONBOARD_MOMENTS', g)	sc_r_xyz_gse__C1_CP_AUX_POSGSE_1M

Start time = [2005 03 26 06 25 27] 
End time = [2005 03 26 06 25 36]

See examples in irfu-matlab for plotting routines 

## Figure 2 
Figure a) and b) are made in power point for illustrative purposes

c) Can be generated using running the script figure_2_plt, after having loaded the Results.mat file. 

## Figure 3
a)- e) Example of linear MH from in the time interval [2005	3 31 5 35 46.698] to [2005 3 31 5 36 46.698], event number 46 in the results table. 

a)	show norm of 'B_vec_xyz_gse__C?_CP_FGM_5VPS'  where ? indicated S/C 1-4

b)	time shifted norm of 'B_vec_xyz_gse__C?_CP_FGM_5VPS'  where the time shift can be found in the Results.mat file in the TShift struct. 

c)	'B_vec_xyz_gse__C4_CP_FGM_5VPS 

d)	Position  'sc_r_xyz_gse__C?_CP_AUX_POSGSE_1M' in X-Y plane 

In addition to the B0 vector and n_T vector, found in the results.csv file, 
e)	Same as d) but plotted in the X-Z plane 

f)-j) Example of rotational MH from the time interval [2005 03 09 21 23 38.634] to [2005 03 09 21 23 38.634] same format as for a)-e). 

## Figure 4 
Can be recreated using the fig_4_plt.m script, after having loaded the Results.mat file


### Cite as 
*TBD*

### Corresponding Author
[![Henriette Trollvik: 0000-0001-8384-8290](https://img.shields.io/badge/Henriette%20Trollvik-0000--0001--8384--8290-green?style=flat&logo=orcid)](https://orcid.org/0000-0001-8384-8290)

## Extra information

For fully reproducing the figures the irfu-matlab library can be used, available at [irfu-matlab](https://github.com/irfu/irfu-matlab). After adding the library to MATLAB's path one needs to run:

```matlab
irf
```
At the time of the latest submission of the article, the following software versions were used:

* irfu-matlab version:  v1.16.1 (devel branch)
* inkscape version:  v1.1.1
* MATLAB version: R2022a
* OS: Windows 11 Pro, build: 22000.739

## Acknowledgments

We thank the ESA Cluster team for providing data and support.  We acknowledge the use of [irfu-matlab package](https://github.com/irfu). 








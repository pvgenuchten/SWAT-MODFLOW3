# SWAT with Modflow

SWAT-MODFLOW is an integrated hydrological model that couples SWAT land surface processes with spatially-explicit groundwater flow processes. SWAT-MODFLOW is a public domain model, and as such may be used and copied freely. The model links SWAT with the newest version of MODFLOW, MODFLOW-NWT. Recharge rates are passed from SWAT HRUs to the MODFLOW grid, and groundwater-surface water interactions simulated by MODFLOW are passed to SWAT subbasin channels for routing.

Original code shared via <https://swat.tamu.edu/software/swat-modflow>

Citation: Assessing Regional-Scale Spatio-Temporal Patterns of Groundwater-Surface Water Interactions using a Coupled SWAT-MODFLOW model, Ryan T. Bailey, Tyler C. Wible, Mazdak Arabi, Rosemary M. Records, Jeffrey Ditty, 2016 John Wiley & Sons, Ltd. <https://doi.org/10.1002/hyp.10933>

License: public domain

## Windows

Includes a Visual Studio solution (.sln) for Windows.

## Docker

Build and run in a Docker container.

With docker (desktop) and git installed, run in a shell:

```bash
git clone spark-hydro/SWAT-MODFLOW3
cd SWAT-MODFLOW3
docker build -t spark-hydro/SWAT-MODFLOW3 .
```

From your model configuration folder (which contains `swatmf_link.txt`):

```bash
docker run -it -v $(pwd):/app/model spark-hydro/SWAT-MODFLOW3 bash 
```

Within the docker container:

```bash
cd /app/model
../src/swat_modflow3 
```

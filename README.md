# DigitalMammographyEnsemble
Code for classifying mammograms using an ensemble of models from the DREAM D.M. Challenge

To use the following, clone this repository and step in to the created directory
```
git clone https://github.com/Sage-Bionetworks/DigitalMammographyEnsemble.git
cd DigitalMammographyEnsemble
```

Edit `dm_job.cwl` to fill in the `docker_registry_auth` parameter.  Also add paths to the images and other folders.

To run just one job:
```
export WORK_DIR=`pwd`
docker run --rm -i \
-v ${WORK_DIR}:/workdir:rw \
-v /var/run/docker.sock:/var/run/docker.sock \
docker.synapse.org/syn5644795/docker-and-toil \
toil-cwl-runner --defaultMemory 1G  --retryCount 0 dm_sc1.cwl dm_job.cwl
```

To run an ensemble:
```
export WORK_DIR=`pwd`
docker run --rm -i \
-v ${WORK_DIR}:/workdir:rw \
-v /var/run/docker.sock:/var/run/docker.sock \
docker.synapse.org/syn5644795/docker-and-toil \
toil-cwl-runner --defaultMemory 1G  --retryCount 0 ensemble_workflow.cwl ensemble_job.cwl
```
Note: `docker.synapse.org/syn5644795/docker-and-toil` was built from the Dockerfile in this project by running:

```
docker build -t docker.synapse.org/syn5644795/docker-and-toil .
docker push docker.synapse.org/syn5644795/docker-and-toil

```

TODO:  eliminate auth param and instead mount config.json on the target machine

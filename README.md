# DigitalMammographyEnsemble
Code for classifying mammograms using an ensemble of models from the DREAM Digital Mammography Challenge

To use the following, clone this repository and step in to the created directory.

```
git clone https://github.com/Sage-Bionetworks/DigitalMammographyEnsemble.git
cd DigitalMammographyEnsemble
```

First, to try out the aggregation algorithm:

```
export WORK_DIR=/path/to/workflow/files
docker-compose -f test/docker-compose-aggregation-test.yml up
```

Now, edit `dm_sc2_job.cwl` to fill in the `docker_registry_auth` parameter.  Also add paths to the images and other folders.

To run just one job (in this case for sub-challenge 2):

```
export WORK_DIR=/path/to/workflow/files
docker run --rm -i \
-v ${WORK_DIR}:/workdir:rw \
-v /var/run/docker.sock:/var/run/docker.sock \
docker.synapse.org/syn5644795/docker-and-toil \
toil-cwl-runner --defaultMemory 200G  --defaultDisk 1G --retryCount 0 dm_inference.cwl dm_sc2_job.cwl
```

Note:  If necessary, `docker login docker.synapse.org` to pull the docker-and-toil image.

To run an ensemble:

```
export WORK_DIR=/path/to/workflow/files
docker run --rm -i \
-v ${WORK_DIR}:/workdir:rw \
-v /var/run/docker.sock:/var/run/docker.sock \
docker.synapse.org/syn5644795/docker-and-toil \
toil-cwl-runner --defaultMemory 200G  --maxMemory 200G --defaultDisk 1M --retryCount 0 \
--defaultCores 22 --maxCores 22 \
ensemble_workflow.cwl ensemble_job.cwl
```

Note: `docker.synapse.org/syn5644795/docker-and-toil` was built from the Dockerfile in this project by running:

```
docker build -t docker.synapse.org/syn5644795/docker-and-toil .
docker push docker.synapse.org/syn5644795/docker-and-toil
```

TODO:  eliminate auth param and instead mount config.json on the target machine

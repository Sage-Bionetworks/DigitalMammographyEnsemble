# DigitalMammographyEnsemble
Code for classifying mammograms using an ensemble of models from the DREAM D.M. Challenge
```
eval $(docker-machine env bm11)
export ENGINE_HOME=/home/dreamuser
export WORK_DIR=${ENGINE_HOME}/cwl
docker run --rm -i \
-v ${WORK_DIR}:/workdir:rw \
-v /data:/data:ro \
-v /var/run/docker.sock:/var/run/docker.sock \
docker.synapse.org/syn5644795/docker-and-toil \
toil-cwl-runner --defaultMemory 1G  --retryCount 0 ensemble_workflow.cwl ensemble_job.cwl
```
Note: `docker.synapse.org/syn5644795/docker-and-toil` was built from the Dockerfile by running:

```
docker build -t docker.synapse.org/syn5644795/docker-and-toil .
docker push docker.synapse.org/syn5644795/docker-and-toil

```

Note:  Copied  `dm_sc1.cwl` and `dm_job.cwl` to `/home/dreamuser/cwl/` on the target machine, `bm11`, then edited `ensemble_workflow.cwl` to fill in the `docker_registry_auth` parameter.

TODO:  put auth param elsewhere, e.g. make it an env var to the container

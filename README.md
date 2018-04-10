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

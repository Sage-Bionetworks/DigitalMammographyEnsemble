FROM python:2.7

# install toil
RUN apt-get update && apt-get install -y libssl-dev libffi-dev
RUN pip install toil[all]
RUN pip install boto
WORKDIR /workdir

# now install docker, following the instructions here: https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-docker-ce-1
RUN apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg |  apt-key add -

RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"

RUN apt-get update   

RUN apt-get install -y docker-ce

RUN pip install pandas

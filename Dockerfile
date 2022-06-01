FROM ubuntu:20.04

RUN apt-get update && apt-get install -y \
    software-properties-common
RUN add-apt-repository universe
RUN apt-get update && apt-get install -y \
    python3.8 \
    python3-pip

RUN pip3 install awscli

# Install tarraform
RUN apt-get install -y curl unzip
RUN cd
RUN rm -rf terraform
RUN mkdir terraform
RUN cd terraform
RUN rm -rf terraform_1.2.1_linux_amd64.zip
RUN curl -O https://releases.hashicorp.com/terraform/1.2.1/terraform_1.2.1_linux_amd64.zip
RUN unzip terraform_1.2.1_linux_amd64.zip -d  /usr/local/bin/
#RUN rm -rf terraform_1.2.1_linux_amd64.zip
# That's it - all done
# Build an ubuntu image with awscli and terraform support and one Linux account per
# AWS account
#
# 1) Put this Dockerfile in a folder.
# 2) Create a sub-folder called home and sub-folders within that for each Linux
#    account. These sub-folders can contain any files you want added to the
#    Linux account's home directory, e.g. .bash_profile, .aws, etc.
# 3) Build the image:
#    docker build -t andypowe11/ubuntu-awscli .
# 4) Run the container:
#
#    docker run -i -t -h ubuntu-awscli andypowe11/ubuntu-awscli _account_
#
#    or:
#
#    docker run -i -t -v C:/Users/ap/Docker/ubuntu-awscli/home:/home \
#        -h ubuntu-awscli andypowe11/ubuntu-awscli _account_
#
#    if you want to mount the Linux hone directories on the host filesystem.
#    Doing this means that content, e.g. .bash_history, is preserved across
#    sessions.
#
FROM ubuntu:20.04
MAINTAINER Andy Powell <andy.powell@eduserv.org.uk>
# Create a user for each AWS account
# For each user, copy home directory files from folder with same name as
# the user
RUN sudo adduser --disabled-password --gecos '' tf
RUN sudo adduser tf sudo
RUN mkdir /home/tf/.aws
ADD home/tf/* /home/tf/.aws/
RUN sudo chmod 600 /home/tf/.aws/*
RUN sudo chown -R tf:tf /home/tf/.aws
# Give sudo access to the accounts
RUN sudo echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
# Run as root initially...
USER root
# ...but immediately su to the username passed as an argument
ENTRYPOINT ["/bin/su", "--login"]
# Default user
CMD ["tf"]
# Set up the Ubuntu instance correctly
RUN sudo apt-get update
RUN sudo apt-get -y upgrade
RUN sudo apt-get -y install python
RUN sudo apt-get -y install groff
RUN sudo apt-get -y install curl
RUN sudo apt-get -y install man
RUN sudo apt-get -y install unzip
RUN sudo apt-get -y install wget
# Install pip
RUN cd /tmp
RUN sudo curl -O https://bootstrap.pypa.io/get-pip.py
RUN sudo python get-pip.py
RUN sudo rm get-pip.py
RUN cd
RUN sudo pip install awscli
# Install tarraform
RUN cd
RUN rm -rf terraform
RUN mkdir terraform
RUN cd terraform
RUN rm -f terraform_1.2.1_linux_amd64.zip
RUN curl -O https://releases.hashicorp.com/terraform/1.2.1/terraform_1.2.1_linux_amd64.zip
RUN unzip -o terraform_1.2.1_linux_amd64.zip
RUN rm -f terraform_0.7.13_linux_amd64.zip
# That's it - all done

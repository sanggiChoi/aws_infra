FROM centos:7
#FROM amazonlinux:latest

LABEL "purpose"="local"

RUN yum update -y && yum install net-tools tar wget unzip curl -y && \
    yum install openssh openssh-clients openssl-libs git ansible -y && \
    yum clean all

# Default Time Zone Change
RUN rm -f /etc/localtime
RUN ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime

# install terraform
RUN cd /tmp && curl -O https://releases.hashicorp.com/terraform/0.11.10/terraform_0.11.10_linux_amd64.zip
RUN cd /tmp && unzip terraform_0.11.10_linux_amd64.zip
RUN mv /tmp/terraform /usr/local/bin/
RUN rm -rf /tmp/terraform_0.11.10_linux_amd64.zip

# install packer
RUN cd /tmp && curl -O https://releases.hashicorp.com/packer/1.3.1/packer_1.3.1_linux_amd64.zip
RUN cd /tmp && unzip packer_1.3.1_linux_amd64.zip
RUN mv /tmp/packer /usr/local/bin/
RUN rm -rf /tmp/packer_1.3.1_linux_amd64.zip

# install direnv
RUN wget -O direnv https://github.com/direnv/direnv/releases/download/v2.17.0/direnv.linux-amd64
RUN chmod +x direnv
RUN mv direnv /usr/local/bin/
RUN echo 'eval "$(direnv hook bash)"' >> ~/.bashrc

# install jq
RUN JQ=/usr/bin/jq
RUN wget -O jq https://stedolan.github.io/jq/download/linux64/jq 
RUN chmod +x jq
RUN mv jq /usr/local/bin/
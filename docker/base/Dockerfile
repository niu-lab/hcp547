# use the ubuntu base image
FROM ubuntu:16.04

# Acknowledgements to BreakPointSurveyor:
# https://github.com/ding-lab/BreakPointSurveyor/blob/master/docker/Dockerfile

ENV LC_ALL="C.UTF-8"
ENV LANG="C.UTF-8"

## for apt to be noninteractive
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true


RUN apt-get update && apt-get install -y \
   # Essential
    apt-utils


# Acknowledgements to https://stackoverflow.com/questions/8671308/non-interactive-method-for-dpkg-reconfigure-tzdata:
## preesed tzdata, update package index, upgrade packages and install needed software
RUN echo "tzdata tzdata/Areas select Asia" > /tmp/preseed.txt; \
    echo "tzdata tzdata/Zones/Asia select Chongqing" >> /tmp/preseed.txt; \
    debconf-set-selections /tmp/preseed.txt && \
    rm /etc/timezone && \
    rm /etc/localtime && \
    apt-get update && \
    apt-get install -y tzdata

## cleanup of files from setup
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# install softwares
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    zip \
    unzip \
    curl \
    wget \
    pkg-config \
    vim \
   # lib
    libbz2-dev \
    liblzma-dev \
    zlib1g-dev \
    libncurses5-dev \
    libncursesw5-dev \
   # R related
    r-base \
   # Python related
    python \
    python-pip \
    python3 \
    python3-pip \
   # Java related
    openjdk-8-jdk \
    openjdk-8-jre \
    && apt-get clean

# bwa
RUN cd /usr/local/ \
&& git clone https://github.com/lh3/bwa.git \
&& cd bwa \
&& git checkout v0.7.17 \
&& make

# samtools
RUN cd /usr/local/ \
&& wget https://github.com/samtools/samtools/releases/download/1.8/samtools-1.8.tar.bz2 \
&& tar jxvf samtools-1.8.tar.bz2 \
&& cd samtools-1.8 \
&& make

# fastqc
RUN cd /usr/local/ \
&& wget https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.8.zip \
&& unzip fastqc_v0.11.8.zip \
&& chmod a+x /usr/local/FastQC/fastqc

# fastp
RUN cd /usr/local/ \
&& git clone https://github.com/OpenGene/fastp.git \
&& cd fastp \
&& git checkout v0.18.0 \
&& make

# picard
RUN cd /usr/local/ \
&& mkdir picard \
&& cd picard \
&& wget https://github.com/broadinstitute/picard/releases/download/2.18.1/picard.jar

# gatk
RUN cd /usr/local/ \
&& wget "https://github.com/broadinstitute/gatk/releases/download/4.0.4.0/gatk-4.0.4.0.zip" \
&& unzip gatk-4.0.4.0.zip \
&& mv ./gatk-4.0.4.0 gatk4/

# SnpSift.jar
RUN cd /usr/local/ \
&& curl -L https://sourceforge.net/projects/snpeff/files/snpEff_latest_core.zip > snpEff_latest_core.zip \
&& unzip snpEff_latest_core.zip

# VarDictJava
RUN cd /usr/local/ \
&& wget https://github.com/AstraZeneca-NGS/VarDictJava/releases/download/v1.5.7/VarDict-1.5.7.tar \
&& tar xvf VarDict-1.5.7.tar

# gpyflow
RUN cd /usr/local/  \
&& git clone https://github.com/niu-lab/GPyFlow-CLI.git \
&& cd GPyFlow-CLI/ \
&& python3 setup.py install
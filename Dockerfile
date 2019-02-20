# use the ubuntu base image
FROM hcp547:base

RUN mkdir /hcp547

COPY bin/* /hcp547/

RUN pip3 install click==7.0

WORKDIR /hcp547/

ENV PATH /hcp547:/usr/local/bwa:/usr/local/samtools-1.8:/usr/local/FastQC:/usr/local/fastp:/usr/local/gatk4:/usr/local/VarDict-1.5.7/bin:$PATH

CMD ["hcp547","-h"]
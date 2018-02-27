FROM debian:8 

LABEL authors="remi-andre.olsen@scilifelab.se" \
    description="Docker image of ALLPATHS-LG de novo genome assembler"


RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    g++-4.9 \
    make \
    picard-tools \
    graphviz && \
    update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.9 10 && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.9 10

RUN cd /opt && \
    wget -O - ftp://ftp.broadinstitute.org/pub/crd/ALLPATHS/Release-LG/latest_source_code/allpathslg-52488.tar.gz | tar zx && \
    cd allpathslg-52488 && ./configure && make && make install

RUN apt-get autoremove -y make wget && \
    rm -rf /var/lib/apt/lists/* && apt-get clean && \
    rm -rf /opt/allpathslg-52488

 

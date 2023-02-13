FROM ubuntu:latest

ENV TZ=Europe/Oslo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt update && \
    apt install -y software-properties-common && \
    add-apt-repository ppa:inivation-ppa/inivation

RUN apt update && \
    apt-get install -y git dv-processing dv-runtime build-essential cmake pkg-config libboost-all-dev libssl-dev libopencv-dev libopencv-contrib-dev liblz4-dev libzstd-dev libfmt-dev libcaer-dev



RUN sed -i "s|"127.0.0.1"|"0.0.0.0"|g" /usr/lib/systemd/system/dv-runtime.service && \
    sudo systemctl daemon-reload && \
    sudo systemctl enable dv-runtime.service && \
    sudo systemctl restart dv-runtime.service && \
    sudo systemctl status dv-runtime.service


#RUN mkdir /dv-runtime && \
#    cd /dv-runtime
    
#RUN git clone https://gitlab.com/inivation/dv/dv-runtime.git && \
#    cd dv-runtime && \
#    cmake -DCMAKE_INSTALL_PREFIX=/usr DVR_ENABLE_PROFILER=ON . && \
#    make && \
#    make install

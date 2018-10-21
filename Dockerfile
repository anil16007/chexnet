FROM tensorflow/tensorflow:1.11.0-gpu-py3

COPY . /opt/chexnet

RUN add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y python3.6 && \
    apt-get install -y libsm6 libxext6 libxrender1 libfontconfig1 libxrender-dev

RUN apt-get install python3-pip -y

WORKDIR /opt/chexnet
RUN python3.6 -m pip install -r requirements.txt
RUN python3.6 -m pip install opencv-contrib-python

EXPOSE 3000/tcp
EXPOSE 6006/tcp

ENTRYPOINT [ "python3.6", "train.py" ]
CMD ["tensorboard --log-dir=/var/log/tensorboard"]

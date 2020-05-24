# TensorFlow Improved Docker

This Dockerfile adds some tools to the vanilla TensorFlow with Python 3 docker image, namely:

 - tmux
 - Matplotlib with GUI support

To build the docker image, run:
```
docker build -t mytf -f /path/to/Dockerfile .
```

To run this docker image with GUI support, launch it as follows:

```
docker run -it --rm --network=host -p 6006:6006 -v /path/to/host/workspace:/workspace -v /tmp/tflogs:/tflogs -u $(id -u):$(id -g) -v `/path/to/host/datasets`:/datasets/ --gpus all -e DISPLAY=$DISPLAY mytf bash
```

Make sure to adapt the paths `/path/to/host/workspace` and `/path/to/host/datasets` (and add new paths as you see fit).

To launch tensorboard, run:
```
#!/bin/sh
echo Access tensorboard via http://`hostname`:6006
tensorboard --bind_all --logdir /tflogs/ 2> /dev/null
```
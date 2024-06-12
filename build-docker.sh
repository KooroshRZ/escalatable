#!/bin/bash

sudo docker build -t krypton-lab .
sudo docker run --rm -p 0.0.0.0:2222:22 -it --name krypton-lab krypton-lab
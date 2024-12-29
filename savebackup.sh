#!/bin/bash

docker cp arma:"$(cat pathsave)" ./Player_$(date +%Y%m%d_%H%M%S)

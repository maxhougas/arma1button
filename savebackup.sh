#!/bin/bash

docker cp arma:"$(pathsave)" ./Player_$(date +%Y%m%d_%H%M%S)

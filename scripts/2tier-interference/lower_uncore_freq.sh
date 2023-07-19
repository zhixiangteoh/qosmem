#!/bin/bash

modprobe msr
wrmsr 0x620 0x0101

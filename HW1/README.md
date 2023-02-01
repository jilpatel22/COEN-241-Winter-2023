# COEN-241-Winter-2023

This repository will contain all the Homework for the Cloud Computing subject.

## HW1

Homework 1 Evaluates the performannce of CPU and Disk I/O on Virtual Machine and Docker container by executing numerous instructions.
To install virtual machine on Host operating system it requires hypervisor such as QEMU. We have installed QEMU on my host machine and then with the help of WSL
(Windows subsytem for linux) we installed Ubuntu Virtual Machine.

To install Docker on windows we downloaded docker desktop and then on top of it we downloaded Ubuntu image using `docker run ubuntu`. `docker run -it ubuntu` runs the
ubuntu shell in interactive mode. Then we ran the shell script to view the performance of the system.

#!/bin/bash

i=1
while [ $i -lt 6 ]
do
	echo "Test Case: $i"
	sysbench --test=fileio --file-total-size=4G --file-test-mode=rndrw --max-time=30 --max-requests=0 --file-extra-flags=direct prepare
	sysbench --test=fileio --file-total-size=4G --file-test-mode=rndrw --max-time=30 --max-requests=0 --file-extra-flags=direct run
	sleep 60
	sysbench --test=fileio --file-total-size=4G --file-test-mode=rndrw --max-time=30 --max-requests=0 --file-extra-flags=direct cleanup
	i=`expr $i + 1`
done
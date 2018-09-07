#!/bin/bash
for i in *.svg
do
	filename="${i%.*}"
	convert \-flatten $filename.pdf $filename.png
done

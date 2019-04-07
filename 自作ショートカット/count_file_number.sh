#!/bin/sh
#Author:Tomoya Tsukimi
#Last update:181107

dir=$1

count=`ls -l $dir | wc -l`
echo $(($count-1))



#!/bin/sh
#Author:Tomoya Tsukimi
#Last update:190407

add_file=$1
commnet=$2 #コメントに空白あるとうまく認識しない


git add $add_file
git commit -m $commnet
git push origin master

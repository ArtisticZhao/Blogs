#!/bin/bash

tar -zcvf site.tar.gz _site/
scp site.tar.gz zyh@ethereal.work:/home/zyh/
ssh zyh@ethereal.work "rm -rf _site/*"
ssh zyh@ethereal.work "tar -zxvf site.tar.gz"

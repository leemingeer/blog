#!/bin/bash

hexo clean
hexo generate
rm -rf /alidata/www/default
cp -R public /alidata/www/default
chown -R www.www /alidata/www/default

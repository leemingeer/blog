#!/bin/bash

hexo clean
hexo generate
rm -rf /alidata/www/blog
cp -R public /alidata/www/blog
chown -R www.www /alidata/www/blog

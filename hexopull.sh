#!/bin/bash
git add .
git commit -m "..."
git push origin hexo
hexo clean
hexo g -d 
send "renblog"
send "renhao619818859"

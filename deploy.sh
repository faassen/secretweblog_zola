#!/bin/bash
zola build
rsync -rvu --del public/ faassen@startifact.com:/var/www/blog.startifact.com/
 

#!/bin/bash

fswatch -xn urls | while read file event; do
   ./helpers/url_opener.sh $file
done

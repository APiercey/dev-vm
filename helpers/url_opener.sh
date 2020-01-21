# fswatch -xn urls | while read file event; do
#    ./url_opener.sh $file
# done

while IFS= read -r line; do
  if [ -f $line ]; then
      url=$(head -n 1 $line)
      open $url
  fi
done <<< "$1"

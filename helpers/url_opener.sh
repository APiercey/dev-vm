while IFS= read -r line; do
  if [ -f $line ]; then
      url=$(head -n 1 $line)
      open $url &> /dev/null
  fi
done <<< "$1"

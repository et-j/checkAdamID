#!/bin/bash

echo "Input the absolute path to the input file:"
read adamIDInput
adamID=$( cat "$adamIDInput" )

adamIDArray=()
adamIDNamesArray=()
adamIDUnique=$( echo "$adamID" | sort | uniq )
uniqueCount=$(echo "$adamIDUnique" | wc -w)
echo "Entries in original document:$(echo "$adamID" | wc -w)"
echo "Unique entries in document: $uniqueCount"
completeCount="0"

for i in $adamIDUnique; do
  itunesResponse=$( curl -s "https://itunes.apple.com/lookup?id=${i}" )
  itunesCount=$( echo "$itunesResponse" | grep "resultCount" | sed -e 's/^.*://' -e 's/,.*//' )
  if [ "$itunesCount" = "1" ]; then
    adamIDName=$( echo "$itunesResponse" | tr "," "\n" | grep trackName | sed -e 's/^.*://' )
    adamIDArray+=(${i})
    adamIDNamesArray+=("${i} - ${adamIDName}")

  fi
  let "completeCount++"
  let "completePercentage = $completeCount * 100 / $uniqueCount"
  echo "${completePercentage}%\r\c"
done

echo "\rValid app count: $( echo ${adamIDArray[*]} | wc -w )"
echo "App IDs: ${adamIDArray[*]}"
echo "App Titles:"
for each in "${adamIDNamesArray[@]}"; do
  echo "$each"
done

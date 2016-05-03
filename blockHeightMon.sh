#!/bin/bash

rm -f peersList.csv
rm -f blockHeight.out
rm -f peersList.out
rm -rf blockHeightSorted.out
localBlockHeight=`curl -s http://localhost:7000/api/loader/status/sync | cut -d: -f5 | cut -d} -f1`
echo "Local Block Height: " $localBlockHeight
python lpeermon.py --url http://localhost:7000 --output-file peersList.csv --timeout 0.8

cat peersList.csv | awk -F',' '{system ("echo "$3)}' > blockHeight.out
#cat blockHeight.out |sort -gr > blockHeightSorted.out
cat blockHeight.out | awk -v l="$localBlockHeight" '
BEGN {
        goodHeight=0
        badHeight=0
        b=0
        n=0
        l-=10
}


{
if ($1 >= l) {
        goodHeight += $1
        n++
}
else if ($1 <= l)  {
        badHeight += $1
        b++
        }
}



END {
print "Current Average Height near local Height: " goodHeight / n
print "Nodes At Current Average Height: " n
print "Current Average Height Below Local Height: " badHeight / b
print "Nodes below Average Height: " b
}

'

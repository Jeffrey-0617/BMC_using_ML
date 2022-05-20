# get the label

cost_time=6
# check the results to get the corresponding label
result=$(grep -c "VERIFICATION FAILED" log.txt)
echo $result
if [ $(grep -c "VERIFICATION SUCCESSFUL" log.txt) -ne 0 -o $(grep -c "VERIFICATION FAILED" log.txt) -ne 0 ]
then
  if [ $cost_time -le 1 ]
  then
    echo "1"
  elif [ $cost_time -gt 1 -a $cost_time -le 60 ]
  then
    echo "2yes"
  elif [ $cost_time -gt 60 -a $cost_time -le 300 ]
  then
    echo "3"
  fi
elif [ $(grep -c "Timed out" log.txt) -ne 0 ]
then
  echo "4"
elif [ $(grep -c "VERIFICATION UNKNOWN" log.txt) -ne 0 ]
then
  echo "5"
elif [ $(grep -c "ERROR" log.txt) -ne 0 ]
then
  echo "6"
fi

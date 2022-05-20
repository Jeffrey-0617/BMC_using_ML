# define arrays to store flags
SMT=("--z3" "--boolector" "--yices" "--mathsat")
EM=("--ir" "--floatbv" "--fixedbv")
VM=("--k-induction" "--falsification" "--incremental-bmc")
step=("--max-k-step 10 --k-step 1" "--max-k-step 30 --k-step 2" "--max-k-step 50 --k-step 4" "--max-k-step 100 --k-step 8" "--max-k-step 200 --k-step 16" "--max-k-step 400 --k-step 32" "--max-k-step 800 --k-step 64" "--max-k-step 1600 --k-step 128")


# get parameter vectors to complete the feature vectors
for solver in ${SMT[@]}
do
  for encode in ${EM[@]}
  do
    #----------------------------------------------------------------------------------------------------------
    # if SMT solver is boolector and Encode Method is ir,
    # then only falsification can be chosen
    if [[ "$solver" == "--boolector" ]] && [[ "$encode" == "--ir" ]]
    then
      echo $solver >> fv.txt
      echo $encode >> fv.txt
      echo "--falsification" >> fv.txt
      echo "NA" >>fv.txt

      # get the label
      start_time=$(date +%s)
      esbmc $solver $encode --falsification --timeout 5m $name > log.txt
      end_time=$(date +%s)
      cost_time=$[ $end_time-$start_time ]
      # check the results to get the corresponding label
      if [ $(grep -c "VERIFICATION SUCCESSFUL" log.txt) -ne 0 -o $(grep -c "VERIFICATION FAILED" log.txt) -ne 0 ]
      then
        if [ $cost_time -le 1 ]
        then
          echo "1" >> fv.txt
        elif [ $cost_time -gt 1 -a $cost_time -le 60 ]
        then
          echo "2" >> fv.txt
        elif [ $cost_time -gt 60 -a $cost_time -le 300 ]
        then
          echo "3" >> fv.txt
        fi
      elif [ $(grep -c "Timed out" log.txt) -ne 0 ]
      then
        echo "4" >> fv.txt
      elif [ $(grep -c "VERIFICATION UNKNOWN" log.txt) -ne 0 ]
      then
        echo "5" >> fv.txt
      elif [ $(grep -c "ERROR" log.txt) -ne 0 ]
      then
        echo "6" >> fv.txt
      else
        echo "7" >> fv.txt
      fi

      # put the feature vector into CSV file
      python fv.py
      # remove the parameter vector
      sed -i '' -e '$ d' fv.txt
      sed -i '' -e '$ d' fv.txt
      sed -i '' -e '$ d' fv.txt
      sed -i '' -e '$ d' fv.txt
      sed -i '' -e '$ d' fv.txt

      #echo $solver $encode "--falsification"
    else
      for verifi in ${VM[@]}
      do
        #----------------------------------------------------------------------------------------------------------
        # if use k-induction or incremental-bmc, ESBMC can limit the maximum K rounds
        if [ "$verifi" == "--falsification" ]
        then
          echo $solver >> fv.txt
          echo $encode >> fv.txt
          echo $verifi >> fv.txt
          echo "NA" >> fv.txt

          # get the label
          start_time=$(date +%s)
          esbmc $solver $encode $verifi --timeout 5m $name > log.txt
          end_time=$(date +%s)
          cost_time=$[ $end_time-$start_time ]
          # check the results to get the corresponding label
          if [ $(grep -c "VERIFICATION SUCCESSFUL" log.txt) -ne 0 -o $(grep -c "VERIFICATION FAILED" log.txt) -ne 0 ]
          then
            if [ $cost_time -le 1 ]
            then
              echo "1" >> fv.txt
            elif [ $cost_time -gt 1 -a $cost_time -le 60 ]
            then
              echo "2" >> fv.txt
            elif [ $cost_time -gt 60 -a $cost_time -le 300 ]
            then
              echo "3" >> fv.txt
            fi
          elif [ $(grep -c "Timed out" log.txt) -ne 0 ]
          then
            echo "4" >> fv.txt
          elif [ $(grep -c "VERIFICATION UNKNOWN" log.txt) -ne 0 ]
          then
            echo "5" >> fv.txt
          elif [ $(grep -c "ERROR" log.txt) -ne 0 ]
          then
            echo "6" >> fv.txt
          else
            echo "7" >> fv.txt
          fi

          python fv.py
          sed -i '' -e '$ d' fv.txt
          sed -i '' -e '$ d' fv.txt
          sed -i '' -e '$ d' fv.txt
          sed -i '' -e '$ d' fv.txt
          sed -i '' -e '$ d' fv.txt
          #echo $solver $encode $verifi
        else
          for s in "${step[@]}"
          do
            #----------------------------------------------------------------------------------------------------------
            echo $solver >> fv.txt
            echo $encode >> fv.txt
            echo $verifi >> fv.txt
            echo $s >> fv.txt


            # get the label
            start_time=$(date +%s)
            esbmc $solver $encode $verifi $s --timeout 5m $name > log.txt
            end_time=$(date +%s)
            cost_time=$[ $end_time-$start_time ]
            # check the results to get the corresponding label
            if [ $(grep -c "VERIFICATION SUCCESSFUL" log.txt) -ne 0 -o $(grep -c "VERIFICATION FAILED" log.txt) -ne 0 ]
            then
              if [ $cost_time -le 1 ]
              then
                echo "1" >> fv.txt
              elif [ $cost_time -gt 1 -a $cost_time -le 60 ]
              then
                echo "2" >> fv.txt
              elif [ $cost_time -gt 60 -a $cost_time -le 300 ]
              then
                echo "3" >> fv.txt
              fi
            elif [ $(grep -c "Timed out" log.txt) -ne 0 ]
            then
              echo "4" >> fv.txt
            elif [ $(grep -c "VERIFICATION UNKNOWN" log.txt) -ne 0 ]
            then
              echo "5" >> fv.txt
            elif [ $(grep -c "ERROR" log.txt) -ne 0 ]
            then
              echo "6" >> fv.txt
            else
              echo "7" >> fv.txt
            fi

            python fv.py
            sed -i '' -e '$ d' fv.txt
            sed -i '' -e '$ d' fv.txt
            sed -i '' -e '$ d' fv.txt
            sed -i '' -e '$ d' fv.txt
            sed -i '' -e '$ d' fv.txt
            #echo $solver $encode $verifi $s
          done
        fi
      done
    fi
  done
done


#start_time=$(date +%s)
#esbmc test.c > log.txt
#end_time=$(date +%s)
#cost_time=$[ $end_time-$start_time ]

#result=$(tail -1 log.txt)
#if [[ "$result" == "VERIFICATION SUCCESSFUL" ]] || [[ "$result" == "VERIFICATION FAILED" ]]
#then
#  echo $cost_time
#elif [ "$result" == "Timed out" ]
#then
#  echo "time out"
#elif [ "$result" == "VERIFICATION UNKNOWN" ]
#then
#  echo "unknown"
#elif [ "$result" == "ERROR" ]
#then
#  echo "error"
#fi

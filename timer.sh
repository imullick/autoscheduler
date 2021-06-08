#!/bin/bash

timestampnow=$(TZ=Asia/Calcutta date) # Tue Jun  1 21:57:03 IST 2021
set -- $timestampnow
daytoday=$(echo $1)
echo "Happy $daytoday!"
datetoday=$(echo $2 $3)
echo "Date: $datetoday"
timenow=$(echo $4)
echo "Current Time is: $timenow"
timenow="${timenow:0:5}"

echo ""

echo "Note - Any changes made in the CSV file will be updated here automatically within 60 seconds"
echo ""

echo "Your meetings for the day are - "
echo ""

count=1

while IFS="," read -r Day Time Subject Links Notes
do

  if [ ! -z "$Links" ] && [ "$Day" = "$daytoday" ]
    then
      echo "Time: $Time"
# Convert time to 12:01PM types and then   Timeless= gdate --date="$Time - 1 minute" +%T
      Timeless=$(gdate --date="$Time IST -60 sec" "+%R")

      if test -z "$Subject"
        then echo "Subject: None"
      else echo "Subject: $Subject"
      fi

      echo "Link: $Links"

      if test -z "$Notes"
        then echo "Notes: None"
      else echo "Notes: "$Notes""
      fi
      echo ""

  fi

  if [ "$Day" = "$daytoday" ] && [ "$Timeless" = "$timenow" ]
    then
      # Links="${Links%?}"
      say "It's time for your meeting!"
      open -a "Google Chrome" $Links
  fi


# For reminders in which you don't want to be redirected to a link ->
  if [ "$Subject" = "Reminder" ] && [ "$Day" = "$daytoday" ] && [ -z "$Links" ]
    then
      echo "----------"
      echo "Reminder $count"
      echo "----------"
      echo "Time: $Time"
      echo "Subject: $Subject"
      echo "Notes: "$Notes""
      echo ""
      count=`expr $count + 1`
  fi

  if [ "$Subject" = "Reminder" ] && [ "$Time" = "$timenow" ]
    then
      say "Reminder: "$Notes"!"
  fi


done < <(tail -n +2 scheduleorigcsv.csv)
# scheduleorigcsv.csv should be replaced by the name of the CSV file in your laptop.

echo "--------------------------------------"
echo "Press control C at any time to stop :)"
echo "--------------------------------------"

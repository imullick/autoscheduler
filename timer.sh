#!/bin/bash

# Time Calculations for display and use in code
timestampnow=$(TZ=Asia/Calcutta date) # FORMAT -> Tue Jun  1 21:57:03 IST 2021
set -- $timestampnow                  # Setting timestamp as current date and time
daytoday=$(echo $1)                   # Selecting day from timestamp
echo "Happy $daytoday!"
datetoday=$(echo $2 $3)               # Selecting month and date from timestamp
echo "Date: $datetoday"
timenow=$(echo $4)                    # Selecting current time from timestamp
echo "Current Time is: $timenow"
timenow="${timenow:0:5}"

# Printing required information for user
echo ""

echo "Note - Any changes made in the CSV file will be updated here automatically within 60 seconds"
echo ""

echo "Your meetings for the day are - "
echo ""

# To count number of reminders
count=1

# Loop to read CSV File
while IFS="," read -r Day Time Subject Links Notes # Headings of columns of CSV file
do

  if [ ! -z "$Links" ] && [ "$Day" = "$daytoday" ]  # Checking if a link is present (not null) and day is current day
    then                                            # Printing required information for classes
      echo "Time: $Time"

# Calculating time one minute less than time for classes, so that links for classes
# can be opened one minute before their designated time.

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

# Opening link and announcing meeting at designated time

  if [ "$Day" = "$daytoday" ] && [ "$Time" = "$timenow" ]
    then
      # Links="${Links%?}"
      say "It's time for your meeting!"
      open -a "Google Chrome" $Links
  fi


# For reminders where you don't want to be redirected to a link, eg- assignment due tomorrow ->
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

# Announcing reminder at designated time

  if [ "$Subject" = "Reminder" ] && [ "$Timeless" = "$timenow" ]
    then
      say "Reminder: "$Notes"!"
  fi


done < <(tail -n +2 finalschedule.csv)
echo "--------------------------------------"
echo "Press control C at any time to stop :)"
echo "--------------------------------------"

This is the instruction manual. When you go through this, you will be able to understand how to use the code that we've developed.

Along with this document, there are 2 more -
1. The code (.sh file) 
2. A CSV File

Note - This tool was developed primarily for time tables and class links (timings as per the Thapar timetable).
However, you can add more rows to the table of the CSV Document for any other meetings scheduled. Ensure that you add all rows above the last row.

For MacOS users,
1. Save both the files in the same folder/location(Desktop, Documents, Downloads, etc.).

2. Open the terminal, and access the folder in which the documents are present.
Here's a useful link for basic terminal commands -
https://scotch.io/bar-talk/10-need-to-know-mac-terminal-commands#:~:text=So%20navigate%20to%20the%20desired,%2C%20simply%20run%20%60rmdir%20%60.

3. Now, to run the .sh file more than once (to check for links at any given time),
you need to install a package.
Copy and paste this command in the terminal, and press Enter ->

>>/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

It will install Homebrew
Now, we require a special command from Homebrew, copy + paste this command in the terminal, and press Enter ->

>>brew install watch


4. To run the date commands, we require another package. Copy + paste this command in the terminal, and press Enter ->

>>brew install coreutils


5. Now you're all set to run the code. But before that, you need to update your CSV file.

Open your CSV File, it should open in Microsoft Excel/Numbers and will be in the form of a table.
From your timetable, extract the Day, Time (in 24 hour format), Subject, Links, Notes (E.g. – Project Evaluation), and put the details in the appropriate columns in the table.
Save the file.

6. After this, you're all set! Copy + paste the following command in the terminal, and press Enter ->
>>watch -n 60 bash timer.sh -m


Note - You don't need to go through all the steps again and again. All you have to do is run the command in step 6 at least 2 minutes before the classes of the day start. The code has been programmed to open the link about a minute BEFORE the class starts. If you miss that window (i.e. you don't run this command 2 minutes before), then you'll have to open the link manually, like you always do.

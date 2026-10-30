#!/bin/bash

#!/bin/bash

# Create a variable (no spaces around =)
project_name="zenith_retail"
data_folder="month-1/data"
today="2024-01-15"

# Use a variable with $
echo "Project: $project_name"
echo "Data folder: $data_folder"
echo "Today: $today"

#!/bin/bash

echo "What is your name?"
read user_name

echo "Hello $user_name! Welcome to the DE pipeline."

#!/bin/bash

# Capture the current date
current_date=$(date +%Y-%m-%d)

# Capture how many files are in a folder
file_count=$(ls month-1/data/ | wc -l)

echo "Today is: $current_date"
echo "Files in data folder: $file_count"

#!/bin/bash

revenue=125000

if [ $revenue -gt 100000 ]; then
    echo "High performing store"
elif [ $revenue -gt 50000 ]; then
    echo "Average performing store"
else
    echo "Needs attention"
fi
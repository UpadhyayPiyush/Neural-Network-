#!/bin/bash

# Number of days for which you want to generate commits
DAYS=365

# Loop over the past 90 days
for i in $(seq 0 $DAYS); do
    # Set the date to i days ago using the Windows-friendly date format
    DATE=$(date -d "$i days ago" '+%Y-%m-%d')

    # Generate a random number of commits between 1 and 10
    NUM_COMMITS=$(( ( RANDOM % 10 ) + 1 ))

    # Loop to create multiple commits for the same day
    for j in $(seq 1 $NUM_COMMITS); do
        # Create a dummy file for each commit
        echo "Commit number $j for $DATE" > "commit_${DATE}_$j.txt"

        # Stage the file
        git add "commit_${DATE}_$j.txt"

        # Commit with a specific date
        GIT_AUTHOR_DATE="$DATE 12:00:00" GIT_COMMITTER_DATE="$DATE 12:00:00" git commit -m "Commit $j for $DATE"
    done
done

# Push all the commits to GitHub
git push origin main  # Change 'main' to 'master' if needed

#!/bin/bash

# Configuration
DAYS_AGO_START=64      # Start committing from this many days ago
DAYS_AGO_END=50         # Stop committing this many days ago
COMMITS_PER_DAY=4       # Number of commits to make per day
FILE_TO_UPDATE="history.txt"

# Ensure we are in a git repository
if [ ! -d ".git" ]; then
    echo "Error: This script must be run inside a Git repository."
    exit 1
fi

echo "Starting back-dated commits from $DAYS_AGO_START to $DAYS_AGO_END days ago..."

# Loop through the range of days
for (( d=$DAYS_AGO_START; d>=$DAYS_AGO_END; d-- )); do
    # Calculate the targeted past date
    # Format: YYYY-MM-DD HH:MM:SS
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS syntax
        COMMIT_DATE=$(date -v -"${d}"d +"%Y-%m-%d 14:00:00")
    else
        # Linux / Windows Git Bash syntax
        COMMIT_DATE=$(date -d "${d} days ago" +"%Y-%m-%d 14:00:00")
    fi
    
    echo "Processing Date: $COMMIT_DATE"
    
    # Loop for multiple commits in a single day
    for (( c=1; c<=$COMMITS_PER_DAY; c++ )); do
        # 1. Make a small change to a file
        echo "Contribution on $COMMIT_DATE - Commit #$c" >> "$FILE_TO_UPDATE"
        
        # 2. Stage the modified file
        git add "$FILE_TO_UPDATE"
        
        # 3. Commit using overridden date variables
        GIT_AUTHOR_DATE="$COMMIT_DATE" GIT_COMMITTER_DATE="$COMMIT_DATE" \
        git commit -m "docs: historical update for $COMMIT_DATE (commit $c)" --quiet
    done
done

echo "Success! Commits generated locally."
echo "Run 'git push origin main --force' to update GitHub."


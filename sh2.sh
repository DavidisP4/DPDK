#!/usr/bin/env bash

NUM_PRS=500
declare -a PR_NUMBERS  # Array to store pull request numbers

echo "Now merging all created PRs..."
for PR_NUMBER in $(seq 1 $NUM_PRS); do
  echo "Merging PR #$PR_NUMBER..."
  
  # Attempt to merge using a merge commit (remove --auto if branch protections block it)
  gh pr merge "$PR_NUMBER" --merge
  
  if [ $? -eq 0 ]; then
    echo "PR #$PR_NUMBER merged successfully."
  else
    echo "Failed to merge PR #$PR_NUMBER."
  fi
  
  sleep 2
done
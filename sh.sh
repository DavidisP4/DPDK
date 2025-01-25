#!/usr/bin/env bash

#-------------------------
# 0) PRE-FLIGHT CHECKS
#-------------------------

# If there are any uncommitted changes, commit them so we don't get "no commits" errors
UNCOMMITTED_CHANGES=$(git status --porcelain)
if [ -n "$UNCOMMITTED_CHANGES" ]; then
  echo "Found uncommitted changes. Committing them first..."
  git add .
  git commit -m "chore: commit local uncommitted changes before script"
  git push
fi

# Make sure we're on the base branch (e.g., 'main') and it's up to date
BASE_BRANCH="main"
git checkout "$BASE_BRANCH"
git pull origin "$BASE_BRANCH"

#-------------------------
# 1) CREATE BRANCHES + PRS
#-------------------------

NUM_PRS=100
declare -a PR_NUMBERS  # Array to store pull request numbers

echo "-------------------------"
echo "Now merging all created PRs..."
for PR_NUMBER in $(seq 150 $NUM_PRS); do
  echo "Merging PR #$PR_NUMBER..."
  
  # Attempt to merge using a merge commit (remove --auto if branch protections block it)
  gh pr merge "$PR_NUMBER" --merge --auto
  
  if [ $? -eq 0 ]; then
    echo "PR #$PR_NUMBER merged successfully."
  else
    echo "Failed to merge PR #$PR_NUMBER."
  fi
  
  sleep 2
done

echo "-------------------------"
echo "All done! Created and (attempted to) merged $NUM_PRS pull requests."
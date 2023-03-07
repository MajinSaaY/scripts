#!/bin/zsh
#
# This script is used to reset any branch, deleting all commit history but keeping files.
#
# HOW TO USE
#
# Navigate to git folder:
# -› cd ~/storage/shared/Documents/Git
# Execute the command:
# -› bash <(curl https://raw.githubusercontent.com/MajinSaaY/scripts/main/git-reset-branch.sh)

git checkout --orphan latest_branch
git add -A
echo "Enter branch name"
echo "Press ENTER for default name (main)"
read BRANCH
if [ $BRANCH ]; then
    sleep 0s
else
    BRANCH="main"
fi
echo "Enter commit message"
read commit
git commit -am "$commit"
git branch -D $BRANCH
git branch -m $BRANCH
git push -f origin $BRANCH
echo "done"

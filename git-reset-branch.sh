#!/bin/zsh

# Reset any branch, deleting all commit history but keeping files.

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

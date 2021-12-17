#!/bin/sh
cd /home/zyh/Blognotes/
source /home/zyh/.rvm/scripts/rvm
git fetch

BRANCH=master

LOCAL=$(git log $BRANCH -n 1 --pretty=format:"%H")
REMOTE=$(git log remotes/origin/$BRANCH -n 1 --pretty=format:"%H")

if [ $LOCAL = $REMOTE ]; then
    echo "Up-to-date"
else
    echo "Need update"
    git pull
    jekyll build --source . --destination /home/zyh/_site/
fi

# enable on cron:
# */1 * * * * bash /home/zyh/Blognotes/pull_build.sh > /home/zyh/pull_build.log

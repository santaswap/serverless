#!/bin/bash
set -e

echo Getting author info from commit $TRAVIS_COMMIT
AUTHOR_NAME=$(git log -1 $TRAVIS_COMMIT --pretty="%aN")
FIRST_NAME=${AUTHOR_NAME%% *}
echo Commit author is $AUTHOR_NAME, first name is $FIRST_NAME

if [ $TRAVIS_PULL_REQUEST != "false" ]; then
    echo Not deploying serverless code on pull requests

else
    echo Deploying serverless project with code from branch: $TRAVIS_BRANCH
    [[ $TRAVIS_BRANCH = "master" ]] && STAGE="Prod" || STAGE=$FIRST_NAME
    echo serverless deploy --stage $STAGE
    serverless deploy --stage $STAGE

fi
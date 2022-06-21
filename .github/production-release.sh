#!/bin/bash
# Before using this script, make sure you understand the consequences. Read the "How to release" document!
# jq is a prerequisite, read here how to install: https://webinstall.dev/jq

echo "Before using this script, make sure you're familiar with release procedure (see .github/How-to-release.md)"
echo

VERSION_TO_RELEASE=$( jq -r  '.version' < ./package.json )
[ -z "$VERSION_TO_RELEASE" ] && echo "Could not determine version from package.json" && exit 1
echo You are about to release version $VERSION_TO_RELEASE to production
echo

if GIT_DIR=.git git tag --list | egrep -q "^v$VERSION_TO_RELEASE$"
then
    echo "Tag v$VERSION_TO_RELEASE already exists, cancelling."
    exit 1;
fi

read -p "Are you sure you want to continue? <y/N> " prompt
if [[ $prompt == "y" || $prompt == "Y" || $prompt == "yes" || $prompt == "Yes" ]]
then
  echo
  echo "Adding tag: v$VERSION_TO_RELEASE"
  git tag -a "v$VERSION_TO_RELEASE" -m "Release v$VERSION_TO_RELEASE"

  echo
  echo "Removing existing latest tag from GitHub"
  git push origin :refs/tags/latest

  echo
  echo "Adding latest tag"
  git tag -fa latest -m "Release v$VERSION_TO_RELEASE"

  echo
  echo "Pushing tags to GitHub to trigger deployment to Production"
  git push origin master --tags

  echo
  echo "Done! Monitor deployment in GitHub Actions workflow run, validate application was successfully deployed."
else
  echo "Release cancelled."
  exit 1
fi

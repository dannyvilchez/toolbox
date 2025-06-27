#!/bin/bash

PROJECT_NAME=$(basename "$PWD")

if [ -z "$GITHUB_USER" ]; then
    echo "Environment variable, GITHUB_USER, does not exist"
    exit 1
fi

echo "Initializing git repo for project: $PROJECT_NAME"
echo "github user: $GITHUB_USER"

if [ ! -f "README.md" ]; then
    echo "# $PROJECT_NAME" >README.md
fi

git init
git add .
git commit -m "Initializing project"
git branch -M main

git remote add origin https://github.com/$GITHUB_USER/$PROJECT_NAME.git
git push -u origin main

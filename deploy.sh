#!usr/bin/env sh

# abort on errors

npm run build

cd dist

git init
git add -A
git commit -m "deploy"

git push -f https://github.com/pinnouse/home.git master:gh-pages

cd -
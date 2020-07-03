#!/bin/bash

FILTER_REPO=/tmp/git-filter-repo/git-filter-repo
REPOS="core xml geometry pbf utils tbo extra testing incubating osc edit"
WORK="work"

function clone {
  REPO="$1"
  git clone "git@github.com:topobyte/osm4j-$REPO.git" "$REPO"
  cd "$REPO"
  $FILTER_REPO --to-subdirectory-filter "$REPO"
}

mkdir -p "$WORK"
cd "$WORK"

git clone "git@github.com:topobyte/osm4j-merge.git"

for REPO in $REPOS; do
  pushd .
  echo "$REPO"
  clone "$REPO"
  popd
done

cd osm4j-merge

for REPO in $REPOS; do
  git remote add "$REPO" "../$REPO"
  git fetch "$REPO"
done

for REPO in $REPOS; do
  git merge --allow-unrelated-histories --no-edit "$REPO/master"
done

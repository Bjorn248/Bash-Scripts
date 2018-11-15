#!/bin/bash

# Since I run my controller on a pine64, I can't use the repos to install unifi
# because arm64 is not officially supported
# This is just a quick and dirty way to download the latest unifi deb

set -e

if [ -d ~/unifi ]; then
  cd ~/unifi
else
  mkdir ~/unifi
  cd ~/unifi
fi

etag=$(curl -s -I https://dl.ubnt.com/unifi/debian/dists/stable/ubiquiti/binary-armhf/Packages.gz | grep ETag | awk '{print $2}' | cut -d'"' -f2)

if [ -f etag ]; then
  local_etag=$(cat etag)
else
  local_etag=""
fi

if [ "$etag" = "$local_etag" ]; then
  echo "Latest Unifi Controller Already downloaded, exiting..."
  exit 0
else
  echo "Downloading latest Unifi Controller..."
  rm -f Packages.gz
  wget https://dl.ubnt.com/unifi/debian/dists/stable/ubiquiti/binary-armhf/Packages.gz
  echo "$etag" > etag

  deb_path=$(zcat Packages.gz | grep Filename: | awk '{print $2}')

  rm -f unifi*

  wget "https://dl.ubnt.com/unifi/debian/$deb_path"
fi

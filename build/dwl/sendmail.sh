#!/bin/bash
if [ "`dpkg --get-selections | awk '{print $1}' | grep sendmail$ | wc -l`" == "1" ]; then
  service sendmail start;
  echo ">> Sendmail initialized";
fi

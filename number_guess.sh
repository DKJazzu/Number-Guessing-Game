#!/bin/bash

echo "Enter your username:"
read USERNAME

SECRET_NUMBER=$(( RANDOM % 1000 + 1 ))
TRIES=0

echo "Guess the secret number between 1 and 1000:"

while true
do
  read GUESS
# non-integer check
  if [[ ! "$GUESS" =~ ^[0-9]+$ ]]
  then
    echo "That is not an integer, guess again:"
    continue
  fi
  (( TRIES++ ))
done

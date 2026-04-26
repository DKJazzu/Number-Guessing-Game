#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

echo "Enter your username:"
read USERNAME

USER_DATA=$($PSQL "SELECT games_played, best_game FROM users WHERE username='$USERNAME'")

if [[ -z "$USER_DATA" ]]
then
# new user logic
  echo "Welcome, $USERNAME! It looks like this is your first time here."
  INSERT_USER=$($PSQL "INSERT INTO users(username) VALUES('$USERNAME')")
else
# existing user logic
  IFS="|" read GAMES_PLAYED BEST_GAME <<< "$USER_DATA"
  echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
fi

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

 if [[ "$GUESS" -eq "$SECRET_NUMBER" ]]
  then
    echo "You guessed it in $TRIES tries. The secret number was $SECRET_NUMBER. Nice job!"
# increment games_played and update best_game 
    UPDATE_RESULT=$($PSQL "UPDATE users SET games_played = games_played + 1, best_game = CASE WHEN best_game IS NULL OR $TRIES < best_game THEN $TRIES ELSE best_game END WHERE username='$USERNAME'")
    break
  elif [[ "$GUESS" -gt "$SECRET_NUMBER" ]]
  then
    echo "It's lower than that, guess again:"
  else
    echo "It's higher than that, guess again:"
  fi
done

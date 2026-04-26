# Number Guessing Game

A Bash-scripted CLI game that challenges users to guess a randomly generated number between 1 and 1000. This project utilizes a **PostgreSQL** database to persist user history, including the total number of games played and the user's personal "best game" (the one with the fewest guesses).

## Features

* **Persistent User Profiles:** Records usernames and game statistics.
* **Dynamic Greeting:** Differentiates between new users and returning players with unique welcome messages.
* **Input Validation:** Robust error handling to ensure only integers are accepted as guesses.
* **Atomic Database Updates:** Uses SQL `CASE` and arithmetic logic to update records efficiently upon winning.

## Technical Stack

* **Scripting:** Bash (Bourne Again SHell)
* **Database:** PostgreSQL
* **Version Control:** Git 

## Database Schema

The database `number_guess` consists of a single `users` table designed for high-precision tracking:

| Column | Type | Description |
| --- | --- | --- |
| `user_id` | `SERIAL` | Primary Key. |
| `username` | `VARCHAR(22)` | Unique username (Max 22 chars). |
| `games_played` | `INT` | Total games completed. |
| `best_game` | `INT` | Minimum number of guesses to win. |

## Installation & Setup

### 1. Rebuild the Database
If you have the `number_guess.sql` dump file, you can rebuild the database with:
```bash
psql -U postgres < number_guess.sql

```

### 2. Set Permissions
Ensure the script is executable:
```bash
chmod +x number_guess.sh

```

### 3. Run the Game
```bash
./number_guess.sh

```

---

## License

This project is licensed under the MIT License - see the LICENSE file for details.

#!/bin/bash

cd ../..
cd mnt/c/Users/amirb/Desktop/Stream

# The file you want to modify
FILE="League"

# Function to read the values from the file
read_values() {
  read -r RANK WL < $FILE
  TotalWins=${WL%-*}
  TotalLosses=${WL#*-}
  echo "Before update: Rank=$RANK, Wins=$TotalWins, Losses=$TotalLosses"
}

# Read the values from the file
read_values

# Check the input argument
if [ "$1" == "W" ]; then
  TotalWins=$((TotalWins+1))
elif [ "$1" == "L" ]; then
  TotalLosses=$((TotalLosses+1))
elif [ "$1" == "R" ]; then
  TotalWins=0
  TotalLosses=0
else
  echo "Invalid argument. Please provide either 'W', 'L' or 'R'."
  exit 1
fi

# Check if a second argument is provided for rank update
if [ -n "$2" ]; then
  RANK=$2
  echo "Rank updated to $RANK"
fi

TotalGames=$((TotalWins + TotalLosses))
echo $TotalGames

# Calculate win rate
if [ $TotalGames -eq 0 ]; then
	WR=0
elif [ $TotalLosses -eq 0 ] && [ $TotalWins -ne 0 ]; then
	WR=100
else
	WR=$((100*TotalWins/TotalGames))
fi

echo "After update: Rank=$RANK, Wins=$TotalWins, Losses=$TotalLosses, Win Rate=$WR"

# Write the updated values and win rate back to the file
echo "$RANK $TotalWins-$TotalLosses" > $FILE
echo "WR: $WR%" >> $FILE


#!/bin/bash -x

echo "Welcome to Tic Tac Toe Game"

declare -A board
total_cell=9
function resetboard()
{
   for (( i=1; i<=$total_cell; i++ ))
   do
      board[$i]=""
   done
}

function display_board()
{
   echo "| ${board[1]} | ${board[2]} | ${board[3]} |"
   echo "| ${board[4]} | ${board[5]} | ${board[6]} |"
   echo "| ${board[7]} | ${board[8]} | ${board[9]} |"
}

function toss()
{
	if (( $((RANDOM%2))==1 ))
	then
		playerSymbol="X"
	else
		playerSymbol="O"
	fi
	echo symbol is $playerSymbol
}

function checkEmpty()
{
	read -p "Enter cell Number: " cellnumber
	if [ "${board[$cellnumber]}" == " " ]
	then
		echo "Cell is empty"
		board[$cellnumber]=$playerSymbol
	else
		echo "cell is not empty"
	fi
}



#!/bin/bash -x

echo "Welcome to Tic Tac Toe Game"

declare -a board

total_cell=9
count=0
playerSymbol="O"

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
	if [[ "${board[cellnumber]} -ne $cellnumber" ]]
	then
		echo "Cell is not empty"
	else
		echo "cell is empty"
		board[cellnumber]=$playerSymbol
	((count++))
	fi
	display_board
}

function checkToWin()
{
	for(( i=1; i<=3; i++ ))
	do
		j=0
		if [[ ( ${board[i]} == {${board[i+j+1]} && ${board[i+j+1]} == ${board[i+j+2]} ||
				  ${board[i]} == {${board[i+3]} && ${board[i+3]} == ${board[i+6]} ||
				  ${board[1]} == {${board[5]} && ${board[5]} == ${board[9]} ||
				  ${board[3]} == {${board[5]} && ${board[5]} == ${board[7]} ) ]]
		then
			echo "player won"
			exit
		fi
		j=$((j+2))
	done
}
resetboard
display_board
toss

while (( count<9 ))
do
		checkEmpty
		checkToWin
done

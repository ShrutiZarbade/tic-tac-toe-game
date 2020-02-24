#!/bin/bash -x

echo "Welcome to Tic-Tac-Toe Game"

declare -a board

TOTAL_CELL=9

cell=0
flag=0

function resetBoard()
{
	for((i=1;i<=9;i++))
	do
   	board[i]=$i
	done
}

function displayBoard()
{
	echo "| ${board[1]} | ${board[2]} | ${board[3]} |"
	echo "| ${board[4]} | ${board[5]} | ${board[6]} |"
	echo "| ${board[7]} | ${board[8]} | ${board[9]} |"
}

function whoPlayFirst()
{
	if (( $((RANDOM%2))==1 ))
	then
		player="User"
		userLetter="X"
		computerLetter="O"
		userTurn
	else
		player="Computer"
		userLetter="O"
		computerLetter="X"
		computerTurn
	fi
}

function switchTurn()
{
	while (( cell<TOTAL_CELL ))
	do
		if [ $player == "User" ]
		then
			player="Computer"
			computerTurn
		else
			player="User"
			userTurn
		fi
	done
	if (( cell == TOTAL_CELL ))
	then
		echo "Game Tie"
	exit
	fi
}

function userTurn()
{
	echo "$player"
	read -p "Enter Cell Number: " cellNumber
	checkEmptyCell $cellNumber
	if (( flag==1 ))
	then
		userTurn
	fi
}

function computerTurn()
{
	echo "$player"
	checkSelfWin $computerLetter
	checkSelfWin $userLetter
	checkForCorner
	cellNumber=$((RANDOM%9+1))
	echo "random position entered by computer is : $cellNumber"
	checkEmptyCell $cellNumber
	if (( flag==1 ))
	then
		computerTurn
	fi
}

function checkForCorner()
{
	for((i=1;i<=9;i=i+2))
	do
		if (( i!=5 ))
		then
			checkEmptyCell $i
		fi
	done
}

function checkForCentre()
{
	checkEmptycell $((TOTAL_CELL/2 + 1))
}

function checkForSides()
{
	for(( i=2;i<=8;i=i+2))
	do
		checkEmptyCell $i
	done
}

function checkSelfWin()
{
	j=0
	for((i=1;i<=3;i++))
	do
		if [[ ${board[i+j]} == $1 && ${board[i+j+1]} == $1 ]]
		then
			checkEmptyCell $((i+j+2))
		elif [[ ${board[i+j]} == $1 && ${board[i+j+2]} == $1 ]]
		then
			checkEmptyCell $((i+j+1))
		elif [[ ${board[i+j+1]} == $1 && ${board[i+j+2]} == $1 ]]
		then
			checkEmptyCell $((i+j))
		fi
		if [[ ${board[i]} == $1 && ${board[i+3]} == $1 ]]
		then
			checkEmptyCell $((i+6))
		elif [[ ${board[i]} == $1 && ${board[i+6]} == $1 ]]
		then
			checkEmptyCell $((i+3))
		elif [[ ${board[i+3]} == $1 && ${board[i+6]} == $1 ]]
		then
			checkEmptyCell $i
		fi
		j=$((j+2))
	done
	checkSelfWinDiagonal $1
}

function checkSelfWinDiagonal()
{
	if [[ ${board[1]} == $1 && ${board[5]} == $1 ]]
	then
		checkEmptyCell 9
	elif [[ ${board[3]} == $1 && ${board[5]} == $1 ]]
	then
		checkEmptyCell 7
	elif [[ ${board[1]} == $1 && ${board[9]} == $1 ]]
	then
		checkEmptyCell 5
	fi
	if [[ ${board[3]} == $1 && ${board[7]} == $1 ]]
	then
		checkEmptyCell 5
	elif [[ ${board[5]} == $1 && ${board[9]} == $1 ]]
	then
		checkEmptyCell 1
	elif [[ ${board[7]} == $1 && ${board[5]} == $1 ]]
	then
		checkEmptyCell 3
	fi
}

function checkEmptyCell()
{
	cellNumber=$1
	if [[ ${board[cellNumber]} -ne $cellNumber ]]
	then
		flag=1
	else
		flag=0
		if [ $player == "User" ]
		then
			board[cellNumber]=$userLetter
		else
			board[cellNumber]=$computerLetter
		fi
		displayBoard
		((cell++))
		checkForWin
		switchTurn
	fi
}

function checkForWin()
{
	j=0
	for((i=1;i<=3;i++))
	do
		if [[ ( ${board[i+j]} == ${board[i+j+1]} && ${board[i+j+1]} == ${board[i+j+2]} ) ||
			( ${board[i]} == ${board[i+3]} && ${board[i+3]} == ${board[i+6]} ) ||
			( ${board[1]} == ${board[5]} && ${board[5]} == ${board[9]} ) ||
			( ${board[3]} == ${board[5]} && ${board[5]} == ${board[7]} ) ]]
		then
			echo "$player Won"
		exit
		fi
		j=$((j+2))
	done
}

resetBoard
displayBoard
whoPlayFirst

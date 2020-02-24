echo "Welcome to Tic-Tac-Toe Game"

declare -a boar
total_cell=9

cell=0
letter="O"
flag=0

function resetBoard()
{
	for((i=1;i<=$total_cell;i++))
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
		assignLetter
		userTurn
	else
		player="Computer"
		assignLetter
		computerTurn
	fi
}

function assignLetter()
{
	if [ $letter == "X" ]
	then
		letter="O"
	else
		letter="X"
	fi
}

function switchTurn()
{
	assignLetter
	if [ $player == "User" ]
	then
		player="Computer"
		computerTurn
	else
		player="User"
		userTurn
	fi
}

function userTurn()
{
	echo "$player Turn"
	read -p "Enter Cell Number: " cellNumber
	checkEmptyCell
	if (( flag==1 ))
	then
		userTurn
	fi
}

function computerTurn()
{
	echo "$player Turn"
	cellNumber=$((RANDOM%9 + 1))
	echo "random number of Computer:$cellNumber"
	checkEmptyCell
	if (( flag==1 ))
	then
		computerTurn
	fi
}

function checkEmptyCell()
{
	if [[ ${board[cellNumber]} -ne $cellNumber ]]
	then
		echo "Cell is not Empty."
		flag=1
	else
		flag=0
		board[cellNumber]=$letter
		displayBoard
	((cell++))
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

while (( cell<total_cell ))
do
	checkForWin
	switchTurn
done

if (( cell == total_cell ))
then
	echo "Game Tie"
fi

var moves = 0;
var table; 
var rows; 
var columns;
var textMoves;
var arrayForBoard;

function start()
{
  var button = document.getElementById("newGame");
  button.addEventListener( "click", startNewGame, secondPassed(), false );
  textMoves = document.getElementById("moves");
  table = document.getElementById("table");
  rows = 4;
  columns = 4;
  startNewGame();
}

function startNewGame()
{
  var arrayOfNumbers = new Array();
  var arrayHasNumberBeenUsed;
  var randomNumber = 0;
  var count = 0;
  moves = 0;
  rows = 4;
  columns = 4;
  textMoves.innerHTML = moves;
  //  Създаваме размер на дъската.
  arrayForBoard = new Array(rows);
  for (var i = 0; i < rows; i++)
  {
    arrayForBoard[i] = new Array(columns);
  }
  // Масив който ще ни помогне да гарантираме уникалност на случайните числа
  
  arrayHasNumberBeenUsed = new Array( rows * columns );
  for (var i = 0; i < rows * columns; i++)
  {
    arrayHasNumberBeenUsed[i] = 0;
  }
 
  //  Назначава случайни числа ва дъската.
  for (var i = 0; i < rows * columns; i++)
  {
    randomNumber = Math.floor(Math.random()*rows * columns);
    // Ако числото не се повтаря се добавя върху дъската.
    if (arrayHasNumberBeenUsed[randomNumber] == 0) 
    {
      arrayHasNumberBeenUsed[randomNumber] = 1;
      arrayOfNumbers.push(randomNumber);  //Записваме уникално генерираните случайни числа.
    }
    else //  Ако се повтаря се трасира отново.
    {
      i--;
    }
  }
  
  //  Числата се нанасят на дъската.
  count = 0;
  for (var i = 0; i < rows; i++)
  {
    for (var j = 0; j < columns; j++)
    {
      arrayForBoard[i][j] = arrayOfNumbers[count];
      
      count++;
    }
  }
  showTable();
}

function showTable()
{
    //  Визуализация на дъската.
  var outputString = "";
  for (var i = 0; i < rows; i++)
  {
    outputString += "<tr>";
    for (var j = 0; j < columns; j++)
    {
      if (arrayForBoard[i][j] == 0)
      {
	outputString += "<td class=\"blank\"> </td>";
      }
      else
      {
	outputString += "<td class=\"tile\" onclick=\"moveThisTile(" + i + ", " + j + ")\">" + arrayForBoard[i][j] + "</td>";
      }
    } 
    outputString += "</tr>";
  } 
  
  table.innerHTML = outputString;
}

function moveThisTile( tableRow, tableColumn) 
{
  //  Проверка за движението.
  if (checkIfMoveable(tableRow, tableColumn, "up") ||
      checkIfMoveable(tableRow, tableColumn, "down") ||
      checkIfMoveable(tableRow, tableColumn, "left") ||
      checkIfMoveable(tableRow, tableColumn, "right") )
  {
    incrementMoves();
  }
 
  if (checkIfWinner()){
    //  Проверка за победа.
    var r=confirm("Поздравления! Ти реши пъзела за " + moves + " стъпки.");
    if (r==true) {
      startNewGame();
      location.reload();
      }
    else {
      return 0;
     }
  }
}

function checkIfMoveable(rowCoordinate, columnCoordinate, direction)
{
 
   //Правим функцията да работи за всички посоки.
   
  rowOffset = 0;
  columnOffset = 0;
  if (direction == "up")
  {
    rowOffset = -1;
  }
  else if (direction == "down")
  {
    rowOffset = 1;
  }
  else if (direction == "left")
  {
    columnOffset = -1;
  }
  else if (direction == "right")
  {
    columnOffset = 1;
  }  
  
  // Проверка дали квадратчето с числото може да бъде преместено.
  //  Ако може, премести го и върни true.
  if (rowCoordinate + rowOffset >= 0 && columnCoordinate + columnOffset >= 0 &&
    rowCoordinate + rowOffset < rows && columnCoordinate + columnOffset < columns
  )
  {
    if ( arrayForBoard[rowCoordinate + rowOffset][columnCoordinate + columnOffset] == 0)
    {
      arrayForBoard[rowCoordinate + rowOffset][columnCoordinate + columnOffset] = arrayForBoard[rowCoordinate][columnCoordinate];
      arrayForBoard[rowCoordinate][columnCoordinate] = 0;
      showTable();
      return true;
    }
  }
  return false; 
}

function checkIfWinner()
{
  var count = 1;
  for (var i = 0; i < rows; i++)
  {
    for (var j = 0; j < columns; j++)
    {
      if (arrayForBoard[i][j] != count)
      {
	if ( !(count === rows * columns && arrayForBoard[i][j] === 0 ))
	{
	  return false;
	}
    }
      count++;
    }
  }
  
  return true;
}

function incrementMoves()
{
  moves++;
  if (textMoves) 
  {
    textMoves.innerHTML = moves;
  }
}

window.addEventListener( "load", start, false ); //Този event listener прави  function start() да се изпълни при отваряне на страницата. 


var countdown;
var time;

var seconds = 1200;
function secondPassed() {
   // Създаване на таймер за играта. 
    var minutes = Math.round((seconds - 30)/60),
        remainingSeconds = seconds % 60;

    if (remainingSeconds < 10) {
        remainingSeconds = "0" + remainingSeconds;
    }

    document.getElementById('countdown').innerHTML = minutes + ":" + remainingSeconds;

    if (seconds < 0) {
        alert("Времето изтече! Желаете ли да започнете нова игра?");
        location.reload();
        clearInterval(countdownTimer);
      document.form1.submit();
    } else {
        seconds--;
    }
}
var countdownTimer = setInterval('secondPassed()', 1000);

function restartGame(){
  // Рестартиране на играта при натискане на бутона. 
  var r=confirm("Наистина ли желаете да започнете нова игра?");
  if (r==true) {
    location.reload();
    }
  else {
    return 0;
   } 
}
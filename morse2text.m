% (c) 2023-03-06 Pete Laric / www.PeteLaric.com
function text = morse2text (morse)

text = '?';
switch morse
  case '.-'           % letters
    text = 'A';
  case '-...'
    text = 'B';
   case '-.-.'
    text = 'C';
  case '-..'
    text = 'D';
  case '.'
    text = 'E';
   case '..-.'
    text = 'F';
  case '--.'
    text = 'G';
  case '....'
    text = 'H';
  case '..'
    text = 'I';
  case '.---'
    text = 'J';
  case '-.-'
    text = 'K';
  case '.-..'
    text = 'L';
  case '--'
    text = 'M';
  case '-.'
    text = 'N';
  case '---'
    text = 'O';
  case '.--.'
    text = 'P';
  case '--.-'
    text = 'Q';
  case '.-.'
    text = 'R';
  case '...'
    text = 'S';
  case '-'
    text = 'T';
  case '..-'
    text = 'U';
  case '...-'
    text = 'V';
  case '.--'
    text = 'W';
  case '-..-'
    text = 'X';
  case '-.--'
    text = 'Y';
  case '--..'
    text = 'Z';
  case '.----'            % numbers
    text = '1';
  case '..---'
    text = '2';
  case '...--'
    text = '3';
  case '....-'
    text = '4';
  case '.....'
    text = '5';
  case '-....'
    text = '6';
  case '--...'
    text = '7';
  case '---..'
    text = '8';
  case '----.'
    text = '9';
  case '-----'
    text = '0';
  case '.-.-.-'         % punctuation
    text = '.';
  case '--..--'
    text = ',';
  case '..--..'
    text = '?';
  case '-.-.--'
    text = '!';
  otherwise
    text = '?';
end

end

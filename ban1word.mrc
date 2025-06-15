; This script bans users who send multiple lines with only one word. 

; Set the maximum allowed messages with only one word before banning

on *:text:*:#:{
  if ($network == Zemra) {
    ; Check if the message contains only one word or one character
    if (($numwords($1-) == 1) && ($len($1) <= 1)) {
      ; Increase the counter for lines with only one character or one word
      inc %checklines($nick)

      ; If the user sends more than 2 lines with only one word or one character, ban them
      if (%checklines($nick) >= 3) {
        /mode # +b $address($nick, 2)
        /ban # $address($nick, 2)
        /kick # $nick You have been banned for sending multiple lines with only one word or character.
        echo -a Ban $nick for sending multiple lines with only one word or character in #AlbaChat.
      }
    }
    else {
      ; Reset the counter if the message has more than one word or character
      set %checklines($nick) 0
    }
  }
}

; This script bans users who send multiple lines with only one word.

; Set the maximum allowed messages with only one word before banning
var %maxSingleWordMessages = 3

; Initialize a hash table to track users' messages
on *:start:{
  if (!$hget(singleword)) {
    hmake singleword 100
  }
}

on *:text:*:#:{
  ; Check if the message has only one word
  if ($numtok($1-, 32) == 1) {
    ; Increment the count of single word messages for the user
    var %messages = $hget(singleword, $nick)
    if (%messages) {
      hinc singleword $nick 1
    } else {
      hadd singleword $nick 1
    }
    
    ; If the user has sent more than the allowed number of single word messages, ban them
    if ($hget(singleword, $nick) >= %maxSingleWordMessages) {
      ban -u5 # $nick
      notice $nick You have been banned for sending multiple lines with only one word.
      hdel singleword $nick  ; Reset the user's count
    }
  }
}

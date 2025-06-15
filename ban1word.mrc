; This script kicks users who send multiple single-word or single-character messages.

; Set the maximum allowed single-word or single-character messages before kicking
var %maxSingleMessages = 3

; Initialize a hash table to track the number of single-word or single-character messages per user
on *:start:{
  if (!$hget(singleword)) {
    hmake singleword 100
  }
}

on *:text:*:#:{
  ; Check if the message contains only one word or a single character
  if ($numtok($1-, 32) == 1) && ($len($1) <= 1) {
    ; If it's a single character, consider it a spammy message
    ; Increment the count of single-word or single-character messages for the user
    var %messages = $hget(singleword, $nick)
    if (%messages) {
      hinc singleword $nick 1
    } else {
      hadd singleword $nick 1
    }
    
    ; If the user has sent more than the allowed number of single-word/single-character messages, kick them
    if ($hget(singleword, $nick) >= %maxSingleMessages) {
      kick # $nick You have been kicked for sending too many single-word or single-character messages.
      hdel singleword $nick  ; Reset the user's count
    }
  }
  ; Also check for single-word messages (not just characters)
  elseif ($numtok($1-, 32) == 1) {
    ; Increment the count for single-word messages
    var %messages = $hget(singleword, $nick)
    if (%messages) {
      hinc singleword $nick 1
    } else {
      hadd singleword $nick 1
    }

    ; If the user has sent more than the allowed number of single-word messages, kick them
    if ($hget(singleword, $nick) >= %maxSingleMessages) {
      kick # $nick You have been kicked for sending too many single-word messages.
      hdel singleword $nick  ; Reset the user's count
    }
  }
}

on *:PART:#:{
  ; Reset the user's count when they leave the channel
  hdel singleword $nick
}

on *:QUIT:{
  ; Reset the user's count when they quit mIRC
  hdel singleword $nick
}

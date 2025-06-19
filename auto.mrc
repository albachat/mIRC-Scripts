on *:CONNECT:{
  ; Replace with your real values
  if ($network == YourNetworkName) {
    ; Identify to NickServ
    .NickServ IDENTIFY your_nickserv_password

    ; Wait a few seconds then Oper
    .timeroper 1 2 oper your_oper_username your_oper_password
  }
}

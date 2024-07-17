curl --request GET --url http://172.28.124.51:8080/gopro/camera/control/wired_usb?p=1

pause


:loop

timeout 2
curl --request GET  --url http://172.28.124.51:8080/gopro/camera/keep_alive


goto loop

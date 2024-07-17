curl --request GET --url http://172.28.124.51:8080/gopro/camera/control/wired_usb?p=1
curl --request GET --url "http://172.28.124.51:8080/gopro/camera/stream/start?port=8556"
mpv udp://@172.28.124.51:8554
curl --request GET --url "http://172.28.124.51:8080/gopro/camera/stream/stop"
curl --request GET --url http://172.28.124.51:8080/gopro/camera/control/wired_usb?p=0


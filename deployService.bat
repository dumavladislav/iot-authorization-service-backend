
call mvn clean
call mvn install

REM Copy files to server
ssh dumavla@192.168.1.53 "rm -f -r iot-authorization-service-backend && mkdir iot-authorization-service-backend"
scp -r * dumavla@192.168.1.53:~/iot-authorization-service-backend


REM docker build
REM ssh -t dumavla@192.168.1.53 "sudo docker build -t dumskyhome/iot-authorization-service-backend:rev2 ~/iot-authorization-service-backend/."
REM ssh -t dumavla@192.168.1.53 "sudo docker run --name iot-authorization-service-backend-rev2  --restart unless-stopped -it -d dumskyhome/iot-authorization-service-backend:rev2

ssh -t dumavla@192.168.1.53 "sudo docker stop iot-authorization-service-backend-rev2 || true && sudo docker rm iot-authorization-service-backend-rev2 || true && sudo docker build -t dumskyhome/iot-authorization-service-backend:rev2 ~/iot-authorization-service-backend/. && sudo docker run --name iot-authorization-service-backend-rev2  --restart unless-stopped -it -d dumskyhome/iot-authorization-service-backend:rev2"
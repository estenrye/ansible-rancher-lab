echo;
echo "tcp_timestamps Status for Container Host:";
sysctl net.ipv4.tcp_timestamps;
echo;

which docker

if [ $? = 0 ]; then
  docker ps; 
  echo;
  echo "tcp_timestamps Status for guest containers:";
  docker ps -q | {
    while read id; do
      status=$(sudo docker exec $id sysctl net.ipv4.tcp_timestamps);
      echo "$id: $status";
    done;
  }
else
  echo "$host is not a docker container host."
fi
echo

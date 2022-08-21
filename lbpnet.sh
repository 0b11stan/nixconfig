IP=$(ip --color=never addr show enp1s0f0 | grep 'inet ' \
  | cut -d '/' -f 1 | rev | cut -d ' ' -f 1 | rev | cut -d '.' -f 1,2,3)

if [ "$1" == "up" ]; then

sudo ip route add default via $IP.1 dev enp1s0f0
sudo tee /etc/resolv.conf <<EOF
nameserver 194.5.88.5
nameserver 194.5.88.133
nameserver 220.2.211.168
EOF

elif [ "$1" == "down" ]; then

sudo ip route del default via $IP.1 dev enp1s0f0
echo 'nameserver 1.1.1.1' | sudo tee /etc/resolv.conf

fi

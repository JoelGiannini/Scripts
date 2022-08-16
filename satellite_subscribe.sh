################################################################
#           Desarrolado por Joel gienneni                      #
#                                                              #
#           Subscripcion  a satellitep03  (STANDARD)           #
#                                                              #
################################################################

declare -a ARRAY_IPS_SATELLITE
ARRAY_IPS_SATELLITE=(10.167.52.87 10.167.226.69 10.204.167.166 10.167.52.155 10.167.70.153 10.167.76.155 10.167.51.179 10.167.64.76)
for i in at3omnt101 at3omnt102 at3omnt103 at3omnt104; 
do
echo "Server $i"
comando=`ping -c 3 $i 2> /dev/null`
nofunciona=$?
if [ $nofunciona -eq 0 ] ; then
v_date=`date`

for (( a=0; a < 8; a++ )); 
do 
ssh -q $i "ping -c 3 "${ARRAY_IPS_SATELLITE[a]}" 2> /dev/null";
RESULT=$?
if [ $RESULT -eq 0 ] ; then
IP_SATELLITE="${ARRAY_IPS_SATELLITE[a]}"
ssh -q $i "echo "$IP_SATELLITE apsatellitep03.tmoviles.com.ar apsatellitep03" >> /etc/hosts"
fi
done
KATELLO=`ssh -q $i "rpm -qa | grep  katello-ca-consumer"`
ssh -q $i "rpm -e $KATELLO"
ssh -q $i "curl --insecure --output katello-ca-consumer-latest.noarch.rpm https://apsatellitep03.tmoviles.com.ar/pub/katello-ca-consumer-latest.noarch.rpm"
ssh -q $i "yum localinstall -y katello-ca-consumer-latest.noarch.rpm"
AUX=`ssh -q $i "cat /etc/redhat-release"`
VERSION=`echo $AUX | awk '{print $7}'`
ssh -q $i "subscription-manager unregister ; subscription-manager clean ; subscription-manager register --org="MOVISTAR" --activationkey="STANDARD"  --release=$VERSION"
ssh -q $i "subscription-manager repos --enable rhel-7-server-satellite-tools-6.4-rpms ; yum install -y katello-agent"
fi
done

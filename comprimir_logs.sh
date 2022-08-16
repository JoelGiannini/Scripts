####################################################
#  Desarrollado por Joel Matias Giannini	   #	                   #
#               Comprimir logs.                    #
####################################################

for i in at3jbep101 at3jbep102 at3jbep103 at3jbep201 at3jbep202 at3jbep203 at3jfep103 at3jfep104 at3jfep203 at3jfep204 at3jocp101 at3jocp102 at3jocp201 at3jocp202; do
echo "Server $i"
comando=`ping -c 3 $i 2> /dev/null`
nofunciona=$?
if [ $nofunciona -eq 0 ] ; then

v_date=`date`


ssh -q ibmunx@$i "sudo gzip -9  /tefuser3/tef/oms/prdoms1/JEE/OMS/logs/OmsDomain/connector/Connector*.log" >> /tmp/evicencia.txt

else

Echo "$i el servidor no conecta" >> /tmp/NO_CONECTAN.txt
 
fi



done

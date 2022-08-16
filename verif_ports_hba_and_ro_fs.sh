############################################################
#   DESARROLLADO POR JOEL MATIAS GIANNINI                  #
#   VERIFICAR  PASOS Y FILESYSTEMS EN RO EN REDHAT         #
############################################################
for i in apt3extp01 apt3extp02 apt3sapp01 apt3sapp02 at3bcvp103 at3bcvp104 at3bilp101 at3digp101 at3digp102 clt3selp02 ct3racp101 ct3racp102 ct3racp103 ct3racp104 ct3racp105 ct3racp106 ct3racp107 ct3racp108 ct3racp109 ct3racp110 ct3racp111 ct3racp112 dt3ossp101 dt3skyp101 wst3app08; do
echo "Server $i"
comando=`ping -c 3 $i 2> /dev/null`
nofunciona=$?
if [ $nofunciona -eq 0 ] ; then

v_date=`ssh -q $i "date"`
v_wwpn=`ssh -q $i "sudo cat /sys/class/fc_host/host[0-9]*/port_name"`
v_port_state=`ssh -q $i "sudo cat /sys/class/fc_host/host[0-9]*/port_state"`
v_fs_ro=`ssh -q $i "sudo awk '$4~/(^|,)ro($|,)/' /proc/mounts "` 
if [ "$v_fs_ro" == "" ] ; then
v_fs_ro="No hay fs en Read-Only"
else
v_fs_ro="El equipo posee Filesystem en Read Only $v_fs_ro"
fi
v_lv=`ssh -q $i "sudo lvscan"`

fi

echo "$i" >> /tmp/Relevo.txt
echo "$v_date" >> /tmp/Relevo.txt
echo "WWPN:  $v_wwpn " >> /tmp/Relevo.txt
echo "Port_states: $v_port_state" >> /tmp/Relevo.txt
echo "Read-Only Filesystems:  $v_fs_ro " >> /tmp/Relevo.txt
echo " $v_lv" >> /tmp/Relevo.txt
done

#!/bin/bash
LISTA=/tmp/lista
LOG="/home/ibmunx/migra/migra.log"

sudo multipath -ll > /root/migra/multipath_completo.txt
sudo multipath -ll | grep "COMP" > /root/migra/luns_compellent.txt

cat $LISTA|awk '{print $1" "$2 " "$3}'|while read HDISKSOURCE HDISKDEST V_VG
do
DATE=`date`
echo "###### INICIO COPIA $DATE #################" >>$LOG
echo "Extender VG" >>$LOG
sudo vgextend $V_VG $HDISKDEST >>$LOG 2>&1
echo "MIGRANDO SOURCE=$HDISKSOURCE TARGET=$HDISKDEST" >>$LOG
echo "sudo pvmove $HDISKSOURCE $HDISKDEST" >>$LOG
time sudo pvmove $HDISKSOURCE $HDISKDEST >>$LOG 2>&1
sleep 5
echo "sudo vgreduce $V_VG $HDISKSOURCE" >>$LOG 
sudo vgreduce $V_VG $HDISKSOURCE >>$LOG  2>&1
echo "sudo pvremove $HDISKSOURCE" >>$LOG 
sudo pvremove $HDISKSOURCE >>$LOG 2>&1
echo "sudo blockdev --flushbufs $HDISKSOURCE" >>$LOG 
sudo blockdev --flushbufs $HDISKSOURCE >>$LOG 2>&1
echo "sudo multipath -f $HDISKSOURCE" >>$LOG 
sudo multipath -f $HDISKSOURCE >>$LOG 2>&1

done

#!/bin/bash
LISTA=/tmp/lista
LOG="/root/migra/migra.log"


cat $LISTA|awk '{print $1" "$2 " "$3}'|while read HDISKSOURCE HDISKDEST V_VG
do
DATE=`date`
echo "###### INICIO COPIA $DATE #################" >>$LOG
echo "Extendiendo VG" >>$LOG
extendvg $V_VG $HDISKDEST >>$LOG 2>&1
echo "MIGRANDO SOURCE=$HDISKSOURCE TARGET=$HDISKDEST" >>$LOG
echo "migratepv $HDISKSOURCE $HDISKDEST" >>$LOG
time migratepv $HDISKSOURCE $HDISKDEST >>$LOG 2>&1
sleep 5
echo "Reduciendo VG" >>$LOG
reducevg $V_VG $HDISKSOURCE >>$LOG 2>&1
echo "Eliminado PV" >>$LOG
rmdev -dl $HDISKSOURCE >>$LOG 2>&1
done





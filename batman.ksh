#######################################
#     Desarrollador: Joel Giannini    #
#     Amd de links, users and pass    #
#                                     #
#######################################
#Declaracion de variables
h=`date "+%H" `
m=`date "+%M" `
s=`date "+%S" `
dia=`date "+%d" `
mes=`date "+%m" `
anio=`date "+%Y" ` 
V_red='\e[0;31m'
V_orange='\e[1;31m'
V_white='\e[1;37m'
V_yellow='\e[1;33m'
V_blue='\e[0;34m'
V_cyan='\e[0;36m'
V_green='\e[0;32m'
NC='\e[0m' # No Color 

##############
#Funcion menu#
##############
menu(){
while :
do
clear
#ACA VA EL MENU#
echo -e "${V_blue}		░░░░░░░░░░░░░░░░░░░░░░░░░${NC}"
echo -e "${V_blue}		░░░░░░▄█░░░░░░░░░░░░██░░░${NC}"
echo -e "${V_blue}		░░░░░▄██░░░░░░░░░░░███░░░${NC}"
echo -e "${V_blue}		░░░░░███░░░░░░░░░░████░░░${NC}"
echo -e "${V_blue}		░░░░████░░▄▄▄▄░░░█████░░░${NC}"
echo -e "${V_blue}		░░░███████████████████░░░${NC}"
echo -e "${V_blue}		░░░███████████████████░░░${NC}"
echo -e "${V_blue}		░▄█████████████████████░░${NC}"
echo -e "${V_blue}		░██████████████████████░░${NC}"
echo -e "${V_blue}		░██████████████████████░░${NC}"
echo -e "${V_blue}		░█░▀████████▀░▄████████░░${NC}"
echo -e "${V_blue}		▄██▄▄█████▄▄▄██████████▄░${NC}"
echo -e "${V_blue}		██▀███████▀▀█▀▀░░███████░${NC}"
echo -e "${V_blue}		░█░░░▀▀▀░░░░▀▀░░░███████░${NC}"
echo -e "${V_blue}		░█░░░████▄░░░░░░░████████${NC}"
echo -e "${V_blue}		░█░░░░░░░░░░░░░░░████████${NC}"
echo -e "${V_blue}		░██░░░░░░░░░░░░░░████████${NC}"
echo -e "${V_blue}		░▀█░░░░░░░░░░░░▄█████████${NC}"
echo""
echo -e "${V_cyan}      		By Joel Giannini.  ${NC}"

echo ""
echo "--------------------------------------------------"
echo " * * * * * * * * * opciónes * * * * * * * * * * "
echo "--------------------------------------------------"
echo ""
echo -e "[${V_yellow}1${NC}] ADM de Links, usuarios y passwords"
echo -e "[${V_yellow}2${NC}] Salir"
echo ""
echo "--------------------------------------------------"
echo ""
echo -e "Elegi una opción [ ${V_yellow}1${NC}-${V_yellow}2${NC} ]:"
read yourch
while [ $yourch -lt 1 ] || [ $yourch -gt 2 ]
do
echo "opción erronea, ingresar numero de opción entre [1-2]:"
read yourch
done

case $yourch in
1) F_inventario ;;
2) echo -e "${V_cyan}Hasta la vista baby!!!${NC}" ; echo "" ; echo "" ; exit 0 ;;
esac
done
}

########################################
# Funcion Inventario                   #
########################################
F_inventario(){
clear

arch=`ls -a $HOME | grep '.Inventario'`
if [[ $arch == "" ]];
then
echo "Recurso Usuario Password Descripcion Link" > $HOME/.Inventario
fi

echo -e "${V_cyan}################################################################################${NC}"
echo -e "${V_cyan}# Inventario de usuarios, contraseñas y links                                  #${NC}"
echo -e "${V_cyan}################################################################################${NC}"
echo ""
echo -e "${V_yellow}1${NC}) Ver inventario completo"
echo -e "${V_yellow}2${NC}) Buscar recurso"
echo -e "${V_yellow}3${NC}) Actualizar recurso"
echo -e "${V_yellow}4${NC}) Dar de alta recurso"
echo -e "${V_yellow}5${NC}) Dar de baja recurso"
echo -e "${V_yellow}6${NC}) Exportar inventario"
echo -e "${V_yellow}7${NC}) Volver al menu principal."

read aux

while [ $aux -lt 1 ] || [ $aux -gt 7 ]
do
echo "Valor incorrecto ingrese la opción correcta:"
read aux
done

case $aux in
1) F_view_s ;;
2) F_buscar_s ;;
3) F_update_s ;;
4) F_add_s ;;
5) F_delete_s;;
6) F_export_s;; 
7) menu ;;
esac
}

########################################
# Funcion Buscar Servidor              #
########################################
F_buscar_s(){
clear

V_recurso="Recurso"
V_usuario="Usuario"
V_password="Password"
V_descripcion="Descripcion"
V_link="Link"
echo "Ingrese el recurso que desa buscar"
read V_rec

V_recu=`cat $HOME/.Inventario  | grep -wi $V_rec | awk '{print $1}'` 
V_user=`cat $HOME/.Inventario  | grep -wi $V_rec | awk '{print $2}'`
V_pass=`cat $HOME/.Inventario  | grep -wi $V_rec | awk '{print $3}'` 
V_desc=`cat $HOME/.Inventario  | grep -wi $V_rec | awk '{print $4}'`
V_lnk=`cat $HOME/.Inventario  | grep -wi $V_rec | awk '{print $5}'`


if [[ `cat $HOME/.Inventario  | grep -i ${V_rec} | awk '{print $1}'` == "" ]]
   			then
			
	touch $HOME/.tmp.txt
	echo "No se encontro la busqueda realizada en el inventario." | tee --append $HOME/.tmp.txt > /dev/null 2>&1
	clear
	echo -e "${V_cyan}############################################################################################################################${NC}"
	echo "` cat $HOME/.tmp.txt`"|column -t -s "|"
	echo -e "${V_cyan}############################################################################################################################${NC}"
	 rm -f $HOME/.tmp.txt > /dev/null 2>&1

	echo ""
	echo -e "${V_yellow}1${NC}) Volver al menu anterior."
	read aux

	while [ $aux -lt 1 ] || [ $aux -gt 1 ]
	do
	echo "Valor incorrecto ingrese la opción correcta:"
	read aux
	done

	while [[  $aux == "1" ]]
	do
	menu;
	done
else

	touch $HOME/.tmp.txt
	echo "$V_recurso  |$V_usuario  |$V_password  |$V_descripcion  |$V_link" |  tee --append $HOME/.tmp.txt > /dev/null 2>&1
	echo "$V_recu |$V_user  |$V_pass  |$V_desc |$V_lnk" |  tee --append $HOME/.tmp.txt > /dev/null 2>&1
	clear
	echo -e "${V_cyan}############################################################################################################################${NC}"
	echo "` cat $HOME/.tmp.txt`"|column -t -s "|"
	echo -e "${V_cyan}############################################################################################################################${NC}"
	 rm -f $HOME/.tmp.txt > /dev/null 2>&1

	echo ""
	echo -e "${V_yellow}1${NC}) Volver al menu anterior."
	read aux

	while [ $aux -lt 1 ] || [ $aux -gt 1 ]
	do
	echo "Valor incorrecto ingrese la opción correcta:"
	read aux
	done

	while [[  $aux == "1" ]]
	do
	menu;
	done
fi
}

########################################
# Funcion update inventario            #
########################################
F_update_s(){
clear

V_recurso="Recurso"
V_usuario="Usuario"
V_password="Password"
V_descripcion="Descripcion"
V_link="Link"
echo "Ingrese recurso:"
read V_rec

V_recu=`cat $HOME/.Inventario  | grep -wi $V_rec | awk '{print $1}'|tr -d "\015"` 
V_user=`cat $HOME/.Inventario  | grep -wi $V_rec | awk '{print $2}'|tr -d "\015"`
V_pass=`cat $HOME/.Inventario  | grep -wi $V_rec | awk '{print $3}'|tr -d "\015"` 
V_desc=`cat $HOME/.Inventario  | grep -wi $V_rec | awk '{print $4}'|tr -d "\015"`
V_lnk=`cat $HOME/.Inventario  | grep -wi $V_rec | awk '{print $5}'|tr -d "\015"`

clear

if [[ `cat $HOME/.Inventario  | grep -wi $V_rec | awk '{print $1}'` == "" ]]
   			then
			echo -e "El recurso ${V_red}$V_rec${NC} no se encuentra en el inventario."
			echo -e "¿Desea agregar el recurso ${V_red}$V_rec${NC} al inventario?"
			echo -e "${V_yellow}1${NC}) Si"
			echo -e "${V_yellow}2${NC}) No"
			read aux

		while [ $aux -lt 1 ] || [ $aux -gt 2 ] || [ $aux == ""]
		do
			echo "Valor incorrecto ingrese la opción correcta:"
			read aux
		done
				if [ $aux -eq 1 ] ; then
				F_add_s;	
				else
				menu
				fi
fi
	touch $HOME/.tmp.txt
	echo "$V_recurso  |$V_usuario  |$V_password  |$V_descripcion  |$V_link" |  tee --append $HOME/.tmp.txt > /dev/null 2>&1
	echo "$V_recu |$V_user  |$V_pass  |$V_desc |$V_lnk" |  tee --append $HOME/.tmp.txt > /dev/null 2>&1
	clear
	echo -e "${V_cyan}######################################################################################################################################${NC}"
	echo "` cat $HOME/.tmp.txt`"|column -t -s "|"
	echo -e "${V_cyan}######################################################################################################################################${NC}"
	 rm -f $HOME/.tmp.txt > /dev/null 2>&1
echo ""
echo -e "${V_cyan}¿Que campo desea modificar?${NC}"
echo -e "${V_yellow}1${NC}) Recurso."
echo -e "${V_yellow}2${NC}) Usuario."
echo -e "${V_yellow}3${NC}) Password."
echo -e "${V_yellow}4${NC}) Descripcion."
echo -e "${V_yellow}5${NC}) Link."
echo -e "${V_yellow}6${NC}) Volver al menu anterior."

read aux
while [ $aux -lt 1 ] || [ $aux -gt 6 ]
do
echo "valor incorrecto ingrese la opción correcta"
read aux
done


while [[  $aux == "1" ]]
do
clear
echo "Ingrese nuevo valor para el campo Recurso:"
read V_new
	if [ "$V_new" == "" ];
   	then
    V_new="========"
	fi
line=`cat $HOME/.Inventario  | grep -inw $V_rec| awk -F':' '{print $1}'|tr -d "\015"`
 sed -i "${line} s/${V_recu}/${V_new}/g" $HOME/.Inventario
V_rec=$V_new
clear
	 touch $HOME/.tmp.txt
	echo "$V_recurso  |$V_usuario  |$V_password  |$V_descripcion  |$V_link" |  tee --append $HOME/.tmp.txt > /dev/null 2>&1
	echo "$V_rec |$V_user  |$V_pass  |$V_desc |$V_lnk" |  tee --append $HOME/.tmp.txt > /dev/null 2>&1
	clear
	echo -e "${V_cyan}######################################################################################################################################${NC}"
	echo "` cat $HOME/.tmp.txt`"|column -t -s "|"
	echo -e "${V_cyan}######################################################################################################################################${NC}"	 
	rm -f $HOME/.tmp.txt > /dev/null 2>&1
echo ""

echo -e "${V_yellow}1${NC}) Volver al menu principal."
read aux

while [ $aux -lt 1 ] || [ $aux -gt 1 ]
do
echo "Valor incorrecto ingrese la opción correcta:"
read aux
done

while [[  $aux == "1" ]]
do
menu;
done
done

while [[  $aux == "2" ]]
do
clear
echo "Ingrese nuevo valor para el campo Usuario:"
read V_new
	if [ "$V_new" == "" ];
   	then
    V_new="########"
	fi
line=`cat $HOME/.Inventario  | grep -inw $V_rec| awk -F':' '{print $1}'|tr -d "\015"`
 sed -i "${line} s/${V_user}/${V_new}/g" $HOME/.Inventario
V_user=$V_new
clear
	 touch $HOME/.tmp.txt
	echo "$V_recurso  |$V_usuario  |$V_password  |$V_descripcion  |$V_link" |  tee --append $HOME/.tmp.txt > /dev/null 2>&1
	echo "$V_rec |$V_user  |$V_pass  |$V_desc |$V_lnk" |  tee --append $HOME/.tmp.txt > /dev/null 2>&1
	clear
	echo -e "${V_cyan}######################################################################################################################################${NC}"
	echo "` cat $HOME/.tmp.txt`"|column -t -s "|"
	echo -e "${V_cyan}######################################################################################################################################${NC}"
	rm -f $HOME/.tmp.txt > /dev/null 2>&1
echo ""

echo -e "${V_yellow}1${NC}) Volver al menu principal."
read aux

while [ $aux -lt 1 ] || [ $aux -gt 1 ]
do
echo "Valor incorrecto ingrese la opción correcta:"
read aux
done

while [[  $aux == "1" ]]
do
menu;
done
done

while [[  $aux == "3" ]]
do
clear
echo "Ingrese nuevo valor para el campo Password:"
read V_new
	if [ "$V_new" == "" ];
   	then
    V_new="xxxxxxxx"
	fi
line=`cat $HOME/.Inventario  | grep -inw $V_rec| awk -F':' '{print $1}'|tr -d "\015"`
 sed -i "${line} s/${V_pass}/${V_new}/g" $HOME/.Inventario
V_pass=$V_new
clear
	 touch $HOME/.tmp.txt
	echo "$V_recurso  |$V_usuario  |$V_password  |$V_descripcion  |$V_link" |  tee --append $HOME/.tmp.txt > /dev/null 2>&1
	echo "$V_rec |$V_user  |$V_pass  |$V_desc |$V_lnk" |  tee --append $HOME/.tmp.txt > /dev/null 2>&1
	clear
	echo -e "${V_cyan}################################################################################################################################################${NC}"
	echo "` cat $HOME/.tmp.txt`"|column -t -s "|"
	echo -e "${V_cyan}################################################################################################################################################${NC}"
	 rm -f $HOME/.tmp.txt > /dev/null 2>&1
echo ""

echo -e "${V_yellow}1${NC}) Volver al menu principal."
read aux

while [ $aux -lt 1 ] || [ $aux -gt 1 ]
do
echo "Valor incorrecto ingrese la opción correcta:"
read aux
done

while [[  $aux == "1" ]]
do
menu;
done
done

while [[  $aux == "4" ]]
do
clear
echo "Ingrese nuevo valor para el campo Descripcion:"
read V_new
	if [ "$V_new" == "" ];
   	then
    V_new="********"
  	fi
line=`cat $HOME/.Inventario  | grep -inw $V_rec| awk -F':' '{print $1}'|tr -d "\015"`
 sed -i "${line} s/${V_desc}/${V_new}/g" $HOME/.Inventario
V_desc=$V_new
clear
	 touch $HOME/.tmp.txt
	echo "$V_recurso  |$V_usuario  |$V_password  |$V_descripcion  |$V_link" |  tee --append $HOME/.tmp.txt > /dev/null 2>&1
	echo "$V_rec |$V_user  |$V_pass  |$V_desc |$V_lnk" |  tee --append $HOME/.tmp.txt > /dev/null 2>&1
	clear
	echo -e "${V_cyan}################################################################################################################################################${NC}"
	echo "` cat $HOME/.tmp.txt`"|column -t -s "|"
	echo -e "${V_cyan}################################################################################################################################################${NC}"
	 rm -f $HOME/.tmp.txt > /dev/null 2>&1
echo ""

echo -e "${V_yellow}1${NC}) Volver al menu principal."
read aux

while [ $aux -lt 1 ] || [ $aux -gt 1 ]
do
echo "Valor incorrecto ingrese la opción correcta:"
read aux
done

while [[  $aux == "1" ]]
do
menu;
done
done

while [[  $aux == "5" ]]
do
clear
echo "Ingrese nuevo Link"
read V_new
	if [ "$V_new" == "" ];
   	then
    V_new="++++++++"
  	fi
line=`cat $HOME/.Inventario  | grep -inw $V_rec| awk -F':' '{print $1}'|tr -d "\015"`
 sed -i "${line} s,${V_lnk},${V_new},g" $HOME/.Inventario
V_lnk=$V_new
clear
	 touch $HOME/.tmp.txt
	echo "$V_recurso  |$V_usuario  |$V_password  |$V_descripcion  |$V_link" |  tee --append $HOME/.tmp.txt > /dev/null 2>&1
	echo "$V_rec |$V_user  |$V_pass  |$V_desc |$V_lnk" |  tee --append $HOME/.tmp.txt > /dev/null 2>&1
	clear
	echo -e "${V_cyan}################################################################################################################################################${NC}"
	echo "` cat $HOME/.tmp.txt`"|column -t -s "|"
	echo -e "${V_cyan}################################################################################################################################################${NC}"
	 rm -f $HOME/.tmp.txt > /dev/null 2>&1

echo -e "${V_yellow}1${NC}) Volver al menu principal."
read aux

while [ $aux -lt 1 ] || [ $aux -gt 1 ]
do
echo "Valor incorrecto ingrese la opción correcta:"
read aux
done

while [[  $aux == "1" ]]
do
menu;
done
done
}

##########################################
# Funcion alta en inventario             #
##########################################
F_add_s(){
clear
V_recurso="Recurso"
V_usuario="Usuario"
V_password="Password"
V_descripcion="Descripcion"
V_link="Link"

echo "Ingrese recurso:"
read V_rec
while [[  $V_rec == "" ]]
do
			echo "El campo recurso no puede ser nulo."
			echo "Por favor ingresar un valor:"
			read V_rec
done



V_recu=`cat $HOME/.Inventario  | grep -wi $V_rec | awk '{print $1}'` 
V_user=`cat $HOME/.Inventario  | grep -wi $V_rec | awk '{print $2}'`
V_pass=`cat $HOME/.Inventario  | grep -wi $V_rec | awk '{print $3}'` 
V_desc=`cat $HOME/.Inventario  | grep -wi $V_rec | awk '{print $4}'`
V_lnk=`cat $HOME/.Inventario  | grep -wi $V_rec | awk '{print $5}'`

clear

if [[ `cat $HOME/.Inventario  | grep -wi $V_rec | awk '{print $1}'` != "" ]]
then
   	
	echo -e "INFO: El recurso ${V_red}$V_rec${NC}${V_cyan} ya se encuentra en el inventario no hace falta agregarlo.${NC}"
		
	touch $HOME/.tmp.txt
	echo "$V_recurso  |$V_usuario  |$V_password  |$V_descripcion  |$V_link" |  tee --append $HOME/.tmp.txt > /dev/null 2>&1
	echo "$V_recu |$V_user  |$V_pass  |$V_desc |$V_lnk" |  tee --append $HOME/.tmp.txt > /dev/null 2>&1
	clear
	echo -e "${V_cyan}################################################################################################################################################${NC}"
	echo "` cat $HOME/.tmp.txt`"|column -t -s "|"
	echo -e "${V_cyan}################################################################################################################################################${NC}"
	 rm -f $HOME/.tmp.txt > /dev/null 2>&1
			echo ""
			echo -e "${V_yellow}1${NC}) Volver al menu anterior."
			echo -e "${V_yellow}2${NC}) Volver al menu principal."
			read aux

			while [ $aux -lt 1 ] || [ $aux -gt 2 ]
			do
			echo "Valor incorrecto ingrese la opción correcta:"
			read aux
			done

			while [[  $aux == "1" ]]
			do
			F_inventario;
			done

			while [[  $aux == "2" ]]
			do
			menu;
			done 
		
		

fi

if [[ `cat $HOME/.Inventario  | grep -wi $V_rec | awk '{print $1}'` == "" ]]
	then
	

	echo "Ingrese usuario:"
	read V_user
	
	if [ "$V_user" == "" ];
   	then
    V_user="########"
	fi

	while [ "$V_user" == "$V_rec" ];
   	do
    		echo "El campo $V_user que intenta agregar no puede estar repetido en oto campo del alta."
    		echo "Por favor ingrese otro valor:"
			read V_rec
	done
clear
	echo "Ingrese Password:"
	read V_pass
	if [ "$V_pass" == "" ];
   	then
    V_pass="xxxxxxxx"
	fi
	
	while [ "$V_pass" == "$V_rec" -o "$V_pass" == "$V_user" ];
   	do
    		echo "El campo $V_pass que intenta agregar no puede estar repetido en oto campo del alta."
			echo "Por favor ingrese otro valor:"
			read V_pass
	done
clear
	echo "Ingrese Descripcion:"
	read V_desc
	
	if [ "$V_desc" == "" ];
   	then
    V_desc="********"
  	fi

  	while [ "$V_desc" == "$V_rec" -o "$V_desc" == "$V_user" -o "$V_desc" == "$V_pass" ];
   	do
    		echo "El campo $V_desc que intenta agregar no puede estar repetido en oto campo del alta."
			echo "Por favor ingrese otro valor:"
			read V_desc
	done
clear	
	echo "Ingrese Link:"
	read V_lnk

	if [ "$V_lnk" == "" ];
   	then
    V_lnk="++++++++"
  	fi

  	while [ "$V_lnk" == "$V_rec" -o "$V_lnk" == "$V_user" -o "$V_lnk" == "$V_pass" -o "$V_lnk" == "$V_desc" ];
   	do
    		echo "El campo $V_lnk que intenta agregar no puede estar repetido en oto campo del alta."
			echo "Por favor ingrese otro valor:"
			read V_lnk
	done

	echo "$V_rec $V_user $V_pass $V_desc $V_lnk" |  tee --append $HOME/.Inventario   
	clear
	V_recu=`cat $HOME/.Inventario  | grep -wi $V_rec | awk '{print $1}'` 
	V_user=`cat $HOME/.Inventario  | grep -wi $V_rec | awk '{print $2}'`
	V_pass=`cat $HOME/.Inventario  | grep -wi $V_rec | awk '{print $3}'` 
	V_desc=`cat $HOME/.Inventario  | grep -wi $V_rec | awk '{print $4}'`
	V_lnk=`cat $HOME/.Inventario  | grep -wi $V_rec | awk '{print $5}'`

	echo ""
	touch $HOME/.tmp.txt
	echo "$V_recurso  |$V_usuario  |$V_password  |$V_descripcion  |$V_link" |  tee --append $HOME/.tmp.txt > /dev/null 2>&1
	echo "$V_recu |$V_user  |$V_pass  |$V_desc |$V_lnk" |  tee --append $HOME/.tmp.txt > /dev/null 2>&1
	clear
	echo -e "${V_cyan}######################################################################################################################################${NC}"
	echo "` cat $HOME/.tmp.txt`"|column -t -s "|"
	echo -e "${V_cyan}######################################################################################################################################${NC}"
	rm -f $HOME/.tmp.txt > /dev/null 2>&1



	echo -e "${V_yellow}1${NC}) Volver al menu anterior."
	echo -e "${V_yellow}2${NC}) Volver al menu principal."
	read aux

	while [ $aux -lt 1 ] || [ $aux -gt 2 ]
	do
	echo "Valor incorrecto ingrese la opción correcta:"
	read aux
	done

	while [[  $aux == "1" ]]
	do
	F_inventario;
	done

	while [[  $aux == "2" ]]
	do
	menu;
	done	
fi
}

########################################
# Funcion baja del inventario.         #
########################################
F_delete_s(){
clear
V_recurso="Recurso"
V_usuario="Usuario"
V_password="Password"
V_descripcion="Descripcion"
V_link="Link"

echo "Ingrese servidor:"
read V_rec

V_recu=`cat $HOME/.Inventario  | grep -wi $V_rec | awk '{print $1}'` 
V_user=`cat $HOME/.Inventario  | grep -wi $V_rec | awk '{print $2}'`
V_pass=`cat $HOME/.Inventario  | grep -wi $V_rec | awk '{print $3}'` 
V_desc=`cat $HOME/.Inventario  | grep -wi $V_rec | awk '{print $4}'`
V_lnk=`cat $HOME/.Inventario  | grep -wi $V_rec | awk '{print $5}'`

clear

if [[ `cat $HOME/.Inventario  | grep -wi $V_rec | awk '{print $1}'` == "" ]]
then
			echo -e "El recurso no se encuentra en el inventario."
			
			echo -e "${V_yellow}1${NC}) Volver al menu principal."
			read aux

		while [ $aux -lt 1 ] || [ $aux -gt 1 ] || [ $aux == ""]
		do
			echo "Valor incorrecto ingrese la opción correcta:"
			read aux
		done
				if [ $aux -eq 1 ] ; then
				menu
				fi
fi


	touch $HOME/.tmp.txt
	echo "$V_recurso  |$V_usuario  |$V_password  |$V_descripcion  |$V_link" |  tee --append $HOME/.tmp.txt > /dev/null 2>&1
	echo "$V_rec |$V_user  |$V_pass  |$V_desc |$V_lnk" |  tee --append $HOME/.tmp.txt > /dev/null 2>&1
	clear
	echo -e "${V_cyan}############################################################################################################################${NC}"
	echo "` cat $HOME/.tmp.txt`"|column -t -s "|"
	echo -e "${V_cyan}############################################################################################################################${NC}"
	 rm -f $HOME/.tmp.txt > /dev/null 2>&1

	echo ""
	echo "Se va a eliminar el siguiente registro del inventario correspondiente al recurso $V_rec."
	echo "¿Esta seguro que desea borrarlo?"
	echo -e "${V_yellow}y${NC}/${V_yellow}n${NC}"
	read aux

	END=0

	while [ "$END" -eq "0" ]
	do
  		if [ "$aux" == "y" -o "${aux}" == "n" ]
   		then
    	END=1
   		else
    	echo -e "Ingresaste un valor incorrecto, contestar con ${V_yellow}y${NC}/${V_yellow}n${NC}:"
   		read aux
		fi
	done

if [[  $aux == "y" ]]
then
	 sed -i "/${V_rec}/d" $HOME/.Inventario

	echo -e "Se elimino el registro ${V_red}$V_rec${NC} del inventario."


	echo -e "${V_yellow}1${NC}) Volver al menu anterior."
	echo -e "${V_yellow}2${NC}) Volver al menu principal."
	read aux

	while [ $aux -lt 1 ] || [ $aux -gt 2 ]
	do
	echo "Valor incorrecto ingrese la opción correcta:"
	read aux
	done

	while [[  $aux == "1" ]]
	do
	F_inventario;
	done

	while [[  $aux == "2" ]]
	do
	menu;
	done
fi
if [[  $aux == "n" ]]
	then
	echo -e "${V_cyan}No se elimino ningun registro del inventario.${NC}"
	echo ""
	echo ""1
	echo -e "${V_yellow}1${NC}) Volver al menu anterior."
	echo -e "${V_yellow}2${NC}) Volver al menu principal."
	read aux
	
	while [ $aux -lt 1 ] || [ $aux -gt 2 ]
	do
	echo "Valor incorrecto ingrese la opción correcta:"
	read aux
	done

	while [[  $aux == "1" ]]
	do
	F_inventario;
	done

	while [[  $aux == "2" ]]
	do
	menu;
	done
fi
}

########################################
# Funcion expotar invetario            #
########################################
F_export_s(){
clear
cat $HOME/.Inventario > $HOME/inventario.csv
echo -e "Se exporto el inventario en la sigfuiente ruta ${V_red}$HOME/inventario.csv${NC}" 

			echo ""
			echo -e "${V_yellow}1${NC}) Volver al menu anterior."
			echo -e "${V_yellow}2${NC}) Volver al menu principal."
			read aux

			while [ $aux -lt 1 ] || [ $aux -gt 2 ]
			do
			echo "Valor incorrecto ingrese la opción correcta:"
			read aux
			done

			while [[  $aux == "1" ]]
			do
			F_inventario;
			done

			while [[  $aux == "2" ]]
			do
			menu;
			done 


}

########################################
# Funcion ver inventario completo      #
########################################
F_view_s(){
clear
cat $HOME/.Inventario|column -t

			echo ""
			echo -e "${V_yellow}1${NC}) Volver al menu anterior."
			echo -e "${V_yellow}2${NC}) Volver al menu principal."
			read aux

			while [ $aux -lt 1 ] || [ $aux -gt 2 ]
			do
			echo "Valor incorrecto ingrese la opción correcta:"
			read aux
			done

			while [[  $aux == "1" ]]
			do
			F_inventario;
			done

			while [[  $aux == "2" ]]
			do
			menu;
			done 

}

menu;
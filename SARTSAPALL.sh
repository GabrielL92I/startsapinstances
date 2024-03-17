#! /bin/bash

###########COLORS#########
RED='\033[0;31m' # Red
NC='\033[0m' # No Color
GREEN='\033[0;32m' # Green
BLUE='\033[0;34m' # Blue
YELLOW='\033[0;33m' # Yellow
BBOLD='\033[1;30m' # Bold Black
UBLACK='\033[4;30m' # Underline Black
BRED='\033[1;31m' # Bold Red
BGREEN='\033[1;32m' #Bold Green

############CODE###########
echo -e "\n\nScript made by: ${UBLACK}${BBOLD}Gabriel Lami${NC}!\nThank you for using!\n";
sleep 3;
echo -e "Input ${BBOLD}1 ${NC}to ${GREEN}Start ${BBOLD}HANA DB + S/4 APP${NC};";
echo -e "Input ${BBOLD}2 ${NC}to ${RED}Stop ${BBOLD}HANA DB + S/4 APP${NC};";
echo -e "Input ${BBOLD}0 ${NC}to ${YELLOW}Exit Me${NC};";
while :
do
    echo -e "\n${UBLACK}Please input your ${UBLACK}${BBOLD}number:"    
    read aNum
    case $aNum in
    1)
        echo -e "${YELLOW}STARTING ${BBOLD}HANA DB${NC}...\n";
        su - hdbadm -c "/usr/sap/hostctrl/exe/sapcontrol -nr 02 -function Start";
while :
do
     count=$(/usr/sap/hostctrl/exe/sapcontrol -nr 02 -function GetProcessList | grep -o 'GREEN' |wc -l);
     sleep 1;
     if [ "$count" = 11 ];
     then
         echo -e "\n\n${BBOLD}HANA DB ${NC}SUCCESSFULLY ${BGREEN}STARTED${NC}...\n";
     sleep 1
         echo -e "\n\n${YELLOW}STARTING ${BBOLD}S/4 APP${NC}...\n";
         su - s4hadm -c "/usr/sap/hostctrl/exe/sapcontrol -nr 00 -function StartSystem";
while :
do
      count=$(/usr/sap/hostctrl/exe/sapcontrol -nr 00 -function GetProcessList | grep -o 'GREEN' |wc -l);
      sleep 1;
      if [ "$count" = 4 ];
      then
          echo -e "\n\n${BBOLD}S/4 APP${NC}SUCCESSFULLY ${BGREEN}STARTED${NC}...\n";
      break;
      fi
      done
      break;
      fi
done
   ;;
    2)
		echo -e "${YELLOW}STOPPING ${BBOLD}S/4 APP${NC}...\n";
        su - s4hadm -c "/usr/sap/hostctrl/exe/sapcontrol -nr 00 -function StopSystem";
while :
do
     count=$(/usr/sap/hostctrl/exe/sapcontrol -nr 00 -function GetProcessList | grep -o 'GRAY' |wc -l);
     sleep 1;
     if [ "$count" = 3 ];
     then
		  
		  echo -e "\n\n${BBOLD}S/4 APP ${NC}SUCCESSFULLY ${BRED}STOPPED${NC}...\n";
     sleep 1
		 echo -e "\n\nSTOPPING HANA DB ...\n";
		 su - hdbadm -c "/usr/sap/hostctrl/exe/sapcontrol -nr 02 -function Stop";
while :
do
	  count=$(/usr/sap/hostctrl/exe/sapcontrol -nr 02 -function GetProcessList | grep -o 'GRAY' |wc -l);
      sleep 1;
      if [ "$count" = 1 ];
      then
          echo -e "\n\n${BBOLD}HANA DB ${NC}SUCCESSFULLY ${BRED}STOPPED${NC}...\n";
      break;
      fi
      done
      break;
      fi
done
   ;;
    0)
       echo -e "\n${BBOLD}Bye!${NC}"
       break
   ;;
    *)
       echo -e "\n${RED}Error Input!${NC}"
    ;;
    esac
done

#!/bin/bash
#Script made by Gabriel Lami!

# Define colors for echo
RED='\033[0;31m' # Red
NC='\033[0m' # No Color
GREEN='\033[0;32m' # Green
BLUE='\033[0;34m' # Blue
YELLOW='\033[0;33m' # Yellow
BBOLD='\033[1;30m' # Bold Black
UBLACK='\033[4;30m' # Underline Black
BRED='\033[1;31m' # Bold Red
BGREEN='\033[1;32m' #Bold Green

# Define colors for read
RED=$'\033[0;31m' # Red
NC=$'\033[0m' # No Color
GREEN=$'\033[0;32m' # Green
BLUE=$'\033[0;34m' # Blue
YELLOW=$'\033[0;33m' # Yellow
BBOLD=$'\033[1;30m' # Bold Black
UBLACK=$'\033[4;30m' # Underline Black
BRED=$'\033[1;31m' # Bold Red
BGREEN=$'\033[1;32m' #Bold Green

# Function to start HANA DB
start_hana_db() {
    local hdb_sid=$1
    echo -e "${YELLOW}STARTING ${BBOLD}HANA DB${NC}..."
    su - "${hdb_sid}adm" -c "/usr/sap/hostctrl/exe/sapcontrol -nr 02 -function Start"
    # Wait until HANA DB processes are up
    while true; do
        count=$(/usr/sap/hostctrl/exe/sapcontrol -nr 02 -function GetProcessList | grep -o 'GREEN' | wc -l)
        if [ "$count" -ge 11 ]; then
            echo -e "${BBOLD}HANA DB ${NC}SUCCESSFULLY ${BGREEN}STARTED${NC}..."
            break
        fi
        sleep 1
    done
}

# Function to start S/4 APP
start_s4_app() {
    local s4h_sid=$1
    echo -e "${YELLOW}STARTING ${BBOLD}S/4 APP${NC}..."
    su - "${s4h_sid}adm" -c "/usr/sap/hostctrl/exe/sapcontrol -nr 00 -function StartSystem"
    # Wait until S/4 APP processes are up
    while true; do
        count=$(/usr/sap/hostctrl/exe/sapcontrol -nr 00 -function GetProcessList | grep -o 'GREEN' | wc -l)
        if [ "$count" -ge 4 ]; then
            echo -e "${BBOLD}S/4 APP ${NC}SUCCESSFULLY ${BGREEN}STARTED${NC}..."
            break
        fi
        sleep 1
    done
}

# Function to start AS JAVA
start_as_java() {
    local s4j_sid=$1
    echo -e "${YELLOW}STARTING ${BBOLD}AS JAVA${NC}..."
    su - "${s4j_sid}adm" -c "/usr/sap/hostctrl/exe/sapcontrol -nr 03 -function StartSystem"
    # Wait until AS JAVA processes are up
    while true; do
        count=$(/usr/sap/hostctrl/exe/sapcontrol -nr 03 -function GetProcessList | grep -o 'GREEN' | wc -l)
        if [ "$count" -ge 2 ]; then
            echo -e "${BBOLD}AS JAVA ${NC}SUCCESSFULLY ${BGREEN}STARTED${NC}..."
            break
        fi
        sleep 1
    done
}

# Function to stop HANA DB
stop_hana_db() {
    local hdb_sid=$1
    echo -e "${YELLOW}STOPPING ${BBOLD}HANA DB${NC}..."
    su - "${hdb_sid}adm" -c "/usr/sap/hostctrl/exe/sapcontrol -nr 02 -function Stop"
    # Wait until HANA DB processes are stopped
    while true; do
        count=$(/usr/sap/hostctrl/exe/sapcontrol -nr 02 -function GetProcessList | grep -o 'GRAY' | wc -l)
        if [ "$count" -eq 1 ]; then
            echo -e "${BBOLD}HANA DB ${NC}SUCCESSFULLY ${RED}STOPPED${NC}..."
            break
        fi
        sleep 1
    done
}

# Function to stop S/4 APP
stop_s4_app() {
    local s4h_sid=$1
    echo -e "${YELLOW}STOPPING ${BBOLD}S/4 APP${NC}..."
    su - "${s4h_sid}adm" -c "/usr/sap/hostctrl/exe/sapcontrol -nr 00 -function StopSystem"
    # Wait until S/4 APP processes are stopped
    while true; do
        count=$(/usr/sap/hostctrl/exe/sapcontrol -nr 00 -function GetProcessList | grep -o 'GRAY' | wc -l)
        if [ "$count" -eq 3 ]; then
            echo -e "${BBOLD}S/4 APP ${NC}SUCCESSFULLY ${RED}STOPPED${NC}..."
            break
        fi
        sleep 1
    done
}

# Function to stop AS JAVA
stop_as_java() {
    local s4j_sid=$1
    echo -e "${YELLOW}STOPPING ${BBOLD}AS JAVA${NC}..."
    su - "${s4j_sid}adm" -c "/usr/sap/hostctrl/exe/sapcontrol -nr 03 -function StopSystem"
    # Wait until AS JAVA processes are stopped
    while true; do
        count=$(/usr/sap/hostctrl/exe/sapcontrol -nr 03 -function GetProcessList | grep -o 'GRAY' | wc -l)
        if [ "$count" -eq 2 ]; then
            echo -e "${BBOLD}AS JAVA ${NC}SUCCESSFULLY ${RED}STOPPED${NC}..."
            break
        fi
        sleep 1
    done
}

# Main menu
show_menu() {
    echo -e "\n${BBOLD}1.${NC} ${GREEN}Start SAP instances${NC}"
    echo -e "${BBOLD}2.${NC} ${RED}Stop SAP instances${NC}"
    echo -e "${BBOLD}0.${NC} ${YELLOW}Exit${NC}"
}

# Main script
echo -e "\n${BBOLD}Script made by: Gabriel Lami${NC}"
echo -e "Thank you for using!\n"

while :
do
    show_menu
    read -p "Please input your choice: " choice

    case $choice in
        1)
            read -p "Enter the ${BBOLD}SID ${NC}for ${BBOLD}HANA DB ${NC}(e.g., ${BLUE}hdb${NC}): " hdb_sid
			if [ -z "$hdb_sid" ]; then
                echo -e "${RED}HANA DB SID cannot be empty! Please enter the HANA DB SID.${NC}"
                continue
            fi
            read -p "Enter the ${BBOLD}SID ${NC}for ${BBOLD}S/4 APP ${NC}(e.g., ${BLUE}s4h${NC}): " s4h_sid
            read -p "Enter the ${BBOLD}SID ${NC}for ${BBOLD}AS JAVA ${NC}(e.g., ${BLUE}s4j${NC}): " s4j_sid
			start_hana_db "$hdb_sid"
            if [ -n "$s4h_sid" ]; then
                start_s4_app "$s4h_sid"
            fi
            if [ -n "$s4j_sid" ]; then
                start_as_java "$s4j_sid"
            fi
            ;;
        2)
           read -p "Enter the ${BBOLD}SID ${NC}for ${BBOLD}HANA DB ${NC}(e.g., ${BLUE}hdb${NC}): " hdb_sid
		   if [ -z "$hdb_sid" ]; then
                echo -e "${RED}HANA DB SID cannot be empty! Please enter the HANA DB SID.${NC}"
                continue
            fi
           read -p "Enter the ${BBOLD}SID ${NC}for ${BBOLD}S/4 APP ${NC}(e.g., ${BLUE}s4h${NC}): " s4h_sid
           read -p "Enter the ${BBOLD}SID ${NC}for ${BBOLD}AS JAVA ${NC}(e.g., ${BLUE}s4j${NC}): " s4j_sid
           if [ -n "$s4j_sid" ]; then
               stop_as_java "$s4j_sid"
           fi
           if [ -n "$s4h_sid" ]; then
               stop_s4_app "$s4h_sid"
           fi
           stop_hana_db "$hdb_sid"
           ;;
		0)
           echo -e "${BBOLD}Bye!${NC}"
           exit 0
           ;;
        *)
           echo -e "${RED}Invalid input!${NC}"
           ;;
 esac
done

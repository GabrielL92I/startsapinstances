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
    local hdb_cin=$1
    echo -e "\n\n${YELLOW}STARTING ${BBOLD}HANA DB${NC}..."
    /usr/sap/hostctrl/exe/sapcontrol -nr $hdb_cin -function Start
    # Wait until HANA DB processes are up
    while true; do
        count=$(/usr/sap/hostctrl/exe/sapcontrol -nr $hdb_cin -function GetProcessList | grep -o 'GREEN' | wc -l)
        if [ "$count" -ge 11 ]; then
            echo -e "\n${BBOLD}HANA DB ${NC}SUCCESSFULLY ${BGREEN}STARTED${NC}..."
            break
        fi
        sleep 1
    done
}
# Function to start S/4 APP
start_s4_app() {
    local s4h_cin=$1
    echo -e "\n\n${YELLOW}STARTING ${BBOLD}S/4 APP${NC}..."
    /usr/sap/hostctrl/exe/sapcontrol -nr $s4h_cin -function StartSystem
    # Wait until S/4 APP processes are up
    while true; do
        count=$(/usr/sap/hostctrl/exe/sapcontrol -nr $s4h_cin -function GetProcessList | grep -o 'GREEN' | wc -l)
        if [ "$count" -ge 4 ]; then
            echo -e "\n${BBOLD}S/4 APP ${NC}SUCCESSFULLY ${BGREEN}STARTED${NC}..."
            break
        fi
        sleep 1
    done
}
# Function to start AS JAVA
start_as_java() {
    local s4j_cin=$1
    echo -e "\n\n${YELLOW}STARTING ${BBOLD}AS JAVA${NC}..."
    /usr/sap/hostctrl/exe/sapcontrol -nr $s4j_cin -function StartSystem
    # Wait until AS JAVA processes are up
    while true; do
        count=$(/usr/sap/hostctrl/exe/sapcontrol -nr $s4j_cin -function GetProcessList | grep -o 'GREEN' | wc -l)
        if [ "$count" -ge 2 ]; then
            echo -e "\n${BBOLD}AS JAVA ${NC}SUCCESSFULLY ${BGREEN}STARTED${NC}..."
            break
        fi
        sleep 1
    done
}
# Function to stop HANA DB
stop_hana_db() {
    local hdb_cin=$1
    echo -e "\n\n${YELLOW}STOPPING ${BBOLD}HANA DB${NC}..."
    /usr/sap/hostctrl/exe/sapcontrol -nr $hdb_cin -function Stop
    # Wait until HANA DB processes are stopped
    while true; do
        count=$(/usr/sap/hostctrl/exe/sapcontrol -nr $hdb_cin -function GetProcessList | grep -o 'GRAY' | wc -l)
        if [ "$count" -eq 0 ] || [ "$count" -eq 1 ]; then
            echo -e "\n${BBOLD}HANA DB ${NC}SUCCESSFULLY ${RED}STOPPED${NC}..."
            break
        fi
        sleep 1
    done
}
# Function to stop S/4 APP
stop_s4_app() {
    local s4h_cin=$1
    echo -e "\n\n${YELLOW}STOPPING ${BBOLD}S/4 APP${NC}..."
    /usr/sap/hostctrl/exe/sapcontrol -nr $s4h_cin -function StopSystem
    # Wait until S/4 APP processes are stopped
    while true; do
        count=$(/usr/sap/hostctrl/exe/sapcontrol -nr $s4h_cin -function GetProcessList | grep -o 'GRAY' | wc -l)
        if [ "$count" -eq 3 ]; then
            echo -e "\n${BBOLD}S/4 APP ${NC}SUCCESSFULLY ${RED}STOPPED${NC}..."
            break
        fi
        sleep 1
    done
}
# Function to stop AS JAVA
stop_as_java() {
    local s4j_cin=$1
    echo -e "\n\n${YELLOW}STOPPING ${BBOLD}AS JAVA${NC}..."
    /usr/sap/hostctrl/exe/sapcontrol -nr $s4j_cin -function StopSystem
    # Wait until AS JAVA processes are stopped
    while true; do
        count=$(/usr/sap/hostctrl/exe/sapcontrol -nr $s4j_cin -function GetProcessList | grep -o 'GRAY' | wc -l)
        if [ "$count" -eq 2 ]; then
            echo -e "\n${BBOLD}AS JAVA ${NC}SUCCESSFULLY ${RED}STOPPED${NC}..."
            break
        fi
        sleep 1
    done
}
# Function to show SAP Instance status
check_sap_status() {
    local hdb_nr=$1
    local s4_app_nr=$2
    local as_java_nr=$3
    # Check HANA DB status
    local count_green_hdb=$(/usr/sap/hostctrl/exe/sapcontrol -nr $hdb_nr -function GetProcessList | grep -o 'GREEN' | wc -l)
    local count_grey_hdb=$(/usr/sap/hostctrl/exe/sapcontrol -nr $hdb_nr -function GetProcessList | grep -o 'GRAY' | wc -l)
    if [ "$count_green_hdb" -eq 11 ]; then
        echo -e "\n${BBOLD}HANA DB ${NC}status: ${BGREEN}STARTED${NC}"
    elif [ "$count_grey_hdb" -eq 0 ] || [ "$count" -eq 1 ]; then
        echo -e "\n${BBOLD}HANA DB ${NC}status: ${RED}STOPPED${NC}"
    else
        echo -e "\n${BBOLD}HANA DB ${NC}status: ${YELLOW}UNKNOWN${NC}"
    fi
    # Check S/4 APP status
    local count_green_s4_app=$(/usr/sap/hostctrl/exe/sapcontrol -nr $s4_app_nr -function GetProcessList | grep -o 'GREEN' | wc -l)
    local count_grey_s4_app=$(/usr/sap/hostctrl/exe/sapcontrol -nr $s4_app_nr -function GetProcessList | grep -o 'GRAY' | wc -l)

    if [ "$count_green_s4_app" -eq 4 ]; then
        echo -e "${BBOLD}S/4 APP ${NC}status: ${BGREEN}STARTED${NC}"
    elif [ "$count_grey_s4_app" -eq 2 ]; then
        echo -e "${BBOLD}S/4 APP ${NC}status: ${RED}STOPPED${NC}"
    else
        echo -e "${BBOLD}S/4 APP ${NC}status: ${YELLOW}UNKNOWN${NC}"
    fi
    # Check AS JAVA status
    local count_green_as_java=$(/usr/sap/hostctrl/exe/sapcontrol -nr $as_java_nr -function GetProcessList | grep -o 'GREEN' | wc -l)
    local count_grey_as_java=$(/usr/sap/hostctrl/exe/sapcontrol -nr $as_java_nr -function GetProcessList | grep -o 'GRAY' | wc -l)

    if [ "$count_green_as_java" -eq 2 ]; then
        echo -e "${BBOLD}AS JAVA ${NC}status: ${BGREEN}STARTED${NC}"
    elif [ "$count_grey_as_java" -eq 2 ]; then
        echo -e "${BBOLD}AS JAVA ${NC}status: ${RED}STOPPED${NC}"
    else
        echo -e "${BBOLD}AS JAVA ${NC}status: ${YELLOW}UNKNOWN${NC}"
    fi
	sleep 1
}
# Main menu
show_menu() {
    if $first_time; then
        first_time=false
    else
	    printf "\n"
        read -n 1 -s -r -p "Press any key to continue to the menu..."
    fi
    clear
    echo -e "\n${BBOLD}Script made by: Gabriel Lami${NC}"
    echo -e "Thank you for using!"
    echo -e "\n${BBOLD}1.${NC} ${BGREEN}Start SAP Instances${NC}"
    echo -e "${BBOLD}2.${NC} ${RED}Stop SAP Instances${NC}"
    echo -e "${BBOLD}3.${NC} ${BLUE}SAP Instance Status${NC}"
    echo -e "${BBOLD}0.${NC} ${YELLOW}Exit${NC}\n"
}
main() {  
    while :
    do
        show_menu
        read -p "Please input your choice: " choice
        case $choice in
            1)
                read -p "Enter the ${BBOLD}CIN ${NC}for ${BBOLD}HANA DB ${NC}(e.g., ${BLUE}02${NC}): " hdb_cin
			    if [ -z "$hdb_cin" ]; then
                echo -e "${RED}Info: Becareful. HANA DB should be started before you start S/4 APP or AS JAVA.${NC}"    
                elif [ -z "$hdb_cin" ] && [ -z "$s4j_cin" ] && [ -z "$s4h_cin" ]; then
				echo -e "${RED}Info: At least one CIN must be provided.${NC}"
                continue				
                fi
                read -p "Enter the ${BBOLD}CIN ${NC}for ${BBOLD}S/4 APP ${NC}(e.g., ${BLUE}00${NC}): " s4h_cin
                read -p "Enter the ${BBOLD}CIN ${NC}for ${BBOLD}AS JAVA ${NC}(e.g., ${BLUE}03${NC}): " s4j_cin
				if [ -n "$hdb_cin" ]; then
			    start_hana_db "$hdb_cin"
				fi
                if [ -n "$s4h_cin" ]; then
                start_s4_app "$s4h_cin"
                fi
                if [ -n "$s4j_cin" ]; then
                start_as_java "$s4j_cin"
                fi
                ;;
            2)
                read -p "Enter the ${BBOLD}CIN ${NC}for ${BBOLD}AS JAVA ${NC}(e.g., ${BLUE}03${NC}): " s4j_cin
		        read -p "Enter the ${BBOLD}CIN ${NC}for ${BBOLD}S/4 APP ${NC}(e.g., ${BLUE}00${NC}): " s4h_cin        
                read -p "Enter the ${BBOLD}CIN ${NC}for ${BBOLD}HANA DB ${NC}(e.g., ${BLUE}02${NC}): " hdb_cin
		        if [ -z "$hdb_cin" ] && { [ ! -z "$s4j_cin" ] || [ ! -z "$s4h_cin" ]; }; then
                   echo -e "${RED}HANA DB should be the last to stop if S/4 APP or AS JAVA is already started!${NC}"
				elif [ -z "$hdb_cin" ] && [ -z "$s4j_cin" ] && [ -z "$s4h_cin" ]; then
				echo -e "${RED}Info: At least one CIN must be provided.${NC}"
                continue
                fi
                if [ -n "$s4j_cin" ]; then
                stop_as_java "$s4j_cin"
                fi
                if [ -n "$s4h_cin" ]; then
                stop_s4_app "$s4h_cin"
                fi
		        if [ -n "$hdb_cin" ]; then
                stop_hana_db "$hdb_cin"
		        fi
                ;;
            3)
                read -p "Enter the ${BBOLD}CIN ${NC}for ${BBOLD}HANA DB ${NC}(e.g., ${BLUE}02${NC}): " hdb_nr
				read -p "Enter the ${BBOLD}CIN ${NC}for ${BBOLD}S/4 APP ${NC}(e.g., ${BLUE}00${NC}): " s4_app_nr
				read -p "Enter the ${BBOLD}CIN ${NC}for ${BBOLD}AS JAVA ${NC}(e.g., ${BLUE}03${NC}): " as_java_nr
                if [ -z "$hdb_nr" ] && [ -z "$s4_app_nr" ] && [ -z "$as_java_nr" ]; then
				echo -e "${RED}At least one CIN must be provided.${NC}"
                continue
				fi
				if [ -z "$hdb_nr" ] || [ -z "$s4_app_nr" ] || [ -z "$as_java_nr" ]; then
				echo -e "${YELLOW}Info: Status will be 'UNKNOWN' for all the empty CIN's.${NC}"
				fi
                check_sap_status "$hdb_nr" "$s4_app_nr" "$as_java_nr"
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
}
    echo -e "\n${BBOLD}Script made by: Gabriel Lami${NC}"
    echo -e "Thank you for using!"
    echo -e "\n${BBOLD}1.${NC} ${BGREEN}Start SAP Instances${NC}"
    echo -e "${BBOLD}2.${NC} ${RED}Stop SAP Instances${NC}"
    echo -e "${BBOLD}3.${NC} ${BLUE}SAP Instance Status${NC}"
    echo -e "${BBOLD}0.${NC} ${YELLOW}Exit${NC}\n"
# Call the main function to start the script
main

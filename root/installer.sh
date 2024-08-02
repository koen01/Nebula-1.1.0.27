#!/bin/sh

VERSION=v3.9.0

white=`echo "\033[m"`
blue=`echo "\033[36m"`
cyan=`echo "\033[1;36m"`
yellow=`echo "\033[1;33m"`
green=`echo "\033[01;32m"`
red=`echo "\033[01;31m"`
darkred=`echo "\033[31m"`
moonraker_folder="/usr/data/moonraker/"
moonraker_URL="https://raw.githubusercontent.com/Guilouz/Creality-K1-and-K1-Max/main/Scripts/files/moonraker/moonraker.tar"
moonraker_config_URL="https://raw.githubusercontent.com/Guilouz/Creality-K1-and-K1-Max/main/Scripts/files/moonraker/moonraker.conf"
nginx_folder="/usr/data/nginx/"
fluidd_folder="/usr/data/fluidd/"
fluidd_URL="https://github.com/fluidd-core/fluidd/releases/latest/download/fluidd.zip"
mainsail_folder="/usr/data/mainsail/"
mainsail_URL="https://github.com/mainsail-crew/mainsail/releases/latest/download/mainsail.zip"
moonraker_obico_folder="/usr/data/moonraker-obico/"
moonraker_obico_URL="https://github.com/TheSpaghettiDetective/moonraker-obico.git"
octoeverywhere_folder="/usr/data/octoeverywhere/"
octoeverywhere_URL="https://github.com/QuinnDamerell/OctoPrint-OctoEverywhere.git"
timelapse_file="/usr/data/moonraker/moonraker/moonraker/components/timelapse.py"
timelapse_URL1="https://raw.githubusercontent.com/Guilouz/Creality-K1-and-K1-Max/main/Scripts/files/timelapse/timelapse.py"
timelapse_URL2="https://raw.githubusercontent.com/Guilouz/Creality-K1-and-K1-Max/main/Scripts/files/timelapse/timelapse.cfg"
entware_folder="/usr/data/opt/"
mobileraker_folder="/usr/data/mobileraker_companion/"
mobileraker_URL1="https://github.com/Clon1998/mobileraker_companion"
mobileraker_URL2="https://raw.githubusercontent.com/Guilouz/Creality-K1-and-K1-Max/main/Scripts/files/mobileraker/mobileraker-companion-k1-no-tzlocal.patch"
kamp_folder="/usr/data/KAMP-for-K1-Series/"
kamp_URL="https://github.com/Guilouz/KAMP-for-K1-Series.git"
hostname_file="/etc/init.d/S01hostname"
hostname_URL="https://raw.githubusercontent.com/Guilouz/Creality-K1-and-K1-Max/main/Scripts/files/services/S01hostname"
systemctl_file="/usr/bin/systemctl"
systemctl_URL="https://raw.githubusercontent.com/Guilouz/Creality-K1-and-K1-Max/main/Scripts/files/fixes/systemctl"
shellcommand_file="/usr/share/klipper/klippy/extras/gcode_shell_command.py"
shellcommand_URL="https://raw.githubusercontent.com/Guilouz/Creality-K1-and-K1-Max/main/Scripts/files/shell-command/gcode_shell_command.py"
buzzer_file="/usr/data/beep.mp3"
buzzer_URL="https://raw.githubusercontent.com/Guilouz/Creality-K1-and-K1-Max/main/Scripts/files/buzzer/beep.mp3"
prtouch_folder="/usr/share/klipper/klippy/extras/prtouch_v2_fan"
prtouch_URL1="https://raw.githubusercontent.com/Guilouz/Creality-K1-and-K1-Max/main/Scripts/files/prtouch_v2_fan/__init__.py"
prtouch_URL2="https://raw.githubusercontent.com/Guilouz/Creality-K1-and-K1-Max/main/Scripts/files/prtouch_v2_fan/prtouch_v2_fan.pyc"
camera_file="/usr/data/printer_data/config/camera-settings.cfg"
camera_URL="https://raw.githubusercontent.com/Guilouz/Creality-K1-and-K1-Max/main/Scripts/files/camera/camera-settings.cfg"
bootdisplay_folder="/etc/boot-display"
bootdisplay_file="/etc/boot-display/part0/pic_100.jpg"
bootdisplay_URL1="https://raw.githubusercontent.com/Guilouz/Creality-K1-and-K1-Max/main/Scripts/files/boot-display/k1_boot_display.tar"
bootdisplay_URL2="https://raw.githubusercontent.com/Guilouz/Creality-K1-and-K1-Max/main/Scripts/files/boot-display/k1max_boot_display.tar"
bootdisplay_URL3="https://raw.githubusercontent.com/Guilouz/Creality-K1-and-K1-Max/main/Scripts/files/boot-display/stock_boot_display.tar"
crealityweb_file="/usr/bin/web-server"

check_updates() {
    github_script=$(wget --no-check-certificate -qO- https://raw.githubusercontent.com/Guilouz/Creality-K1-and-K1-Max/main/Scripts/installer.sh)
    current_script=$(cat /root/installer.sh)
    if [ "$github_script" != "$current_script" ]; then
        current_version=$(echo "$github_script" | sed -n '3s/VERSION=//p')
        printf " ${green}A new script version ($current_version) is available!\n\n"
        printf " ${white}See changelog here: ${yellow}https://tinyurl.com/w7d9k5bt\n\n"
        printf " ${white}Do you want to update? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
        read confirm
        printf "${white}\n"
        while [ "$confirm" != "y" ] && [ "$confirm" != "Y" ] && [ "$confirm" != "n" ] && [ "$confirm" != "N" ]; do
            printf "${darkred} Please select a correct choice!"
            printf "${white}\n\n"
            printf " Do you want to update to the latest version? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
            read confirm
            printf "${white}\n"
        done
        if [ "$confirm" = "y" -o "$confirm" = "Y" ]; then
            echo "$github_script" > /root/installer.sh
            printf " ${green}The script has been updated! ${white}Do you want to run the new version? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
            read run_confirm
            printf "${white}\n"
            while [ "$run_confirm" != "y" ] && [ "$run_confirm" != "Y" ] && [ "$run_confirm" != "n" ] && [ "$run_confirm" != "N" ]; do
                printf "${darkred} Please select a correct choice!"
                printf "${white}\n\n"
                printf " Do you want to run the new version? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
                read run_confirm
                printf "${white}\n"
            done
            if [ "$run_confirm" = "y" -o "$run_confirm" = "Y" ]; then
                exec sh /root/installer.sh
            elif [ "$run_confirm" = "n" -o "$run_confirm" = "N" ]; then
                printf " You can run it next time with this command: ${yellow}cd && sh ./installer.sh"
                printf "${white}\n\n"
                exit
            fi
        elif [ "$confirm" = "n" -o "$confirm" = "N" ]; then
            printf "${darkred} Update canceled!"
            printf "${white}\n\n"
        fi
    else
        printf "${green} Your script is already up to date!"
        printf "${white}\n\n"
    fi
}

check_folder() {
    local folder_path="$1"
    if [ -d "$folder_path" ]; then
        printf "${green}Installed ${white}\n"
    else
        printf "${darkred}Not Installed ${white}\n"
    fi
}

check_file() {
    local file_path="$1"
    if [ -f "$file_path" ]; then
        printf "${green}Installed ${white}\n"
    else
        printf "${darkred}Not Installed ${white}\n"
    fi
}

check_crealityweb() {
    local file_path="$1"
    if [ -f "$file_path" ]; then
        printf "${green}Present ${white}\n"
    else
        printf "${darkred}Removed ${white}\n"
    fi
}

check_ipaddress() {
    eth0_ip=$(ip -4 addr show eth0 | grep -o -E '(inet\s)([0-9]+\.){3}[0-9]+' | cut -d ' ' -f 2 | head -n 1)
    wlan0_ip=$(ip -4 addr show wlan0 | grep -o -E '(inet\s)([0-9]+\.){3}[0-9]+' | cut -d ' ' -f 2 | head -n 1)
    if [ -n "$eth0_ip" ]; then
        printf "$eth0_ip"
    elif [ -n "$wlan0_ip" ]; then
        printf "$wlan0_ip"
    else
        printf "xxx.xxx.xxx.xxx"
    fi
}

check_connection() {
    eth0_ip=$(ip -4 addr show eth0 | grep -o -E '(inet\s)([0-9]+\.){3}[0-9]+' | cut -d ' ' -f 2 | head -n 1)
    wlan0_ip=$(ip -4 addr show wlan0 | grep -o -E '(inet\s)([0-9]+\.){3}[0-9]+' | cut -d ' ' -f 2 | head -n 1)
    if [ -n "$eth0_ip" ]; then
        printf "$eth0_ip (ETHERNET)"
    elif [ -n "$wlan0_ip" ]; then
        printf "$wlan0_ip (WLAN)"
    else
        printf "xxx.xxx.xxx.xxx"
    fi
}

clear

main_menu(){
    printf " ============================================================== \n"
    printf " |     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~     | \n"
    printf " |         ${blue}Installation Helper for Creality K1 Series         ${white}| \n"
    printf " |            ${cyan}Copyright © Cyril Guislain (Guilouz)            ${white}| \n"
    printf " |     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~     | \n"
    printf " [============================================================] \n"
    printf " |                        ${yellow}[ Main Menu ]                       ${white}| \n"
    printf " [============================================================] \n"
    printf " |                                                            | \n"
    printf " | ${darkred}/!\ ONLY USE THIS SCRIPT WITH FIRMWARE 1.3.2.1 AND ABOVE!  ${white}| \n"
    printf " |                                                            | \n"
    printf " |  ${yellow}1) ${white}Open ${green}[Install] ${white}Menu                                    | \n"
    printf " |  ${yellow}2) ${white}Open ${green}[Remove] ${white}Menu                                     | \n"
    printf " |  ${yellow}3) ${white}Open ${green}[Backup & Restore] ${white}Menu                           | \n"
    printf " |  ${yellow}4) ${white}Open ${green}[Customize] ${white}Menu                                  | \n"
    printf " |  ${yellow}5) ${white}Open ${green}[Informations] ${white}Menu                               | \n"
    printf " |  ${yellow}6) ${white}Open ${green}[System] ${white}Menu                                     | \n"
    printf " |                                                            | \n"
    printf " ============================================================== \n"
    printf " |                                                            | \n"
    printf " |  ${yellow}r) ${white}Reload Moonraker and Nginx                             | \n"
    printf " |  ${yellow}u) ${white}Check Script Updates                                   | \n"
    printf " |  ${red}q) ${white}Exit                                                   | \n"
    printf " |                                                            | \n"
    printf " |                                                     ${cyan}$VERSION ${white}| \n"
    printf " ============================================================== \n"
    printf "\n"
    printf " ${white}Please enter your choice and validate with Enter: ${yellow}"
    read -rp "" opt_main_menu
    opt_main_menu=$(echo "$opt_main_menu" | tr '[:lower:]' '[:upper:]')
    printf "${white}\n"
}

install_menu(){
    printf " ============================================================== \n"
    printf " |     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~     | \n"
    printf " |         ${blue}Installation Helper for Creality K1 Series         ${white}| \n"
    printf " |            ${cyan}Copyright © Cyril Guislain (Guilouz)            ${white}| \n"
    printf " |     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~     | \n"
    printf " [============================================================] \n"
    printf " |                     ${yellow}[ Install Menu ]                       ${white}| \n"
    printf " [============================================================] \n"
    printf " |                                                            | \n"
    printf " | ${blue}Essentials:                                                ${white}| \n"
    printf " |   ${yellow}1) ${white}Install ${green}Moonraker ${white}and ${green}Nginx                           ${white}| \n"
    printf " |   ${yellow}2) ${white}Install ${green}Fluidd ${white}(port 4408)                            | \n"
    printf " |   ${yellow}3) ${white}Install ${green}Mainsail ${white}(port 4409)                          | \n"
    printf " |                                                            | \n"
    printf " | ${blue}Utilities:                                                 ${white}| \n"
    printf " |   ${yellow}4) ${white}Install ${green}Entware                                       ${white}| \n"
    printf " |   ${yellow}5) ${white}Install ${green}Klipper Gcode Shell Command ${white}file              | \n"
    printf " |   ${yellow}6) ${white}Install ${green}Hostname Service ${white}file                         | \n"
    printf " |   ${yellow}7) ${white}Install ${green}Fix for Reboot/Shutdown functions ${white}            | \n"
    printf " |                                                            | \n"
    printf " | ${blue}Improvements:                                              ${white}| \n"
    printf " |   ${yellow}8) ${white}Install ${green}Klipper Adaptive Meshing & Purging            ${white}| \n"
    printf " |   ${yellow}9) ${white}Install ${green}Buzzer Support ${white}files                          | \n"
    printf " |  ${yellow}10) ${white}Install ${green}Nozzle Cleaning Fan Control ${white}files             | \n"
    printf " |                                                            | \n"
    printf " | ${blue}Camera:                                                    ${white}| \n"
    printf " |  ${yellow}11) ${white}Install ${green}Moonraker Timelapse                           ${white}| \n"
    printf " |  ${yellow}12) ${white}Install ${green}Camera Settings Control ${white}files                 | \n"
    printf " |                                                            | \n"
    printf " | ${blue}Remote Access and AI Detection:                            ${white}| \n"
    printf " |  ${yellow}13) ${white}Install ${green}OctoEverywhere                                ${white}| \n"
    printf " |  ${yellow}14) ${white}Install ${green}Obico                                         ${white}| \n"
    printf " |  ${yellow}15) ${white}Install ${green}Mobileraker Companion                         ${white}| \n"
    printf " |                                                            | \n"
    printf " ============================================================== \n"
    printf " |                                                            | \n"
    printf " |  ${yellow}b) ${white}Back to ${yellow}[Main Menu]                                    ${white}| \n"
    printf " |  ${red}q) ${white}Exit                                                   | \n"
    printf " |                                                            | \n"
    printf " |                                                     ${cyan}$VERSION ${white}| \n"
    printf " ============================================================== \n"
    printf "\n"
    printf " ${white}Please enter your choice and validate with Enter: ${yellow}"
    read -rp "" opt_install_menu
    opt_install_menu=$(echo "$opt_install_menu" | tr '[:lower:]' '[:upper:]')
    printf "${white}\n"
}

uninstall_menu(){
    printf " ============================================================== \n"
    printf " |     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~     | \n"
    printf " |         ${blue}Installation Helper for Creality K1 Series         ${white}| \n"
    printf " |            ${cyan}Copyright © Cyril Guislain (Guilouz)            ${white}| \n"
    printf " |     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~     | \n"
    printf " [============================================================] \n"
    printf " |                     ${yellow}[ Remove Menu ]                        ${white}| \n"
    printf " [============================================================] \n"
    printf " |                                                            | \n"
    printf " | ${blue}Essentials:                                                ${white}| \n"
    printf " |   ${yellow}1) ${white}Remove ${green}Moonraker ${white}and ${green}Nginx                            ${white}| \n"
    printf " |   ${yellow}2) ${white}Remove ${green}Fluidd ${white}(port 4408)                             | \n"
    printf " |   ${yellow}3) ${white}Remove ${green}Mainsail ${white}(port 4409)                           | \n"
    printf " |                                                            | \n"
    printf " | ${blue}Utilities:                                                 ${white}| \n"
    printf " |   ${yellow}4) ${white}Remove ${green}Entware                                        ${white}| \n"
    printf " |   ${yellow}5) ${white}Remove ${green}Klipper Gcode Shell Command ${white}file               | \n"
    printf " |   ${yellow}6) ${white}Remove ${green}Hostname Service ${white}file                          | \n"
    printf " |   ${yellow}7) ${white}Remove ${green}Fix for Reboot/Shutdown functions ${white}             | \n"
    printf " |                                                            | \n"
    printf " | ${blue}Improvements:                                              ${white}| \n"
    printf " |   ${yellow}8) ${white}Remove ${green}Klipper Adaptive Meshing & Purging             ${white}| \n"
    printf " |   ${yellow}9) ${white}Remove ${green}Buzzer Support ${white}files                           | \n"
    printf " |  ${yellow}10) ${white}Remove ${green}Nozzle Cleaning Fan Control ${white}files              | \n"
    printf " |                                                            | \n"
    printf " | ${blue}Camera:                                                    ${white}| \n"
    printf " |  ${yellow}11) ${white}Remove ${green}Moonraker Timelapse                            ${white}| \n"
    printf " |  ${yellow}12) ${white}Remove ${green}Camera Settings Control ${white}files                  | \n"
    printf " |                                                            | \n"
    printf " | ${blue}Remote Access and AI Detection:                            ${white}| \n"
    printf " |  ${yellow}13) ${white}Remove ${green}OctoEverywhere                                 ${white}| \n"
    printf " |  ${yellow}14) ${white}Remove ${green}Obico                                          ${white}| \n"
    printf " |  ${yellow}15) ${white}Remove ${green}Mobileraker Companion                          ${white}| \n"
    printf " |                                                            | \n"
    printf " ============================================================== \n"
    printf " |                                                            | \n"
    printf " |  ${yellow}b) ${white}Back to ${yellow}[Main Menu]                                    ${white}| \n"
    printf " |  ${red}q) ${white}Exit                                                   | \n"
    printf " |                                                            | \n"
    printf " |                                                     ${cyan}$VERSION ${white}| \n"
    printf " ============================================================== \n"
    printf "\n"
    printf " ${white}Please enter your choice and validate with Enter: ${yellow}"
    read -rp "" opt_uninstall_menu
    opt_uninstall_menu=$(echo "$opt_uninstall_menu" | tr '[:lower:]' '[:upper:]')
    printf "${white}\n"
}

backup_menu(){
    printf " ============================================================== \n"
    printf " |     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~     | \n"
    printf " |         ${blue}Installation Helper for Creality K1 Series         ${white}| \n"
    printf " |            ${cyan}Copyright © Cyril Guislain (Guilouz)            ${white}| \n"
    printf " |     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~     | \n"
    printf " [============================================================] \n"
    printf " |                ${yellow}[ Backup & Restore Menu ]                   ${white}| \n"
    printf " [============================================================] \n"
    printf " |                                                            | \n"
    printf " |  ${yellow}1) ${green}Backup ${white}configuration files                             | \n"
    printf " |  ${yellow}2) ${green}Restore ${white}configuration files                            | \n"
    printf " |                                                            | \n"
    printf " ============================================================== \n"
    printf " |                                                            | \n"
    printf " |  ${yellow}b) ${white}Back to ${yellow}[Main Menu]                                    ${white}| \n"
    printf " |  ${red}q) ${white}Exit                                                   | \n"
    printf " |                                                            | \n"
    printf " |                                                     ${cyan}$VERSION ${white}| \n"
    printf " ============================================================== \n"
    printf "\n"
    printf " ${white}Please enter your choice and validate with Enter: ${yellow}"
    read -rp "" opt_backup_menu
    opt_backup_menu=$(echo "$opt_backup_menu" | tr '[:lower:]' '[:upper:]')
    printf "${white}\n"
}

customize_menu(){
    printf " ============================================================== \n"
    printf " |     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~     | \n"
    printf " |         ${blue}Installation Helper for Creality K1 Series         ${white}| \n"
    printf " |            ${cyan}Copyright © Cyril Guislain (Guilouz)            ${white}| \n"
    printf " |     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~     | \n"
    printf " [============================================================] \n"
    printf " |                    ${yellow}[ Customize Menu ]                      ${white}| \n"
    printf " [============================================================] \n"
    printf " |                                                            | \n"
    printf " |  ${yellow}1) ${white}Install ${green}Custom Boot Display                            ${white}| \n"
    printf " |  ${yellow}2) ${white}Remove ${green}Custom Boot Display                             ${white}| \n"
    printf " |                                                            | \n"
    printf " |  ${yellow}3) ${white}Remove ${green}Creality Web Interface                          ${white}| \n"
    printf " |  ${yellow}4) ${white}Restore ${green}Creality Web Interface                         ${white}| \n"
    printf " |                                                            | \n"
    printf " ============================================================== \n"
    printf " |                                                            | \n"
    printf " |  ${yellow}b) ${white}Back to ${yellow}[Main Menu]                                    ${white}| \n"
    printf " |  ${red}q) ${white}Exit                                                   | \n"
    printf " |                                                            | \n"
    printf " |                                                     ${cyan}$VERSION ${white}| \n"
    printf " ============================================================== \n"
    printf "\n"
    printf " ${white}Please enter your choice and validate with Enter: ${yellow}"
    read -rp "" opt_customize_menu
    opt_customize_menu=$(echo "$opt_customize_menu" | tr '[:lower:]' '[:upper:]')
    printf "${white}\n"
}

info_menu(){
    printf " ============================================================== \n"
    printf " |     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~     | \n"
    printf " |         ${blue}Installation Helper for Creality K1 Series         ${white}| \n"
    printf " |            ${cyan}Copyright © Cyril Guislain (Guilouz)            ${white}| \n"
    printf " |     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~     | \n"
    printf " [============================================================] \n"
    printf " |                  ${yellow}[ Informations Menu ]                     ${white}| \n"
    printf " [============================================================] \n"
    printf "\n"
    printf "  ${blue}Essentials: ${white}\n"
    printf "    ${white}Moonraker & Nginx → $(check_folder "$moonraker_folder")\n"
    printf "    ${white}Fluidd → $(check_folder "$fluidd_folder")\n"
    printf "    ${white}Mainsail → $(check_folder "$mainsail_folder")\n"
    printf "\n"
    printf "  ${blue}Utilities: ${white}\n"
    printf "    ${white}Entware → $(check_folder "$entware_folder")\n"
    printf "    ${white}Klipper Gcode Shell Command → $(check_file "$shellcommand_file")\n"
    printf "    ${white}Hostname Service → $(check_file "$hostname_file")\n"
    printf "    ${white}Fix for ${yellow}Reboot${white}/Shutdown functions → $(check_file "$systemctl_file")\n"
    printf "\n"
    printf "  ${blue}Improvements: ${white}\n"
    printf "    ${white}Klipper Adaptive Meshing & Purging → $(check_folder "$kamp_folder")\n"
    printf "    ${white}Buzzer Support → $(check_file "$buzzer_file")\n"
    printf "    ${white}Nozzle Cleaning Fan Control → $(check_folder "$prtouch_folder")\n"
    printf "\n"
    printf "  ${blue}Camera: ${white}\n"
    printf "    ${white}Moonraker Timelapse → $(check_file "$timelapse_file")\n"
    printf "    ${white}Camera Settings Control → $(check_file "$camera_file")\n"
    printf "\n"
    printf "  ${blue}Remote Access and AI Detection: ${white}\n"
    printf "    ${white}OctoEverywhere → $(check_folder "$octoeverywhere_folder")\n"
    printf "    ${white}Obico → $(check_folder "$moonraker_obico_folder")\n"
    printf "    ${white}Mobileraker Companion → $(check_folder "$mobileraker_folder")\n"
    printf "\n"
    printf "  ${blue}Customization: ${white}\n"
    printf "    ${white}Custom Boot Display → $(check_file "$bootdisplay_file")\n"
    printf "    ${white}Creality Web Interface → $(check_crealityweb "$crealityweb_file")\n"
    printf "\n"
    printf " ============================================================== \n"
    printf " |                                                            | \n"
    printf " |  ${yellow}b) ${white}Back to ${yellow}[Main Menu]                                    ${white}| \n"
    printf " |  ${red}q) ${white}Exit                                                   | \n"
    printf " |                                                            | \n"
    printf " |                                                     ${cyan}$VERSION ${white}| \n"
    printf " ============================================================== \n"
    printf "\n"
    printf " ${white}Please enter your choice and validate with Enter: ${yellow}"
    read -rp "" opt_info_menu
    opt_info_menu=$(echo "$opt_info_menu" | tr '[:lower:]' '[:upper:]')
    printf "${white}\n"
}

system_menu(){
    memfree=`cat /proc/meminfo | grep MemFree | awk {'print $2'}`
    memtotal=`cat /proc/meminfo | grep MemTotal | awk {'print $2'}`
    pourcent=$((($memfree * 100)/$memtotal))
    diskused=`df -h | grep /dev/mmcblk0p10 | awk {'print $3 " / " $2 " (" $4 " available)" '}`
    process=`ps ax | wc -l | tr -d " "`
    uptime=`cat /proc/uptime | cut -f1 -d.`
    upDays=$((uptime/60/60/24))
    upHours=$((uptime/60/60%24))
    upMins=$((uptime/60%60))
    load=`cat /proc/loadavg | awk {'print $1 " (1 min.) / " $2 " (5 min.) / " $3 " (15 min.)"'}`
    printf " ============================================================== \n"
    printf " |     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~     | \n"
    printf " |         ${blue}Installation Helper for Creality K1 Series         ${white}| \n"
    printf " |            ${cyan}Copyright © Cyril Guislain (Guilouz)            ${white}| \n"
    printf " |     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~     | \n"
    printf " [============================================================] \n"
    printf " |                      ${yellow}[ System Menu ]                       ${white}| \n"
    printf " [============================================================] \n"
    printf "                                                                \n"
    printf "        ${green}System: ${white}\e[97m$(uname -s) (Kernel $(uname -r)) \n"
    printf "      ${green}Hostname: ${white}\e[97m$(uname -n) \n"
    printf "    ${green}IP Address: ${white}\e[97m$(check_connection) \n"
    printf "     ${green}RAM Usage: ${white}\e[97m$(($memfree/1024)) MB / $(($memtotal/1024)) MB ($pourcent%% available) \n"
    printf "    ${green}Disk Usage: ${white}\e[97m$diskused \n"
    printf "        ${green}Uptime: ${white}\e[97m$upDays days $upHours hours $upMins minutes \n"
    printf "     ${green}Processes: ${white}\e[97m$process running process \n"
    printf "   ${green}System Load: ${white}\e[97m$load \n"
    printf "                                                                \n"
    printf " ============================================================== \n"
    printf " |                                                            | \n"
    printf " |  ${yellow}b) ${white}Back to ${yellow}[Main Menu]                                    ${white}| \n"
    printf " |  ${red}q) ${white}Exit                                                   | \n"
    printf " |                                                            | \n"
    printf " |                                                     ${cyan}$VERSION ${white}| \n"
    printf " ============================================================== \n"
    printf "\n"
    printf " ${white}Please enter your choice and validate with Enter: ${yellow}"
    read -rp "" opt_system_menu
    opt_system_menu=$(echo "$opt_system_menu" | tr '[:lower:]' '[:upper:]')
    printf "${white}\n"
}

while [ 1 ]
do
    main_menu
    case $opt_main_menu in
        1)
            while [ 1 ]
            do
                install_menu
                case $opt_install_menu in
                    1)
            			if [ -d "$moonraker_folder" ]; then
            				printf "${darkred} Moonraker and Nginx are already installed!"
            				printf "${white}\n\n"
            			else
            			    printf " Are you sure you want to install ${green}Moonraker and Nginx ${white}? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
            			    read confirm
            			    printf "${white}\n"
            			    while [ "$confirm" != "y" ] && [ "$confirm" != "Y" ] && [ "$confirm" != "n" ] && [ "$confirm" != "N" ]; do
                                printf "${darkred} Please select a correct choice!"
                                printf "${white}\n\n"
                                printf " Are you sure you want to install ${green}Moonraker and Nginx ${white}? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
                                read confirm
                                printf "${white}\n"
                            done
            			    if [ "$confirm" = "y" -o "$confirm" = "Y" ]; then
                			    printf "${green} Installing Moonraker and Nginx..."
                			    printf "${white}\n\n"
                			    cd /usr/data
                			    if [ -f "moonraker.tar" ]; then
                			        rm -f moonraker.tar
                			    fi
                			    printf "Downloading Moonraker and Nginx file...\n"
                			    wget --no-check-certificate "$moonraker_URL"
                			    if [ $? -eq 0 ]; then
                			        printf "Installing files...\n"
                			        tar -xvf moonraker.tar
                			        [ ! -e /etc/init.d/S50nginx ] && cp nginx/S50nginx /etc/init.d/
                			        [ ! -e /etc/init.d/S56moonraker_service ] && cp moonraker/S56moonraker_service /etc/init.d/
                			        printf "Deleting file...\n"
                			        rm -f moonraker.tar
                			        printf "Downloading Moonraker configuration file...\n"
                    			    wget --no-check-certificate "$moonraker_config_URL"
                    			    printf "Copying file...\n"
                    			    mv moonraker.conf /usr/data/printer_data/config/moonraker.conf
                			        cd /usr/data/moonraker/moonraker
                			        printf "Applying changes...\n"
                			        git stash; git checkout master; git pull
                			        printf "Restarting services...\n"
                			        /etc/init.d/S50nginx start
                			        sleep 1
                			        /etc/init.d/S56moonraker_service start
                			        sleep 1
                			        printf "\n"
                			        printf "${green} Moonraker and Nginx have been installed successfully!"
                			        printf "${white}\n\n"
                			    else
                			        printf "${darkred} Download failed. Exit code: $?"
                			        printf "${white}\n\n"
                			    fi
                			elif [ "$confirm" = "n" -o "$confirm" = "N" ]; then
                			    printf "${darkred} Installation canceled!"
                			    printf "${white}\n\n"
            			    fi
            			fi
                        ;;
                    2)
            			if [ -d "$fluidd_folder" ]; then
            				printf "${darkred} Fluidd is already installed!"
            				printf "${white}\n\n"
            			elif [ ! -d "$moonraker_folder" ]; then
            				printf "${darkred} Please install Moonraker and Nginx first!"
            				printf "${white}\n\n"
            			else
            			    printf " Are you sure you want to install ${green}Fluidd ${white}? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
            			    read confirm
            			    printf "${white}\n"
            			    while [ "$confirm" != "y" ] && [ "$confirm" != "Y" ] && [ "$confirm" != "n" ] && [ "$confirm" != "N" ]; do
                                printf "${darkred} Please select a correct choice!"
                                printf "${white}\n\n"
                                printf " Are you sure you want to install ${green}Fluidd ${white}? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
                                read confirm
                                printf "${white}\n"
                            done
            			    if [ "$confirm" = "y" -o "$confirm" = "Y" ]; then
                			    printf "${green} Installing Fluidd..."
                			    printf "${white}\n\n"
	            			    cd /usr/data
	            			    if [ -f "fluidd.zip" ]; then
                			        rm -f fluidd.zip
                			    fi
                			    printf "Downloading Fluidd file...\n"
	            			    wget --no-check-certificate "$fluidd_URL"
	            			    if [ $? -eq 0 ]; then
	            			        printf "Copying files...\n"
	            			        mkdir /usr/data/fluidd
	            			        mv fluidd.zip fluidd
                			        cd /usr/data/fluidd
                			        unzip fluidd.zip
                			        printf "Deleting file...\n"
                			        rm -f fluidd.zip
                			        printf "Downloading Moonraker configuration file...\n"
                    			    wget --no-check-certificate "$moonraker_config_URL"
                    			    printf "Copying file...\n"
                    			    mv moonraker.conf /usr/data/printer_data/config/moonraker.conf
                			        printf "Restarting services...\n"
                			        /etc/init.d/S50nginx restart
                			        sleep 1
                			        /etc/init.d/S56moonraker_service restart
                			        sleep 1
                			        printf "\n"
                			        printf "${green} Fluidd has been installed successfully!"
                			        printf "${white}\n\n"
                			        printf " You can now connect to Fluidd Web Interface with ${yellow}http://$(check_ipaddress):4408"
                			        printf "${white}\n\n"
                			    else
                			        printf "${darkred} Download failed. Exit code: $?"
                			        printf "${white}\n\n"
                			    fi
                			elif [ "$confirm" = "n" -o "$confirm" = "N" ]; then
                			    printf "${darkred} Installation canceled!"
                			    printf "${white}\n\n"
            			    fi
            			fi
                        ;;
                    3)
            			if [ -d "$mainsail_folder" ]; then
            				printf "${darkred} Mainsail is already installed!"
            				printf "${white}\n\n"
            			elif [ ! -d "$moonraker_folder" ]; then
            				printf "${darkred} Please install Moonraker and Nginx first!"
            				printf "${white}\n\n"
            			else
            			    printf " Are you sure you want to install ${green}Mainsail ${white}? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
            			    read confirm
            			    printf "${white}\n"
            			    while [ "$confirm" != "y" ] && [ "$confirm" != "Y" ] && [ "$confirm" != "n" ] && [ "$confirm" != "N" ]; do
                                printf "${darkred} Please select a correct choice!"
                                printf "${white}\n\n"
                                printf " Are you sure you want to install ${green}Mainsail ${white}? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
                                read confirm
                                printf "${white}\n"
                            done
            			    if [ "$confirm" = "y" -o "$confirm" = "Y" ]; then
                			    printf "${green} Installing Mainsail..."
                			    printf "${white}\n\n"
                			    cd /usr/data
                			    if [ -f "mainsail.zip" ]; then
                			        rm -f mainsail.zip
                			    fi
                			    printf "Downloading Mainsail file...\n"
                			    wget --no-check-certificate "$mainsail_URL"
	            			    if [ $? -eq 0 ]; then
	            			        printf "Copying files...\n"
	            			        mkdir /usr/data/mainsail
	            			        mv mainsail.zip mainsail
                			        cd /usr/data/mainsail
                			        unzip mainsail.zip
                			        printf "Deleting file...\n"
                			        rm -f mainsail.zip
                			        printf "Downloading Moonraker configuration file...\n"
                			        wget --no-check-certificate "$moonraker_config_URL"
                    			    printf "Copying file...\n"
                    			    mv moonraker.conf /usr/data/printer_data/config/moonraker.conf
                			        printf "Restarting services...\n"
                			        /etc/init.d/S50nginx restart
                			        sleep 1
                			        /etc/init.d/S56moonraker_service restart
                			        sleep 1
                			        printf "\n"
                			        printf "${green} Mainsail has been installed successfully!"
                			        printf "${white}\n\n"
                			        printf " You can now connect to Mainsail Web Interface with ${yellow}http://$(check_ipaddress):4409"
                			        printf "${white}\n\n"
                			    else
                			        printf "${darkred} Download failed. Exit code: $?"
                			        printf "${white}\n\n"
                			    fi
                			elif [ "$confirm" = "n" -o "$confirm" = "N" ]; then
                			    printf "${darkred} Installation canceled!"
                			    printf "${white}\n\n"
            			    fi
            			fi
                        ;;
                    4)
                        printf " Are you sure you want to install ${green}Entware ${white}? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
            			read confirm
            			printf "${white}\n"
            			while [ "$confirm" != "y" ] && [ "$confirm" != "Y" ] && [ "$confirm" != "n" ] && [ "$confirm" != "N" ]; do
                            printf "${darkred} Please select a correct choice!"
                            printf "${white}\n\n"
                            printf " Are you sure you want to install ${green}Entware ${white}? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
                            read confirm
                            printf "${white}\n"
                        done
            			if [ "$confirm" = "y" -o "$confirm" = "Y" ]; then
                            printf "${green} Installing Entware..."
                            printf "${white}\n\n"
            			    echo "Making /opt directory on data partition where there is space, and adding a symbolic link..."
            			    rm -rf /opt /usr/data/opt
            			    mkdir /usr/data/opt
            			    ln -nsf /usr/data/opt /opt
            			    echo "Installing Entware using generic installer script..."
            			    wget --no-check-certificate -O - http://bin.entware.net/mipselsf-k3.4/installer/generic.sh | /bin/sh
            			    echo "Adding /opt/bin and /opt/sbin to the start of the PATH in the system profile..."
            			    echo 'export PATH="/opt/bin:/opt/sbin:$PATH"' > /etc/profile.d/entware.sh
            			    echo "Adding startup script..."
            			    echo -e '#!/bin/sh\n/opt/etc/init.d/rc.unslung "$1"' > /etc/init.d/S50unslung
            			    chmod 755 /etc/init.d/S50unslung
            			    printf "\n"
            			    printf "${green} Entware has been installed successfully!"
            			    printf "${white}\n\n"
            			    printf " Log out and log back in, and you can now install packages with: ${yellow}opkg install <packagename>"
            			    printf "${white}\n\n"
            			elif [ "$confirm" = "n" -o "$confirm" = "N" ]; then
                			printf "${darkred} Installation canceled!"
                			printf "${white}\n\n"
            			fi
                        ;;
                    5)
            			if [ -f "$shellcommand_file" ]; then
            				printf "${darkred} Klipper Gcode Shell Command file is already installed!"
            				printf "${white}\n\n"
            			else
            			    printf " Are you sure you want to install ${green}Klipper Gcode Shell Command ${white}file ? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
            			    read confirm
            			    printf "${white}\n"
            			    while [ "$confirm" != "y" ] && [ "$confirm" != "Y" ] && [ "$confirm" != "n" ] && [ "$confirm" != "N" ]; do
                                printf "${darkred} Please select a correct choice!"
                                printf "${white}\n\n"
                                printf " Are you sure you want to install ${green}Klipper Gcode Shell Command ${white}file ? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
                                read confirm
                                printf "${white}\n"
                            done
            			    if [ "$confirm" = "y" -o "$confirm" = "Y" ]; then
            			        printf "${green} Installing Klipper Gcode Shell Command file..."
            			        printf "${white}\n\n"
                			    printf "Downloading Klipper Gcode Shell Command file...\n"
                			    wget --no-check-certificate -P /usr/share/klipper/klippy/extras/ "$shellcommand_URL"
                			    printf "\n"
                			    printf "${green} Klipper Gcode Shell Command file has been installed successfully!"
                			    printf "${white}\n\n"
                			elif [ "$confirm" = "n" -o "$confirm" = "N" ]; then
                			    printf "${darkred} Installation canceled!"
                			    printf "${white}\n\n"
            			    fi
            			fi
                        ;;
                    6)
            			if [ -f "$hostname_file" ]; then
            				printf "${darkred} Hotsname Service file is already installed!"
            				printf "${white}\n\n"
            			else
            			    printf " Are you sure you want to install ${green}Hotsname Service ${white}file ? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
            			    read confirm
            			    printf "${white}\n"
            			    while [ "$confirm" != "y" ] && [ "$confirm" != "Y" ] && [ "$confirm" != "n" ] && [ "$confirm" != "N" ]; do
                                printf "${darkred} Please select a correct choice!"
                                printf "${white}\n\n"
                                printf " Are you sure you want to install ${green}Hotsname Service ${white}file ? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
                                read confirm
                                printf "${white}\n"
                            done
            			    if [ "$confirm" = "y" -o "$confirm" = "Y" ]; then
                			    printf "${green} Installing Hotsname Service file..."
                			    printf "${white}\n\n"
                			    cd /etc/init.d/
                			    printf "Downloading Hotsname Service file...\n"
                			    wget --no-check-certificate "$hostname_URL"
                			    printf "Applying permissions...\n"
                			    chmod 755 S01hostname
                			    printf "\n"
                			    printf "${green} Hotsname Service file has been installed successfully!"
                			    printf "${white}\n\n"
                			elif [ "$confirm" = "n" -o "$confirm" = "N" ]; then
                			    printf "${darkred} Installation canceled!"
                			    printf "${white}\n\n"
            			    fi
            			fi
                        ;;
                    7)
            			if [ -f "$systemctl_file" ]; then
            				printf "${darkred} Fix for Reboot/Shutdown functions is already installed!"
            				printf "${white}\n\n"
            			elif [ ! -d "$entware_folder" ]; then
            				printf "${darkred} Please install Entware first!"
            				printf "${white}\n\n"
            			else
            			    printf " Are you sure you want to install ${green}Fix for Reboot/Shutdown functions ${white}? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
            			    read confirm
            			    printf "${white}\n"
            			    while [ "$confirm" != "y" ] && [ "$confirm" != "Y" ] && [ "$confirm" != "n" ] && [ "$confirm" != "N" ]; do
                                printf "${darkred} Please select a correct choice!"
                                printf "${white}\n\n"
                                printf " Are you sure you want to install ${green}Fix for Reboot/Shutdown functions ${white}? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
                                read confirm
                                printf "${white}\n"
                            done
            			    if [ "$confirm" = "y" -o "$confirm" = "Y" ]; then
                			    printf "${green} Installing Fix for Reboot/Shutdown functions..."
                			    printf "${white}\n\n"
								opkg install sudo
								printf "Downloading systemctl file...\n"
								wget --no-check-certificate -P /usr/bin/ "$systemctl_URL"
								printf "Applying permissions...\n"
                			    chmod 755 /usr/bin/systemctl
                			    printf "Linking file...\n"
                			    ln -s /opt/bin/sudo /usr/bin/sudo
                			    printf "\n"
                			    printf "${green} Fix for Reboot/Shutdown functions has been installed successfully!"
                			    printf "${white}\n\n"
                			elif [ "$confirm" = "n" -o "$confirm" = "N" ]; then
                			    printf "${darkred} Installation canceled!"
                			    printf "${white}\n\n"
            			    fi
            			fi
                        ;;
                    8)
            			if [ -d "$kamp_folder" ]; then
            				printf "${darkred} Klipper Adaptive Meshing & Purging is already installed!"
            				printf "${white}\n\n"
            			else
            			    printf " Are you sure you want to install ${green}Klipper Adaptive Meshing & Purging ${white}? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
            			    read confirm
            			    printf "${white}\n"
            			    while [ "$confirm" != "y" ] && [ "$confirm" != "Y" ] && [ "$confirm" != "n" ] && [ "$confirm" != "N" ]; do
                                printf "${darkred} Please select a correct choice!"
                                printf "${white}\n\n"
                                rintf " Are you sure you want to install ${green}Klipper Adaptive Meshing & Purging ${white}? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
                                read confirm
                                printf "${white}\n"
                            done
            			    if [ "$confirm" = "y" -o "$confirm" = "Y" ]; then
                			    printf "${green} Installing Klipper Adaptive Meshing & Purging..."
                			    printf "${white}\n\n"
                			    cd /usr/data
                			    printf "Cloning repository...\n"
                			    git clone "$kamp_URL"
                			    rm -rf printer_data/config/KAMP printer_data/config/KAMP_Settings.cfg
                			    printf "Linking files...\n"
                			    ln -s ../../KAMP-for-K1-Series/Configuration printer_data/config/KAMP
                			    printf "Moving file...\n"
                			    cp KAMP-for-K1-Series/Configuration/KAMP_Settings.cfg printer_data/config/KAMP_Settings.cfg
                			    printf "Restarting services...\n"
                			    /etc/init.d/S55klipper_service restart
                			    printf "\n"
                			    printf "${green} Klipper Adaptive Meshing & Purging has been installed successfully!"
                			    printf "${white}\n\n"
                			    printf " Don't miss to enable ${yellow}enable_object_processing: True ${white}in moonraker.conf file."
                			    printf "${white}\n\n"
                			    printf " And add this in printer.cfg file:"
                			    printf "${white}\n\n"
                			    printf "${yellow} [include KAMP_Settings.cfg]"
                			    printf "${white}\n\n"
                			elif [ "$confirm" = "n" -o "$confirm" = "N" ]; then
                			    printf "${darkred} Installation canceled!"
                			    printf "${white}\n\n"
            			    fi
            			fi
                        ;;
                    9)
            			if [ -f "$buzzer_file" ]; then
            				printf "${darkred} Buzzer support files are already installed!"
            				printf "${white}\n\n"
            			elif [ ! -f "$shellcommand_file" ]; then
            				printf " ${darkred}Please install Klipper Gcode Shell Command file first!"
            				printf "${white}\n\n"
            			else
            			    printf " Are you sure you want to install ${green}Buzzer Support ${white}files ? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
            			    read confirm
            			    printf "${white}\n"
            			    while [ "$confirm" != "y" ] && [ "$confirm" != "Y" ] && [ "$confirm" != "n" ] && [ "$confirm" != "N" ]; do
                                printf "${darkred} Please select a correct choice!"
                                printf "${white}\n\n"
                                printf " Are you sure you want to install ${green}Buzzer Support ${white}files ? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
                                read confirm
                                printf "${white}\n"
                            done
            			    if [ "$confirm" = "y" -o "$confirm" = "Y" ]; then
                			    printf "${green} Installing Buzzer Support files..."
                			    printf "${white}\n\n"
                			    if [ ! -f "$buzzer_file" ]; then
                			        printf "Downloading Buzzer support file...\n"
                			        wget --no-check-certificate -P /usr/data/ "$buzzer_URL"
                			    fi
                			    printf "Restarting services...\n"
                			    /etc/init.d/S55klipper_service restart
                			    printf "\n"
                			    printf " ${green}Buzzer Support files have been installed successfully!"
                			    printf "${white}\n\n"
                			    printf " Don't miss to add this in gcode_macro.cfg file:"
                			    printf "${white}\n\n"
                			    printf "${yellow} [gcode_shell_command beep] \n"
                			    printf "${yellow} command: aplay /usr/data/beep.mp3 \n"
                			    printf "${yellow} timeout: 2. \n"
                			    printf "${yellow} verbose: False"
                			    printf "\n\n"
                			    printf "${yellow} [gcode_macro BEEP] \n"
                			    printf "${yellow} gcode: \n"
                			    printf "${yellow} RUN_SHELL_COMMAND CMD=beep \n"
                			    printf "${yellow} RUN_SHELL_COMMAND CMD=beep \n"
                			    printf "${yellow} RUN_SHELL_COMMAND CMD=beep"
                			    printf "${white}\n\n"
                			elif [ "$confirm" = "n" -o "$confirm" = "N" ]; then
                			    printf "${darkred} Installation canceled!"
                			    printf "${white}\n\n"
            			    fi
            			fi
                        ;;
                    10)
            			if [ -d "$prtouch_folder" ]; then
            				printf "${darkred} Nozzle Cleaning Fan Control files are already installed!"
            				 printf "${white}\n\n"
            			else
            			    printf " Are you sure you want to install ${green}Nozzle Cleaning Fan Control ${white}files ? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
            			    read confirm
            			    printf "${white}\n"
            			    while [ "$confirm" != "y" ] && [ "$confirm" != "Y" ] && [ "$confirm" != "n" ] && [ "$confirm" != "N" ]; do
                                printf "${darkred} Please select a correct choice!"
                                printf "${white}\n\n"
                                printf " Are you sure you want to install ${green}Nozzle Cleaning Fan Control ${white}files ? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
                                read confirm
                                printf "${white}\n"
                            done
            			    if [ "$confirm" = "y" -o "$confirm" = "Y" ]; then
                			    printf "${green} Installing Nozzle Cleaning Fan Control files..."
                			    printf "${white}\n\n"
                			    mkdir -p /usr/share/klipper/klippy/extras/prtouch_v2_fan
                			    printf "Downloading Nozzle Cleaning Fan Control files... \n"
                			    wget --no-check-certificate "$prtouch_URL1" -O /usr/share/klipper/klippy/extras/prtouch_v2_fan/__init__.py
                			    wget --no-check-certificate "$prtouch_URL2" -O /usr/share/klipper/klippy/extras/prtouch_v2_fan/prtouch_v2_fan.pyc
                			    printf "Restarting services...\n"
                                /etc/init.d/S55klipper_service restart
                                printf "\n"
                			    printf "${green} Nozzle Cleaning Fan Control files have been installed successfully!"
                			    printf "${white}\n\n"
                			    printf " Don't miss to add this in printer_params.cfg file:"
                			    printf "${white}\n\n"
                			    printf "${yellow} [prtouch_v2_fan] \n"
                			    printf "${yellow} max_speed: 0.5"
                			    printf "${white}\n\n"
                			elif [ "$confirm" = "n" -o "$confirm" = "N" ]; then
                			    printf " ${darkred}Installation canceled! ${white}\n\n"
            			    fi
            			fi
                        ;;
                    11)
            			if [ -f "$timelapse_file" ]; then
            				printf "${darkred} Moonraker Timelapse is already installed!"
            				printf "${white}\n\n"
            			else
            			    printf " Are you sure you want to install ${green}Moonraker Timelapse ${white}? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
            			    read confirm
            			    printf "${white}\n"
            			    while [ "$confirm" != "y" ] && [ "$confirm" != "Y" ] && [ "$confirm" != "n" ] && [ "$confirm" != "N" ]; do
                                printf "${darkred} Please select a correct choice!"
                                printf "${white}\n\n"
                                printf " Are you sure you want to install ${green}Moonraker Timelapse ${white}? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
                                read confirm
                                printf "${white}\n"
                            done
            			    if [ "$confirm" = "y" -o "$confirm" = "Y" ]; then
            			        printf "${green} Installing Moonraker Timelapse..."
            			        printf "${white}\n\n"
                			    cd /usr/data
                			    printf "Downloading Moonraker Timelapse files...\n"
                			    wget --no-check-certificate "$timelapse_URL1"
                			    wget --no-check-certificate "$timelapse_URL2"
                			    printf "Copying files...\n"
                			    mv timelapse.py moonraker/moonraker/moonraker/components/
                			    mv timelapse.cfg printer_data/config/
                			    printf "Restarting services...\n"
                			    /etc/init.d/S55klipper_service restart
                			    printf "\n"
                			    printf "${green} Moonraker Timelapse has been installed successfully!"
                			    printf "${white}\n\n"
                			    printf " Don't miss to enable ${yellow}[timelapse] ${white}function in moonraker.conf file."
                			    printf "${white}\n\n"
                			elif [ "$confirm" = "n" -o "$confirm" = "N" ]; then
                			    printf "${darkred} Installation canceled!"
                			    printf "${white}\n\n"
            			    fi
            			fi
                        ;;
                    12)
            			if [ -f "$camera_file" ]; then
            				printf "${darkred} Camera Settings Control files are already installed!"
            				 printf "${white}\n\n"
            			elif [ ! -f "$shellcommand_file" ]; then
            				printf " ${darkred}Please install Klipper Gcode Shell Command file first!"
            				 printf "${white}\n\n"
            			else
            			    printf " Are you sure you want to install ${green}Camera Settings Control ${white}files ? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
            			    read confirm
            			    printf "${white}\n"
            			    while [ "$confirm" != "y" ] && [ "$confirm" != "Y" ] && [ "$confirm" != "n" ] && [ "$confirm" != "N" ]; do
                                printf "${darkred} Please select a correct choice!"
                                printf "${white}\n\n"
                                printf " Are you sure you want to install ${green}Camera Settings Control ${white}files ? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
                                read confirm
                                printf "${white}\n"
                            done
            			    if [ "$confirm" = "y" -o "$confirm" = "Y" ]; then
                			    printf "${green} Installing Camera Settings Control files..."
                			    printf "${white}\n\n"
                			    if [ ! -f "$camera_file" ]; then
                			        printf "Downloading Camera Settings Control file...\n"
                			        wget --no-check-certificate -P /usr/data/printer_data/config/ "$camera_URL"
                			    fi
                			    printf "Restarting services...\n"
                			    /etc/init.d/S55klipper_service restart
                			    printf "\n"
                			    printf "${green} Camera Settings Control files have been installed successfully!"
                			    printf "${white}\n\n"
                			    printf " Don't miss to add this in printer.cfg file:"
                			    printf "${white}\n\n"
                			    printf "${yellow} [include camera-settings.cfg]"
                			    printf "${white}\n\n"
                			elif [ "$confirm" = "n" -o "$confirm" = "N" ]; then
                			    printf "${darkred} Installation canceled!"
                			    printf "${white}\n\n"
            			    fi
            			fi
                        ;;
                    13)
						if [ ! -d "$moonraker_folder" ]; then
            				printf "${darkred} Please install Moonraker and Nginx first!"
            				printf "${white}\n\n"
						elif [ ! -d "$fluidd_folder" ] && [ ! -d "$mainsail_folder" ]; then
            				printf "${darkred} Please install Fluidd and/or Mainsail first!"
            				printf "${white}\n\n"
            			else
            			    printf " Are you sure you want to install ${green}OctoEverywhere${white}? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
            			    read confirm
            			    printf "${white}\n"
            			    while [ "$confirm" != "y" ] && [ "$confirm" != "Y" ] && [ "$confirm" != "n" ] && [ "$confirm" != "N" ]; do
                                printf "${darkred} Please select a correct choice!"
                                printf "${white}\n\n"
                                printf " Are you sure you want to install ${green}OctoEverywhere ${white}? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
                                read confirm
                                printf "${white}\n"
                            done
            			    if [ "$confirm" = "y" -o "$confirm" = "Y" ]; then
                			    printf "${green} Installing OctoEverywhere..."
                			    printf "${white}\n\n"
                			    cd /usr/data
								if [ -d "$octoeverywhere_folder" ]; then
									printf "OctoEverywhere is already installed. Download skipped."
								else
                			    	printf "Downloading OctoEverywhere for Klipper..."
                			    	git clone $octoeverywhere_URL octoeverywhere
								fi
                			    cd octoeverywhere
                			    printf "Running the OctoEverywhere installer..."
								sh ./install.sh
                			    printf "\n"
                			    printf "${green} OctoEverywhere has been installed successfully!"
                			    printf "${white}\n\n"
                			elif [ "$confirm" = "n" -o "$confirm" = "N" ]; then
                			    printf "${darkred} Installation canceled!"
                			    printf "${white}\n\n"
            			    fi
            			fi
                        ;;
                    14)
            			if [ ! -d "$moonraker_folder" ]; then
            				printf "${darkred} Please install Moonraker and Nginx first!"
            				printf "${white}\n\n"
            			elif [ ! -d "$entware_folder" ]; then
            				printf "${darkred} Please install Entware first!"
            				printf "${white}\n\n"
            			else
            			    printf " Are you sure you want to install ${green}Obico ${white}? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
            			    read confirm
            			    printf "${white}\n"
            			    while [ "$confirm" != "y" ] && [ "$confirm" != "Y" ] && [ "$confirm" != "n" ] && [ "$confirm" != "N" ]; do
                                printf "${darkred} Please select a correct choice!"
                                printf "${white}\n\n"
                                printf " Are you sure you want to install ${green}Obico ${white}? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
                                read confirm
                                printf "${white}\n"
                            done
            			    if [ "$confirm" = "y" -o "$confirm" = "Y" ]; then
                			    printf "${green} Installing Obico..."
                			    printf "${white}\n\n"
                			    cd /usr/data
								if [ -d "$moonraker_obico_folder" ]; then
                			        printf "Obico is already installed. Download skipped."
                			    else
                			        printf "Downloading Obico..."
                			        git clone $moonraker_obico_URL moonraker-obico
                			    fi
                			    cd moonraker-obico
                			    printf "Installing dependencies and configuring Obico..."
                			    sh ./scripts/install_creality.sh -k
                			    printf "\n"
                			    printf "${green} Obico has been installed successfully!"
                			    printf "${white}\n\n"
                			elif [ "$confirm" = "n" -o "$confirm" = "N" ]; then
                			    printf "${darkred} Installation canceled!"
                			    printf "${white}\n\n"
            			    fi
            			fi
                        ;;
                    15)
            			if [ -d "$mobileraker_folder" ]; then
            				printf "${darkred} Mobileraker Companion is already installed!"
            				printf "${white}\n\n"
            			else
            			    printf " Are you sure you want to install ${green}Mobileraker Companion ${white}? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
            			    read confirm
            			    printf "${white}\n"
            			    while [ "$confirm" != "y" ] && [ "$confirm" != "Y" ] && [ "$confirm" != "n" ] && [ "$confirm" != "N" ]; do
                                printf "${darkred} Please select a correct choice!"
                                printf "${white}\n\n"
                                printf " Are you sure you want to install ${green}Mobileraker Companion ${white}? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
                                read confirm
                                printf "${white}\n"
                            done
            			    if [ "$confirm" = "y" -o "$confirm" = "Y" ]; then
                			    printf "${green} Installing Mobileraker Companion..."
                			    printf "${white}\n\n"
                			    cd /usr/data
                			    echo "Installing prerequisite python packages..."
                			    pip3 install requests websockets pytz coloredlogs
                			    echo "Downloading modified version of Mobileraker Companion for K1..."
                			    git clone --depth 1 "$mobileraker_URL1"
                			    cd mobileraker_companion
                			    echo 'Getting K1 compatibility patches...'
                			    wget --no-check-certificate "$mobileraker_URL2"
                			    echo 'Applying K1 compatibility patches...'
                			    patch -p1 < mobileraker-companion-k1-no-tzlocal.patch
                			    echo "Adding startup script..."
                			    cp S80mobileraker_companion /etc/init.d/S80mobileraker_companion
                			    chmod 755 /etc/init.d/S80mobileraker_companion
                			    echo "Starting service..."
                			    /etc/init.d/S80mobileraker_companion restart
                			    printf "\n"
                			    printf "${green} Mobileraker Companion has been installed successfully!"
                			    printf "${white}\n\n"
                			elif [ "$confirm" = "n" -o "$confirm" = "N" ]; then
                			    printf "${darkred} Installation canceled!"
                			    printf "${white}\n\n"
            			    fi
            			fi
                        ;;
                    B)
                    	clear
                        break
                        ;;
                    Q)
                        exit
                        ;;
                    *)
            			printf "${darkred} Please select a correct choice!"
            			printf "${white}\n\n"
            			;;
                esac
            done
            ;;
        2)
            while [ 1 ]
            do
                uninstall_menu
                case $opt_uninstall_menu in
                    1)
            			if [[ ! -d "$moonraker_folder" -a ! -d "$nginx_folder" ]]; then
            				printf "${darkred} Moonraker and Nginx are not installed!"
            				printf "${white}\n\n"
            			else
            			    printf " Are you sure you want to remove ${green}Moonraker and Nginx ${white}? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
            			    read confirm
            			    printf "${white}\n";
            			    while [ "$confirm" != "y" ] && [ "$confirm" != "Y" ] && [ "$confirm" != "n" ] && [ "$confirm" != "N" ]; do
                                printf "${darkred} Please select a correct choice!"
                                printf "${white}\n\n"
                                printf " Are you sure you want to remove ${green}Moonraker and Nginx ${white}? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
                                read confirm
                                printf "${white}\n"
                            done
                            if [ "$confirm" = "y" -o "$confirm" = "Y" ]; then
                			    printf "${green} Removing Moonraker and Nginx..."
                			    printf "${white}\n\n"
                			    printf "Stopping services...\n"
                			    cd /overlay/upper
                			    /etc/init.d/S50nginx stop
                			    /etc/init.d/S56moonraker_service stop
                			    printf "Deleting files...\n"
                			    rm -rf /etc/init.d/S50nginx /etc/init.d/S56moonraker_service 
                			    rm -rf /usr/data/printer_data/config/moonraker.conf /usr/data/printer_data/config/.moonraker.conf.bkp /usr/data/printer_data/.moonraker.uuid /usr/data/printer_data/moonraker.asvc /usr/data/nginx /usr/data/moonraker
                			    printf "\n"
                			    printf "${green} Moonraker and Nginx }have been removed successfully!"
                			    printf "${white}\n\n"
                			elif [ "$confirm" = "n" -o "$confirm" = "N" ]; then
                			    printf "${darkred} Deletion canceled!"
                			    printf "${white}\n\n"
            			    fi
            			fi
                        ;;
                    2)
            			if [ ! -d "$fluidd_folder" ]; then
            				printf "${darkred} Fluidd is not installed!"
            				printf "${white}\n\n"
            			else
            			    printf " Are you sure you want to remove ${green}Fluidd ${white}? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
            			    read confirm
            			    printf "${white}\n";
            			    while [ "$confirm" != "y" ] && [ "$confirm" != "Y" ] && [ "$confirm" != "n" ] && [ "$confirm" != "N" ]; do
                                printf " ${darkred}Please select a correct choice! ${white}\n\n"
                                printf " Are you sure you want to remove ${green}Fluidd ${white}? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
                                read confirm
                                printf "${white}\n"
                            done
                            if [ "$confirm" = "y" -o "$confirm" = "Y" ]; then
                                printf "${green} Removing Fluidd..."
                			    printf "${white}\n\n"
                                printf "Deleting files...\n"
                			    rm -rf /usr/data/fluidd
                			    printf "Downloading Moonraker configuration file...\n"
                    			wget --no-check-certificate "$moonraker_config_URL"
                    			printf "Copying file...\n"
                    			mv moonraker.conf /usr/data/printer_data/config/moonraker.conf
                			    printf "\n"
                			    printf "${green} Fluidd has been removed successfully!"
                			    printf "${white}\n\n"
                			elif [ "$confirm" = "n" -o "$confirm" = "N" ]; then
                			    printf "${darkred} Deletion canceled!"
                			    printf "${white}\n\n"
            			    fi
            			fi
                        ;;
                    3)
            			if [ ! -d "$mainsail_folder" ]; then
                			printf "${darkred} Mainsail is not installed!"
                			printf "${white}\n\n"
            			else
            			    printf " Are you sure you want to remove ${green}Mainsail ${white}? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
            			    read confirm
            			    printf "${white}\n"
            			    while [ "$confirm" != "y" ] && [ "$confirm" != "Y" ] && [ "$confirm" != "n" ] && [ "$confirm" != "N" ]; do
                                printf "${darkred} Please select a correct choice!"
                                printf "${white}\n\n"
                                printf " Are you sure you want to remove ${green}Mainsail ${white}? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
                                read confirm
                                printf "${white}\n"
                            done
                            if [ "$confirm" = "y" -o "$confirm" = "Y" ]; then
                                printf "${green} Removing Mainsail..."
                			    printf "${white}\n\n"
                                printf "Deleting files...\n"
                			    rm -rf /usr/data/mainsail
                			    printf "Downloading Moonraker configuration file...\n"
                    			wget --no-check-certificate "$moonraker_config_URL"
                    			printf "Copying file...\n"
                    			mv moonraker.conf /usr/data/printer_data/config/moonraker.conf
                			    printf "\n"
                			    printf "${green} Mainsail has been removed successfully!"
                			    printf "${white}\n\n"
                			elif [ "$confirm" = "n" -o "$confirm" = "N" ]; then
                			    printf "${darkred} Deletion canceled!"
                			    printf "${white}\n\n"
            			    fi
            			fi
                        ;;
                    4)
                        printf " Are you sure you want to remove ${green}Entware${white}, it will also remove all installed packages ? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
            			read confirm
            			printf "${white}\n"
            			while [ "$confirm" != "y" ] && [ "$confirm" != "Y" ] && [ "$confirm" != "n" ] && [ "$confirm" != "N" ]; do
                                printf "${darkred} Please select a correct choice!"
                                printf "${white}\n\n"
                                printf " Are you sure you want to remove ${green}Entware${white}, it will also remove all installed packages ? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
                                read confirm
                                printf "${white}\n"
                            done
            			if [ "$confirm" = "y" -o "$confirm" = "Y" ]; then
            			    printf "${green} Removing Entware..."
                			printf "${white}\n\n"
            			    printf "Removing startup script...\n"
                            rm -f /etc/init.d/S50unslung
                            printf "Removing opt directory...\n"
                            rm -rf /usr/data/opt
                            printf "Removing /opt symbolic link and replacing with stock empty directory...\n"
                            if [ -L /opt ]; then
                                rm /opt
                                mkdir -p /opt
                                chmod 755 /opt
                            fi
                            printf "Removing SFTP server symlink if it exists...\n"
                            [ -L /usr/libexec/sftp-server ] && rm /usr/libexec/sftp-server
                            printf "Removing /opt/bin and /opt/sbin from PATH in the system profile...\n"
                            rm -f /etc/profile.d/entware.sh
                            sed -i 's/\/opt\/bin:\/opt\/sbin:\/bin:/\/bin:/' /etc/profile
                            printf "\n"
            			    printf "${green} Entware has been removed successfully!"
            			    printf "${white}\n\n"
            			elif [ "$confirm" = "n" -o "$confirm" = "N" ]; then
                			printf "${darkred} Deletion canceled!"
                			printf "${white}\n\n"
            			fi
                        ;;
					5)
            			if [ ! -f "$shellcommand_file" ]; then
            				printf "${darkred} Klipper Gcode Shell Command file is not installed!"
            				printf "${white}\n\n"
            			elif [ -f "$buzzer_file" ]; then
            				printf "${darkred} Klipper Gcode Shell Command is needed to use Buzzer Support, please uninstall it first!"
            				printf "${white}\n\n"
            			elif [ -f "$camera_file" ]; then
            				printf "${darkred} Klipper Gcode Shell Command is needed to use Camera Settings Control, please uninstall it first!"
            				printf "${white}\n\n"
            			else
            			    printf " Are you sure you want to remove ${green}Klipper Gcode Shell Command ${white}file ? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
            			    read confirm
            			    printf "${white}\n"
            			    while [ "$confirm" != "y" ] && [ "$confirm" != "Y" ] && [ "$confirm" != "n" ] && [ "$confirm" != "N" ]; do
                                printf "${darkred} Please select a correct choice!"
                                printf "${white}\n\n"
                                printf " Are you sure you want to remove ${green}Klipper Gcode Shell Command ${white}file ? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
                                read confirm
                                printf "${white}\n"
                            done
            			    if [ "$confirm" = "y" -o "$confirm" = "Y" ]; then
            			        printf "${green} Removing Klipper Gcode Shell Command..."
                			    printf "${white}\n\n"
            			        printf "Deleting file...\n"
                			        rm -rf /usr/share/klipper/klippy/extras/gcode_shell_command.py /usr/share/klipper/klippy/extras/gcode_shell_command.pyc
                			    printf "\n"
                			    printf "${green} Klipper Gcode Shell Command file has been removed successfully!"
                			elif [ "$confirm" = "n" -o "$confirm" = "N" ]; then
                			    printf "${darkred} Deletion canceled!"
                			    printf "${white}\n\n"
            			    fi
            			fi
            			;;
                    6)
            			if [ ! -f "$hostname_file" ]; then
            				printf "${darkred} Hotsname Service file is not installed!"
            				printf "${white}\n\n"
            			else
            			    printf " Are you sure you want to remove ${green}Hotsname Service ${white}file ? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
            			    read confirm
            			    printf "${white}\n"
            			    while [ "$confirm" != "y" ] && [ "$confirm" != "Y" ] && [ "$confirm" != "n" ] && [ "$confirm" != "N" ]; do
                                printf "${darkred} Please select a correct choice!"
                                printf "${white}\n\n"
                                printf " Are you sure you want to remove ${green}Hotsname Service ${white}file ? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
                                read confirm
                                printf "${white}\n"
                            done
            			    if [ "$confirm" = "y" -o "$confirm" = "Y" ]; then
            			        printf "${green} Removing Hotsname Service..."
                			    printf "${white}\n\n"
            			        printf "Deleting file...\n"
                			    rm -rf /etc/init.d/S01hostname
                			    printf "\n"
                			    printf "${green} Hotsname Service file has been removed successfully!"
                			    printf "${white}\n\n"
                			elif [ "$confirm" = "n" -o "$confirm" = "N" ]; then
                			    printf "${darkred} Deletion canceled!"
                			    printf "${white}\n\n"
            			    fi
            			fi
            			;;
            		7)
            			if [[ ! -f "$systemctl_file" ]]; then
            				printf "${darkred} Fix for Reboot/Shutdown functions is not installed!"
            				printf "${white}\n\n"
            			else
                            printf " Are you sure you want to remove ${green}Fix for Reboot/Shutdown functions ${white}? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
            			    read confirm
            			    printf "${white}\n"
            			    while [ "$confirm" != "y" ] && [ "$confirm" != "Y" ] && [ "$confirm" != "n" ] && [ "$confirm" != "N" ]; do
                                printf "${darkred} Please select a correct choice!"
                                printf "${white}\n\n"
                                printf " Are you sure you want to remove ${green}Fix for Reboot/Shutdown functions ${white}? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
                                read confirm
                                printf "${white}\n"
                            done
            			    if [ "$confirm" = "y" -o "$confirm" = "Y" ]; then
            			        printf "${green} Removing Fix for Reboot/Shutdown functions..."
                			    printf "${white}\n\n"
                			    opkg remove sudo
                			    printf "Removing files...\n"
                			    rm /usr/bin/sudo /usr/bin/systemctl
                			    printf "\n"
                			    printf "${green} Fix for Reboot/Shutdown functions has been removed successfully!"
                			    printf "${white}\n\n"
            			    elif [ "$confirm" = "n" -o "$confirm" = "N" ]; then
                			    printf "${darkred} Deletion canceled!"
                			    printf "${white}\n\n"
            			    fi
            			fi
                        ;;
                    8)
            			if [[ ! -d "$kamp_folder" ]]; then
            				printf "${darkred} Klipper Adaptive Meshing & Purging is not installed!"
            				printf "${white}\n\n"
            			else
            			    printf " Are you sure you want to remove ${green}Klipper Adaptive Meshing & Purging ${white}? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
            			    read confirm
            			    printf "${white}\n"
                            if [ "$confirm" = "y" -o "$confirm" = "Y" ]; then
                                printf "${green} Removing Klipper Adaptive Meshing & Purging..."
                			    printf "${white}\n\n"
                                printf "Deleting files...\n"
                			    rm -rf /usr/data/KAMP-for-K1-Series /usr/data/printer_data/config/KAMP /usr/data/printer_data/config/KAMP_Settings.cfg
                			    printf "Restarting services...\n"
                			    /etc/init.d/S55klipper_service restart
                			    printf "\n"
                			    printf "${green} Klipper Adaptive Meshing & Purging has been removed successfully!"
                			    printf "${white}\n\n"
                			    printf " Don't miss to remove this line in printer.cfg file:"
                			    printf "${white}\n\n"
                			    printf "${yellow} [include KAMP_Settings.cfg]"
                			    printf "${white}\n\n"
                			elif [ "$confirm" = "n" -o "$confirm" = "N" ]; then
                			    printf "${darkred} Deletion canceled!"
                			    printf "${white}\n\n"
                			fi
           				fi
                        ;;
					9)
            			if [[ ! -f "$buzzer_file" ]]; then
            				printf "${darkred} Buzzer Support files are not installed!"
            				printf "${white}\n\n"
            			else
                            printf " Are you sure you want to remove ${green}Buzzer Support ${white}files ? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
            			    read confirm
            			    printf "${white}\n"
            			    while [ "$confirm" != "y" ] && [ "$confirm" != "Y" ] && [ "$confirm" != "n" ] && [ "$confirm" != "N" ]; do
                                printf "${darkred} Please select a correct choice!"
                                printf "${white}\n\n"
                                printf " Are you sure you want to remove ${green}Buzzer Support ${white}files ? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
                                read confirm
                                printf "${white}\n"
                            done
            			    if [ "$confirm" = "y" -o "$confirm" = "Y" ]; then
            			        printf "${green} Removing Buzzer Support..."
                			    printf "${white}\n\n"
                			    printf "Deleting file...\n"
                			    rm -rf /usr/data/beep.mp3
                			    printf "Restarting services...\n"
                			    /etc/init.d/S55klipper_service restart
                			    printf "\n"
                			    printf "${green} Buzzer Support files have been removed successfully!"
                			    printf "${white}\n\n"
            			    elif [ "$confirm" = "n" -o "$confirm" = "N" ]; then
                			    printf "${darkred} Deletion canceled!"
                			    printf "${white}\n\n"
            			    fi
            			fi
                        ;;
					10)
            			if [[ ! -d "$prtouch_folder" ]]; then
            				printf "${darkred} Nozzle Cleaning Fan Control files are not installed!"
            				printf "${white}\n\n"
            			else
                            printf " Are you sure you want to remove ${green}Nozzle Cleaning Fan Control ${white}files ? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
            			    read confirm
            			    printf "${white}\n"
            			    while [ "$confirm" != "y" ] && [ "$confirm" != "Y" ] && [ "$confirm" != "n" ] && [ "$confirm" != "N" ]; do
                                printf "${darkred} Please select a correct choice!"
                                printf "${white}\n\n"
                                printf " Are you sure you want to remove ${green}Nozzle Cleaning Fan Control ${white}files ? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
                                read confirm
                                printf "${white}\n"
                            done
            			    if [ "$confirm" = "y" -o "$confirm" = "Y" ]; then
            			        printf "${green} Removing Nozzle Cleaning Fan Control..."
                			    printf "${white}\n\n"
            			        printf "Deleting files...\n"
                			    rm -rf /usr/share/klipper/klippy/extras/prtouch_v2_fan
                			    printf "Restarting services...\n"
                			    /etc/init.d/S55klipper_service restart
                			    printf "\n"
                			    printf "${green} Nozzle Cleaning Fan Control files have been removed successfully!"
                			    printf "${white}\n\n"
                			    printf " Don't miss to remove this in printer_params.cfg file:"
                			    printf "${white}\n\n"
                			    printf "${yellow} [prtouch_v2_fan] \n"
                			    printf "${yellow} max_speed: 0.5"
                			    printf "${white}\n\n"
            			    elif [ "$confirm" = "n" -o "$confirm" = "N" ]; then
                			    printf "${darkred} Deletion canceled!"
                			    printf "${white}\n\n"
            			    fi
            			fi
                        ;;
                    11)
            			if [ ! -f "$timelapse_file" ]; then
                			printf "${darkred} Moonraker Timelapse is not installed!"
                			printf "${white}\n\n"
            			else
            			    printf " Are you sure you want to remove ${green}Moonraker Timelapse ${white}? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
            			    read confirm
            			    printf "${white}\n"
            			    while [ "$confirm" != "y" ] && [ "$confirm" != "Y" ] && [ "$confirm" != "n" ] && [ "$confirm" != "N" ]; do
                                printf "${darkred} Please select a correct choice!"
                                printf "${white}\n\n"
                                printf " Are you sure you want to remove ${green}Moonraker Timelapse ${white}? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
                                read confirm
                                printf "${white}\n"
                            done
                            if [ "$confirm" = "y" -o "$confirm" = "Y" ]; then
                                printf "${green} Removing Moonraker Timelapse..."
                			    printf "${white}\n\n"
                                printf "Deleting files...\n"
                			    rm -rf /usr/data/moonraker/moonraker/moonraker/components/timelapse.py /usr/data/moonraker/moonraker/moonraker/components/timelapse.pyc /usr/data/printer_data/config/timelapse.cfg
                			    printf "Restarting services...\n"
                			    /etc/init.d/S55klipper_service restart
                			    printf "\n"
                			    printf "${green} Moonraker Timelapse has been removed successfully!"
                			    printf "${white}\n\n"
                			    printf " Don't miss to remove this in moonraker.conf file:"
                			    printf "${white}\n\n"
                			    printf "${yellow} [timelapse] \n"
                			    printf "${yellow} output_path: /usr/data/printer_data/timelapse/ \n"
                			    printf "${yellow} frame_path: /usr/data/printer_data/frames/ \n"
                			    printf "${yellow} snapshoturl: http://localhost:4408/webcam/?action=snapshot"
                			    printf "${white}\n\n"
                			elif [ "$confirm" = "n" -o "$confirm" = "N" ]; then
                			    printf "${darkred} Deletion canceled!"
                			    printf "${white}\n\n"
            			    fi
            			fi
                        ;;
                    12)
            			if [[ ! -f "$camera_file" ]]; then
            				printf "${darkred} Camera Settings Control files are not installed!"
            				printf "${white}\n\n"
            			else
                            printf " Are you sure you want to remove ${green}Camera Settings Control ${white}files ? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
            			    read confirm
            			    printf "${white}\n"
            			    while [ "$confirm" != "y" ] && [ "$confirm" != "Y" ] && [ "$confirm" != "n" ] && [ "$confirm" != "N" ]; do
                                printf "${darkred} Please select a correct choice!"
                                printf "${white}\n\n"
                                printf " Are you sure you want to remove ${green}Camera Settings Control ${white}files ? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
                                read confirm
                                printf "${white}\n"
                            done
            			    if [ "$confirm" = "y" -o "$confirm" = "Y" ]; then
            			        printf "${green} Removing Camera Settings Control..."
                			    printf "${white}\n\n"
                			    printf "Deleting file...\n"
                			    rm -rf /usr/data/printer_data/config/camera-settings.cfg
                			    printf "Restarting services...\n"
                			    /etc/init.d/S55klipper_service restart
                			    printf "\n"
                			    printf "${green} Camera Settings Control files have been removed successfully!"
                			    printf "${white}\n\n"
                			    printf " Don't miss to remove this in printer.cfg file:"
                			    printf "${white}\n\n"
                			    printf "${yellow} [include camera-settings.cfg]"
                			    printf "${white}\n\n"
            			    elif [ "$confirm" = "n" -o "$confirm" = "N" ]; then
                			    printf "${darkred} Deletion canceled!"
                			    printf "${white}\n\n"
            			    fi
            			fi
                        ;;
					13)
            			if [ ! -d "$octoeverywhere_folder" ]; then
            				printf "${darkred} OctoEverywhere is not installed!"
            				printf "${white}\n\n"
            			else
            			    printf " Are you sure you want to remove ${green}OctoEverywhere ${white}? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
            			    read confirm
            			    printf "${white}\n"
            			    while [ "$confirm" != "y" ] && [ "$confirm" != "Y" ] && [ "$confirm" != "n" ] && [ "$confirm" != "N" ]; do
                                printf "${darkred} Please select a correct choice!"
                                printf "${white}\n\n"
                                printf " Are you sure you want to remove ${green}OctoEverywhere ${white}? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
                                read confirm
                                printf "${white}\n"
                            done
                            if [ "$confirm" = "y" -o "$confirm" = "Y" ]; then
                                printf "${green} Removing OctoEverywhere..."
                			    printf "${white}\n\n"
								cd $octoeverywhere_folder
								printf "Running the OctoEverywhere uninstaller..."
								sh ./uninstall.sh
                			    printf "${green} OctoEverywhere has been removed successfully!"
                			    printf "${white}\n\n"
                			elif [ "$confirm" = "n" -o "$confirm" = "N" ]; then
                			    printf "${darkred} Deletion canceled!"
                			    printf "${white}\n\n"
            			    fi
            			fi
                        ;;
                    14)
            			if [ ! -d "$moonraker_obico_folder" ]; then
                			printf "${darkred} Obico is not installed!"
                			printf "${white}\n\n"
            			else
            			    printf " Are you sure you want to remove ${green}Obico ${white}? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
            			    read confirm
            			    printf "${white}\n"
            			    while [ "$confirm" != "y" ] && [ "$confirm" != "Y" ] && [ "$confirm" != "n" ] && [ "$confirm" != "N" ]; do
                                printf "${darkred} Please select a correct choice!"
                                printf "${white}\n\n"
                                printf " Are you sure you want to remove ${green}Obico ${white}? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
                                read confirm
                                printf "${white}\n"
                            done
                            if [ "$confirm" = "y" -o "$confirm" = "Y" ]; then
                                printf "${green} Removing Obico..."
                			    printf "${white}\n\n"
                                printf "Deleting files...\n"
                			    rm -rf $moonraker_obico_folder
                			    rm -rf /usr/data/moonraker-obico-env
                			    printf "Removing service file...\n"
                    			rm -f /etc/init.d/S99moonraker_obico
                			    printf "\n"
                			    printf "${green} Obico has been removed successfully!"
                			    printf "${white}\n\n"
                			elif [ "$confirm" = "n" -o "$confirm" = "N" ]; then
                			    printf "${darkred} Deletion canceled!"
                			    printf "${white}\n\n"
            			    fi
            			fi
                        ;;
                    15)
            			if [[ ! -d "$mobileraker_folder" ]]; then
            				printf "${darkred} Mobileraker Companion is not installed!"
            				printf "${white}\n\n"
            			else
            			    printf " Are you sure you want to remove ${green}Mobileraker Companion ${white}? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
            			    read confirm
            			    printf "${white}\n"
            			    while [ "$confirm" != "y" ] && [ "$confirm" != "Y" ] && [ "$confirm" != "n" ] && [ "$confirm" != "N" ]; do
                                printf "${darkred} Please select a correct choice!"
                                printf "${white}\n\n"
                                printf " Are you sure you want to remove ${green}Mobileraker Companion ${white}? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
                                read confirm
                                printf "${white}\n"
                            done
                            if [ "$confirm" = "y" -o "$confirm" = "Y" ]; then
                                printf "${green} Removing Mobileraker Companion..."
                			    printf "${white}\n\n"
                			    printf "Stopping services...\n"
                			    /etc/init.d/S80mobileraker_companion stop
                			    printf "Deleting files...\n"
                			    rm -rf /etc/init.d/S80mobileraker_companion /usr/data/mobileraker_companion
                			    printf "Deleting dependencies...\n"
                			    pip3 uninstall -y requests websockets pytz coloredlogs
                			    printf "\n"
                			    printf "${green} Mobileraker Companion has been removed successfully!"
                			    printf "${white}\n\n"
                			elif [ "$confirm" = "n" -o "$confirm" = "N" ]; then
                			    printf "${darkred} Deletion canceled!"
                			    printf "${white}\n\n"
            			    fi
            			fi
                        ;;
                    B)
                    	clear
                        break
                        ;;
                    Q)
                        exit
                        ;;
                    *)
            			printf "${darkred} Please select a correct choice!"
            			printf "${white}\n\n"
            		;;
                esac
            done
            ;;
        3)
            while [ 1 ]
            do
                backup_menu
                case $opt_backup_menu in
                    1)
                        printf " Are you sure you want to backup ${green}Klipper configuration ${white}files ? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
            			read confirm
            			printf "${white}\n"
            			while [ "$confirm" != "y" ] && [ "$confirm" != "Y" ] && [ "$confirm" != "n" ] && [ "$confirm" != "N" ]; do
                            printf "${darkred} Please select a correct choice!"
                            printf "${white}\n\n"
                            printf " Are you sure you want to backup ${green}Klipper configuration ${white}files ? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
                            read confirm
                            printf "${white}\n"
                        done
                        if [ "$confirm" = "y" -o "$confirm" = "Y" ]; then
                            FILE=/root/backup_config.tar
            			    if [[ -f "$FILE" ]]; then
                			    rm -f /root/backup_config.tar
            			    fi
            			    printf "Compressing files..."
            			    cd /usr/data/printer_data
            			    tar -czvf /root/backup_config.tar config/
            			    printf "\n"
            			    printf "${green} Klipper configuration files have been saved successfully in ${yellow}/root ${green}folder!"
            			    printf "${white}\n\n"
            			elif [ "$confirm" = "n" -o "$confirm" = "N" ]; then
                			printf "${darkred} Backup canceled!"
                			printf "${white}\n\n"
            			fi
                        ;;
                    2)
                        DIR1=/usr/data/printer_data/config/
            			FILE=/root/backup_config.tar
            			if [[ ! -f "$FILE" ]]; then
                			printf "${darkred} Please backup configuration files before restore!"
                			printf "${white}\n\n"
            			else
            			    printf " Are you sure you want to restore ${green}Klipper configuration ${white}files ? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
            			    read confirm
            			    printf "${white}\n"
            			    while [ "$confirm" != "y" ] && [ "$confirm" != "Y" ] && [ "$confirm" != "n" ] && [ "$confirm" != "N" ]; do
                                printf "${darkred} Please select a correct choice!"
                                printf "${white}\n\n"
                                printf " Are you sure you want to restore ${green}Klipper configuration ${white}files ? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
                                read confirm
                                printf "${white}\n"
                            done
                            if [ "$confirm" = "y" -o "$confirm" = "Y" ]; then
            			        if [[ -d "$DIR1" ]]; then
                    			    rm -rf /usr/data/printer_data/config
                			    fi
                			    cp /root/backup_config.tar /usr/data/printer_data/
                			    cd /usr/data/printer_data
                			    printf "Copying files..."
                			    tar -xvf backup_config.tar
                			    rm -f backup_config.tar
                			    printf "\n"
                			    printf "${green} Klipper configuration files have been restored successfully!"
                			    printf "${white}\n\n"
                			    backup_menu
                			elif [ "$confirm" = "n" -o "$confirm" = "N" ]; then
                			    printf "${darkred} Restoration canceled!"
                			    printf "${white}\n\n"
            			    fi
            			fi
                        ;;
                    B)
                    	clear
                        break
                        ;;
                    Q)
                        exit
                        ;;
                    *)
            			printf "${darkred} Please select a correct choice!"
            			printf "${white}\n\n"
                        ;;
                esac
            done
            ;;
        4)
            while [ 1 ]
            do
                customize_menu
                case $opt_customize_menu in
                    1)
            			if [ ! -d "$bootdisplay_folder" ]; then
            				printf "${darkred} Please use latest firmware to install Custom Boot Display!"
            				printf "${white}\n\n"
            			else
                            printf " Are you sure you want to install ${green}Custom Boot Display ${white}file ? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
            			    read confirm
            			    printf "${white}\n"
            			    while [ "$confirm" != "y" ] && [ "$confirm" != "Y" ] && [ "$confirm" != "n" ] && [ "$confirm" != "N" ]; do
                                printf "${darkred} Please select a correct choice!"
                                printf "${white}\n\n"
                                printf " Are you sure you want to install ${green}Custom Boot Display ${white}file ? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
                                read confirm
                                printf "${white}\n"
                            done
            			    if [ "$confirm" = "y" -o "$confirm" = "Y" ]; then
            			        printf " Do you want install ${green}Custom Boot Display ${white}for ${yellow}K1${white} or ${yellow}K1 Max ${white}? (${yellow}k1${white}/${yellow}k1max${white}): ${yellow}" 
            			        read confirm2
            			        printf "${white}\n"
            			        while [ "$confirm2" != "k1" ] && [ "$confirm2" != "K1" ] && [ "$confirm2" != "k1max" ] && [ "$confirm2" != "K1MAX" ]; do
                                    printf "${darkred} Please select a correct choice!"
                                    printf "${white}\n\n"
                                    printf " Do you want install ${green}Custom Boot Display ${white}for ${yellow}K1${white} or ${yellow}K1 Max ${white}? (${yellow}k1${white}/${yellow}k1max${white}): ${yellow}" 
                                    read confirm2
                                    printf "${white}\n"
                                done
            			        if [ "$confirm2" = "k1" -o "$confirm2" = "K1" ]; then
                			        printf "${green} Installing Custom Boot Display for K1..."
                			        printf "${white}\n\n"
                			        cd /etc/boot-display
                			        printf "Downloading Custom Boot Display file...\n"
                			        wget --no-check-certificate "$bootdisplay_URL1"
                			        if [ $? -eq 0 ]; then
                			            printf "Copying files...\n"
                			            rm -rf part0 boot-display.conf
                			            tar -xvf  k1_boot_display.tar
                			            rm -f k1_boot_display.tar
                			            printf "\n"
                			            printf "${green} Custom Boot Display for ${yellow}K1 ${green}has been installed successfully!"
                			            printf "${white}\n\n"
                			        else
                			            printf "${darkred} Download failed. Exit code: $?"
                			            printf "${white}\n\n"
                			        fi
            			        elif [ "$confirm2" = "k1max" -o "$confirm2" = "K1MAX" ]; then
                			        printf "${green} Installing Custom Boot Display for K1 Max..."
                			        printf "${white}\n\n"
                			        cd /etc/boot-display
                			        printf "Downloading Custom Boot Display file...\n"
                			        wget --no-check-certificate "$bootdisplay_URL2"
                			        if [ $? -eq 0 ]; then
                			            printf "Copying files...\n"
                			            rm -rf part0 boot-display.conf
                			            tar -xvf k1max_boot_display.tar
                			            rm -f k1max_boot_display.tar
                			            printf "\n"
                			            printf "${green} Custom Boot Display for ${yellow}K1 Max ${green}has been installed successfully!"
                			            printf "${white}\n\n"
                			        else
                			            printf "${darkred} Download failed. Exit code: $?"
                			            printf "${white}\n\n"
                			        fi
            			        fi
            			    elif [ "$confirm" = "n" -o "$confirm" = "N" ]; then
                			    printf "${darkred} Installation canceled! ${white}\n\n"
            			    fi
            			fi
                        ;;
            	    2)
            			if [ ! -d "$bootdisplay_folder" ]; then
            				printf "${darkred} Please use latest firmware to restore Stock Boot Display!"
            				printf "${white}\n\n"
            			else
                            printf " Are you sure you want to remove ${green}Custom Boot Display ${white}file ? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
            			    read confirm
            			    printf "${white}\n"
            			    while [ "$confirm" != "y" ] && [ "$confirm" != "Y" ] && [ "$confirm" != "n" ] && [ "$confirm" != "N" ]; do
                                printf "${darkred} Please select a correct choice!"
                                printf "${white}\n\n"
                                printf " Are you sure you want to remove ${green}Custom Boot Display ${white}file ? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
                                read confirm
                                printf "${white}\n"
                            done
            			    if [ "$confirm" = "y" -o "$confirm" = "Y" ]; then
            			        printf "${green} Removing Custom Boot Display..."
                			    printf "${white}\n\n"
                			    cd /etc/boot-display
                			    printf "Downloading Stock Boot Display file...\n"
                			    wget --no-check-certificate "$bootdisplay_URL3"
                                if [ $? -eq 0 ]; then
                                    printf "Copying files...\n"
                			        rm -rf part0 boot-display.conf
                			        tar -xvf  stock_boot_display.tar
                			        rm -f stock_boot_display.tar
                			        printf "\n"
                			        printf "${green} Custom Boot Display has been removed successfully!"
                			        printf "${white}\n\n"
                			    else
                			        printf "${darkred} Download failed. Exit code: $?"
                			        printf "${white}\n\n"
                			    fi
            			    elif [ "$confirm" = "n" -o "$confirm" = "N" ]; then
                			    printf "${darkred} Deletion canceled!"
                			    printf "${white}\n\n"
            			    fi
            			fi
                        ;;
                    3)
            			if [ ! -d "$fluidd_folder" ] && [ ! -d "$mainsail_folder" ]; then
            				printf "${darkred} Please install Fluidd and/or Mainsail first!"
            				printf "${white}\n\n"
            			elif [ ! -f "$crealityweb_file" ]; then
            			    printf "${darkred} Creality Web Interface is already removed!"
            			    printf "\n"
            			    printf "${darkred} If you want to change the default Web Interface please restore Creality Web Interface first."
            				printf "${white}\n\n"
            			else
                            printf " Are you sure you want to remove ${green}Creality Web Interface ${white}?\n ${darkred}Note that you will no longer be able to print via WiFi with Creality Print ${white}(${yellow}y${white}/${yellow}n${white}): ${yellow}"
            			    read confirm
            			    printf "${white}\n"
            			    while [ "$confirm" != "y" ] && [ "$confirm" != "Y" ] && [ "$confirm" != "n" ] && [ "$confirm" != "N" ]; do
                                printf "${darkred} Please select a correct choice!"
                                printf "${white}\n\n"
                                printf " Are you sure you want to remove ${green}Creality Web Interface ${white}?\n ${darkred}Note that you will no longer be able to print via WiFi with Creality Print ${white}(${yellow}y${white}/${yellow}n${white}): ${yellow}"
                                read confirm
                                printf "${white}\n"
                            done
            			    if [ "$confirm" = "y" -o "$confirm" = "Y" ]; then
            			        if [ -d "$fluidd_folder" -a ! -d "$mainsail_folder" ]; then
            			            printf "${green} Removing Creality Web Interface..."
                			        printf "${white}\n\n"
                			        mv /usr/bin/web-server /usr/bin/web-server.disabled
                                    mv /usr/bin/Monitor /usr/bin/Monitor.disabled
                                    sed -i '/listen 4408 default_server;/a \        listen 80;' /usr/data/nginx/nginx/nginx.conf
                                    killall -q Monitor
                                    killall -q web-server
                                    /etc/init.d/S50nginx restart
                                    printf "\n"
                                    printf "${green} Creality Web Interface has been removed successfully!"
                			        printf "${white}\n\n"
                			        printf " You can now connect to Fluidd Web Interface with ${yellow}http://$(check_ipaddress)"
                			        printf "${white}\n\n"
            			        elif [ ! -d "$fluidd_folder" -a -d "$mainsail_folder" ]; then
            			            printf "${green} Removing Creality Web Interface..."
                			        printf "${white}\n\n"
                			        mv /usr/bin/web-server /usr/bin/web-server.disabled
                                    mv /usr/bin/Monitor /usr/bin/Monitor.disabled
                                    sed -i '/listen 4409 default_server;/a \        listen 80;' /usr/data/nginx/nginx/nginx.conf
                                    killall -q Monitor
                                    killall -q web-server
                                    /etc/init.d/S50nginx restart
                                    printf "\n"
                                    printf "${green} Creality Web Interface has been removed successfully!"
                			        printf "${white}\n\n"
                			        printf " You can now connect to Mainsail Web Interface with ${yellow}http://$(check_ipaddress)"
                			        printf "${white}\n\n"
            			        elif [ -d "$fluidd_folder" -a -d "$mainsail_folder" ]; then
            			            printf " Which Web Interface do you want to set as default (on port 80) ? (${yellow}fluidd${white}/${yellow}mainsail${white}): ${yellow}" 
            			            read confirm2
            			            printf "${white}\n"
            			            while [ "$confirm2" != "FLUIDD" ] && [ "$confirm2" != "MAINSAIL" ] && [ "$confirm2" != "fluidd" ] && [ "$confirm2" != "mainsail" ]; do
                                        printf "${darkred} Please select a correct choice!"
                                        printf "${white}\n\n"
                                        printf " Which Web Interface do you want to set as default (on port 80) ? (${yellow}fluidd${white}/${yellow}mainsail${white}): ${yellow}" 
                                        read confirm2
                                        printf "${white}\n"
                                    done
            			            if [ "$confirm2" = "fluidd" -o "$confirm2" = "FLUIDD" ]; then
                			            printf "${green} Removing Creality Web Interface..."
                			            printf "${white}\n\n"
                			            mv /usr/bin/web-server /usr/bin/web-server.disabled
                                        mv /usr/bin/Monitor /usr/bin/Monitor.disabled
                                        sed -i '/listen 4408 default_server;/a \        listen 80;' /usr/data/nginx/nginx/nginx.conf
                                        killall -q Monitor
                                        killall -q web-server
                                        /etc/init.d/S50nginx restart
                                        printf "\n"
                                        printf "${green} Creality Web Interface has been removed successfully!"
                			            printf "${white}\n\n"
                			            printf " You can now connect to Fluidd Web Interface with ${yellow}http://$(check_ipaddress) ${white}or ${yellow}http://$(check_ipaddress):4408"
                			            printf "${white}\n\n"
            			            elif [ "$confirm2" = "mainsail" -o "$confirm2" = "MAINSAIL" ]; then
                			            printf "${green} Removing Creality Web Interface..."
                			            printf "${white}\n\n"
                			            mv /usr/bin/web-server /usr/bin/web-server.disabled
                                        mv /usr/bin/Monitor /usr/bin/Monitor.disabled
                                        sed -i '/listen 4409 default_server;/a \        listen 80;' /usr/data/nginx/nginx/nginx.conf
                                        killall -q Monitor
                                        killall -q web-server
                                        /etc/init.d/S50nginx restart
                                        printf "\n"
                                        printf "${green} Creality Web Interface has been removed successfully!"
                			            printf "${white}\n\n"
                			            printf " You can now connect to Mainsail Web Interface with ${yellow}http://$(check_ipaddress) ${white}or ${yellow}http://$(check_ipaddress):4409"
                			            printf "${white}\n\n"
                			        fi
            			        fi
            			    elif [ "$confirm" = "n" -o "$confirm" = "N" ]; then
                			    printf "${darkred} Deletion canceled! ${white}\n\n"
            			    fi
            			fi
                        ;;
            	    4)
            			if [ -f "$crealityweb_file" ]; then
            				printf "${darkred} Creality Web Interface is already present!"
            				printf "${white}\n\n"
            			else
                            printf " Are you sure you want to restore ${green}Creality Web Interface ${white}? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
            			    read confirm
            			    printf "${white}\n"
            			    while [ "$confirm" != "y" ] && [ "$confirm" != "Y" ] && [ "$confirm" != "n" ] && [ "$confirm" != "N" ]; do
                                printf "${darkred} Please select a correct choice!"
                                printf "${white}\n\n"
                                printf " Are you sure you want to restore ${green}Creality Web Interface ${white}? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
                                read confirm
                                printf "${white}\n"
                            done
            			    if [ "$confirm" = "y" -o "$confirm" = "Y" ]; then
            			        printf "${green} Restoring Creality Web Interface..."
                			    printf "${white}\n\n"
                			    mv /usr/bin/web-server.disabled /usr/bin/web-server
                                mv /usr/bin/Monitor.disabled /usr/bin/Monitor
                                sed -i '/listen 80;/d' /usr/data/nginx/nginx/nginx.conf
                                /etc/init.d/S50nginx restart
                                killall -q Monitor
                                killall -q web-server
                                /usr/bin/web-server > /dev/null 2>&1 &
                                /usr/bin/Monitor > /dev/null 2>&1 &
                                printf "\n"
                                printf "${green} Creality Web Interface has been restored successfully!"
                                printf "${white}\n\n"
                			    printf " You can now connect to Creality Web Interface with ${yellow}http://$(check_ipaddress) ${white}and with ${yellow}Creality Print"
                			    printf "${white}\n\n"
            			    elif [ "$confirm" = "n" -o "$confirm" = "N" ]; then
                			    printf "${darkred} Restoration canceled!"
                			    printf "${white}\n\n"
            			    fi
            			fi
                        ;;
                    B)
                    	clear
                        break
                        ;;
                    Q)
                        exit
                        ;;
                    *)
            			printf "${darkred} Please select a correct choice!"
            			printf "${white}\n\n"
                        ;;
                esac
            done
            ;;
        5)
            while [ 1 ]
            do
                info_menu
                case $opt_info_menu in
                    B)
                    	clear
                        break
                        ;;
                    Q)
                        exit
                        ;;
                    *)
            			printf "${darkred} Please select a correct choice!"
            			printf "${white}\n\n"
                        ;;
                esac
            done
            ;;
        6)
            while [ 1 ]
            do
                system_menu
                case $opt_system_menu in
                    B)
                    	clear
                        break
                        ;;
                    Q)
                        exit
                        ;;
                    *)
            			printf "${darkred} Please select a correct choice!"
            			printf "${white}\n\n"
                        ;;
                esac
            done
            ;;
        R)
            if [[ ! -d "$moonraker_folder" -a ! -d "$nginx_folder" ]]; then
            	printf "${darkred} Moonraker and Nginx are not installed!"
            	printf "${white}\n\n"
            else
                printf " Do you want to reload ${green}Moonraker and Nginx ${white}services ? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
            	read confirm
            	printf "${white}\n"
            	while [ "$confirm" != "y" ] && [ "$confirm" != "Y" ] && [ "$confirm" != "n" ] && [ "$confirm" != "N" ]; do
                    printf "${darkred} Please select a correct choice!"
                    printf "${white}\n\n"
                    printf " Do you want to reload ${green}Moonraker and Nginx ${white}services ? (${yellow}y${white}/${yellow}n${white}): ${yellow}"
                    read confirm
                    printf "${white}\n"
                done
                if [ "$confirm" = "y" -o "$confirm" = "Y" ]; then
                    printf "Restarting services...\n"
                    /etc/init.d/S50nginx stop
                    /etc/init.d/S56moonraker_service stop
                    /etc/init.d/S50nginx start
                    sleep 1
                    /etc/init.d/S56moonraker_service start
                    sleep 1
                    printf "\n"
                    printf "${green} Moonraker and Nginx services have been reloaded!"
                    printf "${white}\n\n"
                elif [ "$confirm" = "n" -o "$confirm" = "N" ]; then
                	printf "${darkred} Reload canceled!"
                	printf "${white}\n\n"
                fi
            fi
            ;;
        U)
            check_updates
            ;;
        Q)
            exit
            ;;
        *)
            printf "${darkred} Please select a correct choice!"
            printf "${white}\n\n"
            ;;
    esac
done

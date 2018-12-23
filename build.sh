#!/bin/bash

# The Filebrowser from is modified from Filebrowser by Claude Pageau,
# which can be found at https://github.com/pageauc/FileBrowser.

match_string='Dockerfile'
menutitle="$match_string File Selection Menu"

function Filebrowser()
{

    if [ -z $2 ] ; then
        dir_list=$(ls -lhp ./*$match_string* | awk -F ' ' ' { print $9 " " $5 } ')
    else
        cd "$2"       
        dir_list=$(ls -lhp ./*$match_string* | awk -F ' ' ' { print $9 " " $5 } ')
    fi

    curdir=$(pwd)
    if [ "$curdir" == "/" ] ; then
        selection=$(whiptail --title "$1" \
                              --menu "Select Dockerfile to build:\n$curdir" 0 0 0 \
                              --cancel-button Cancel \
                              --ok-button Select $dir_list 3>&1 1>&2 2>&3)
    else
        selection=$(whiptail --title "$1" \
                              --menu "Select Dockerfile to build:\n$curdir" 0 0 0 \
                              --cancel-button Cancel \
                              --ok-button Select $dir_list 3>&1 1>&2 2>&3)
    fi

    RET=$?
    if [ $RET -eq 1 ]; then
       return 1
    elif [ $RET -eq 0 ]; then
       if [[ -d "$selection" ]]; then
          Filebrowser "$1" "$selection"
       elif [[ -f "$selection" ]]; then
          if [[ $selection == *$match_string* ]]; then
            if (whiptail --title "Confirm Selection" --yesno "DirPath : $curdir\nFileName: $selection" 0 0 \
                         --yes-button "Confirm" \
                         --no-button "Retry"); then
                filename="$selection"
                filepath="$curdir"
            else
                Filebrowser "$1" "$curdir"
            fi
          else
             whiptail --title "ERROR: File Must have .jpg Extension" \
                      --msgbox "$selection\nYou Must Select a jpg Image File" 0 0
             Filebrowser "$1" "$curdir"
          fi
       else
          whiptail --title "ERROR: Selection Error" \
                   --msgbox "Error Changing to Path $selection" 0 0
          Filebrowser "$1" "$curdir"
       fi
    fi
}

Filebrowser "$menutitle" "$2"

exitstatus=$?
if [ $exitstatus -eq 0 ]; then
    if [ "$selection" == "" ]; then
        break
    else
    	version_tag=${selection#*.}
    	docker build --no-cache --tag=$USER/dxvk-builder:$version_tag - < $filename
		mkdir -p ~/dxvk-build/$version_tag
		export DXVK_DIR=~/dxvk-build/$version_tag
		docker run --volume=$DXVK_DIR:/root/bin/ --tty $USER/dxvk-builder:$version_tag
    fi
else
    echo "No File Selected."
fi
#!/bin/bash
clear

SCRIPT_DIR="$( cd "$( dirname "$0" )" && pwd )"
TOOL_DIR="$SCRIPT_DIR/tools"
FRAME_DIR="$TOOL_DIR/framework"
INPU_DIR="$SCRIPT_DIR/In"
OU_DIR="$SCRIPT_DIR/Out"
DO_DIR="$SCRIPT_DIR/Done"

title_ui() {

  clear
  echo "---------------------------------------------"
  echo "-       Advanced ApkTo0ol v1.0.0             -"
  echo "-            By wolfmannight                -"
  echo "---------------------------------------------"
  echo " "
  echo " "

}

# --------- Functions ------------

# Install framework
install_frame() {
  clear
  title_ui
  #UI Render
  echo "List of Apk inside In folder :";
  echo " "
  var=0;
  for file in "$INPU_DIR"/*; do

    path_array[$var]="$file"
    name_array[$var]="${file##*/}"


    echo "$var" "-" ${name_array[$var]};
    echo " "


    var=$((var+1));
  done

  echo " "
  echo "Enter the Number of apk to Decompile:"

  read USR_INPUT

  # Install framework
  clear
  title_ui
  echo "Installing framework..."
  echo " "
  echo "Log:"
  echo "----------"
  java -jar "$TOOL_DIR/apktool.jar" if -p "$FRAME_DIR" "${path_array[$USR_INPUT]}"



}

# Decompile
decompile_apk() {
  clear
  title_ui
  #UI Render
  echo "List of Apk inside In folder :";
  echo " "
  var=0;
  for file in "$INPU_DIR"/*; do

    path_array[$var]="$file"
    name_array[$var]="${file##*/}"


    echo "$var" "-" ${name_array[$var]};
    echo " "


    var=$((var+1));
  done

  echo " "
  echo "Enter the Number of apk to Decompile:"

  read USR_INPUT

  # Decompile
  clear
  title_ui
  echo "Decompiling file..."
  echo " "
  echo "Log:"
  echo "----------"
  java -jar "$TOOL_DIR/apktool.jar" d -f -o "$OU_DIR/${name_array[$USR_INPUT]}" "${path_array[$USR_INPUT]}"

}


# Recompile
recompile_apk() {
  clear
  title_ui
  #UI Render
  echo "List of Apk for Recompile :";
  echo " "
  var=0;
  for file in "$OU_DIR"/*; do

    de_folder_path_array[$var]="$file"
    de_folder_name_array[$var]="${file##*/}"


    echo "$var" "-" ${de_folder_name_array[$var]};
    echo " "


    var=$((var+1));
  done

  echo " "
  echo "Enter the Number of apk to Recompile:"


  read USR_INPUT

  # Recompile
  clear
  title_ui
  echo "Recompiling file..."
  echo " "
  echo "Log:"
  echo "----------"
  java -jar "$TOOL_DIR/apktool.jar" b -o "$DO_DIR/${de_folder_name_array[$USR_INPUT]}" -p "$FRAME_DIR" "${de_folder_path_array[$USR_INPUT]}"

}

#recompile_apk
sign_apk() {
  clear
  title_ui
  #UI Render
  echo "List of Apk for Sign :";
  echo " "
  var=0;
  for file in "$DO_DIR"/*; do

    do_apk_path_array[$var]="$file"
    do_apk_name_array[$var]="${file##*/}"


    echo "$var" "-" ${do_apk_name_array[$var]};
    echo " "


    var=$((var+1));
  done

  echo " "
  echo "Enter the Number of apk to Sign:"


  read USR_INPUT

  echo ${do_apk_path_array[$USR_INPUT]}

  # Sign
  clear
  title_ui
  echo "Signing file..."
  echo " "
  echo "Log:"
  echo "----------"
  "$TOOL_DIR/jarsigner" -keystore "$TOOL_DIR/AOSP.keystore" -storepass android "${do_apk_path_array[$USR_INPUT]}" platform

}

# --------- UI -----------
user_interface() {
title_ui

my_array=(
  "1 - Install Framework"
  " "
  "2 - Decompile Files"
  " "
  "3 - Recompile Files"
  " "
  "4 - Sign Files"
)

printf '%s\n' "${my_array[@]}"
echo " "
echo " "
echo '.----------------.'
echo '| Any key - Exit |'
echo '.----------------.'
echo " "
echo "Make A Choice And Press ENTER:";
read CHOISE



case $CHOISE in
	1)
		install_frame;;
	2)
		decompile_apk;;
	3)
		recompile_apk;;
  4)
  	sign_apk;;
	*) exit;;
esac

}

back_function() {
  echo " "
  echo "Enter the x to go back:"
  read BC_USR_INPUT
  if [ "$BC_USR_INPUT" = 'x' ]
    then
    user_interface;
  else
    exit 0
  fi
}

user_interface;
while :
    do
        back_function;
done

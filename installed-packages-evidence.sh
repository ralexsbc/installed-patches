#!/usr/bin/env bash
#
# installed-packages-evidence.sh - Collect evidence of installed packages in the remote server
#
# Autor:  Renato Alexandre da Rocha
# E-mail: renato.alexandre.da.rocha1@ibm.com / ralex.sbc@hotmail.com
#
# ------------------------------------------------------------------------------------------------- #
#  Collect evidence of installed packages in the remote server
#
#  Examples:
#      $ ./installed-packages-evidence.sh
# ------------------------------------------------------------------------------------------------- #
# Histórico:
#
#   v1.0 03/08/2022, Renato Alexandre da Rocha:
#       - Script developed
# ------------------------------------------------------------------------------------------------- #
# Tested in:
# 	RedHat Enterprise Linux Server 7.9
# 	Suse Linux Enterprise Server 12.5
# ------------------------------------------------------------------------------------------------- #
#
# ------------------------------- VARIABLES ------------------------------------------------------- #

_SERVER_LIST=server_list.txt
_REMOTE_USER=
_VERSION="v1.0"
_DIR_REPORT=result_scan
_DATE=$(date +'%Y-%m-%d')
_GREEN_COLOR="\033[32;1m"
_RED_COLOR="\033[31;1m"
_RESET_COLOR="\033[0m"
_ID=

# ------------------------------------------------------------------------------------------------- #
#
# ------------------------------- VALIDATIONS ----------------------------------------------------- #

# server_list.txt exist?
[ ! -f $_SERVER_LIST ] && echo -e "${_RED_COLOR}ERROR.:${_RESET_COLOR} File $_SERVER_LIST don't exit. Please contact the System Admin." && exit 1

# server_list.txt has read permission?
[ ! -r $_SERVER_LIST ] && echo -e "${_RED_COLOR}ERROR.:${_RESET_COLOR} File $_SERVER_LIST does haven't read permission. Please contact the System Admin." && exit 1

# server_list.txt is empty?
[ ! -s $_SERVER_LIST ] && echo -e "${_RED_COLOR}ERROR.:${_RESET_COLOR} File $_SERVER_LIST is empty. Please contact the System Admin." && exit 1

# Report directory exist?
[ ! -d $_DIR_REPORT ] && mkdir $_DIR_REPORT; chmod 770 $_DIR_REPORT

# --------------------------------------------------------------------------------------- #
#
# ------------------------------- FUNCTIONS ------------------------------------------------------- #

welcome_message () {
	echo
	echo "######################################################################################"
	echo "#"
	echo "# Collect evidence of installed packages in the remote server"
	echo "# "
	echo "# Version: $_VERSION"
	echo "#"
	echo "######################################################################################"
	echo
}

start_scan () {
	clear
	welcome_message

	## Inform the ID in the remote server
	echo "Please inform the remote ID to scan the server:"
	read _ID

	## Create directory to save the report
	mkdir -p $_DIR_REPORT/$_DATE

	while read _SERVER
	do
		_FILE_SCAN=$_DIR_REPORT/$_DATE/$_SERVER-installed_packages.txt
		echo "Date: $_DATE" > $_FILE_SCAN
		echo " " >> $_FILE_SCAN

		echo "Server: $_SERVER"
		echo "$_SERVER" >> $_FILE_SCAN
		echo "-----------------------------------------------------------------------------------------" >> $_FILE_SCAN
		ssh -l $_ID -o 'StrictHostKeyChecking no' $_SERVER "rpm -qa --last" >> $_FILE_SCAN

		if [ $? -eq 0 ];
		then
			echo -e "${_GREEN_COLOR}SUCCESS.:${_RESET_COLOR} Scan completed successfully in the $_SERVER"
			echo
		else
			echo -e "${_RED_COLOR}ERROR.:${_RESET_COLOR} Scan fail in the $_SERVER. Please contact the System Admin."
			echo
		fi

		echo

	done < $_SERVER_LIST

}

# --------------------------------------------------------------------------------------- #
#
# ------------------------------- EXECUTION ------------------------------------------------------- #

start_scan

# --------------------------------------------------------------------------------------- #


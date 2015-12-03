#!/bin/bash

#********************************************************************************
# Copyright 2014 IBM
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#********************************************************************************

#############
# Colors    #
#############
export green='\e[0;32m'
export red='\e[0;31m'
export label_color='\e[0;33m'
export no_color='\e[0m' # No Color

##################################################
# Simple function to only run command if DEBUG=1 # 
### ###############################################
debugme() {
  [[ $DEBUG = 1 ]] && "$@" || :
}

set +e
set +x 

function dra_logger {
    npm install grunt
    npm install grunt-cli
    npm install grunt-idra

    echo "DRA_PROJECT_KEY: ${DRA_PROJECT_KEY}"
    echo "event: ${DRA_EVENT_TYPE_1}"
    echo -e "└── file: ${DRA_FILE_1}"
    #echo -e "└── server: ${DRA_SERVER}"
    echo "event 2: ${DRA_EVENT_TYPE_2}"
    echo -e "└──file: ${DRA_FILE_2}"
    #echo -e "└──server: ${DRA_SERVER_2}"
    echo "event 3: ${DRA_EVENT_TYPE_3}"
    echo -e "└──file: ${DRA_FILE_3}"
    #echo -e "└──server: ${DRA_SERVER_3}"
    echo -e ""

    #dra_commands "${DRA_EVENT_TYPE_1}" "${DRA_FILE_1}" "${DRA_SERVER}"
    #dra_commands "${DRA_EVENT_TYPE_2}" "${DRA_FILE_2}" "${DRA_SERVER}"
    #dra_commands "${DRA_EVENT_TYPE_3}" "${DRA_FILE_3}" "${DRA_SERVER}"
    dra_commands "${DRA_EVENT_TYPE_1}" "${DRA_FILE_1}"
    dra_commands "${DRA_EVENT_TYPE_2}" "${DRA_FILE_2}"
    dra_commands "${DRA_EVENT_TYPE_3}" "${DRA_FILE_3}"


    
    #grunt --gruntfile=node_modules/grunt-idra/idra.js -eventType=istanbulCoverage -file=tests/coverage/reports/coverage-summary.json
    #grunt --gruntfile=node_modules/grunt-idra/idra.js -eventType=testComplete -deployAnalyticsServer=https://da-test.oneibmcloud.com    
}

function dra_commands {
    dra_grunt_command=""
    
    if [ -n "$1" ] && [ "$1" != " " ]; then
        echo "Event: '$1' is defined and not empty"
        
        dra_grunt_command="grunt --gruntfile=node_modules/grunt-idra/idra.js -eventType=$1"
        
        echo -e "\tdra_grunt_command: $dra_grunt_command"
        
        if [ -n "$2" ] && [ "$2" != " " ]; then
            echo -e "\tFile: '$2' is defined and not empty"
            
            dra_grunt_command="$dra_grunt_command -file=$2"
        
            echo -e "\t\tdra_grunt_command: $dra_grunt_command"
            
        else
            echo -e "\tFile: '$2' is not defined or is empty"
        fi
        #if [ -n "$3" ] && [ "$3" != " " ]; then
        #    echo -e "\tServer: '$3' is defined and not empty"
        #
        #    dra_grunt_command="$dra_grunt_command -deployAnalyticsServer=$3"
        #
        #    echo -e "\t\tdra_grunt_command: $dra_grunt_command"
        #
        #else
        #    echo -e "\tServer: '$3' is not defined or is empty"
        #fi
        
        echo -e "\tFINAL dra_grunt_command: $dra_grunt_command"
        echo ""
        
        eval $dra_grunt_command
    else
        echo "Event: '$1' is not defined or is empty"
    fi
}




custom_cmd

dra_logger









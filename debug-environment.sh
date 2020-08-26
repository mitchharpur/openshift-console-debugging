#!/bin/bash
#predefined colors
reset=`tput sgr0`
bold=`tput bold`

red="$(tput setaf 1)"                      # bright red text
green=$(tput setaf 2) 
darkcyan=$(tput setaf 6)                  # dim cyan text
cyan="$bold$darkcyan"                     # bright cyan text
gray=$(tput setaf 7)                      # dim white text
darkgray="$bold"$(tput setaf 0)           # bold black = dark gray text
white="$bold$gray"                        # bright white text
yellow=$(tput setaf 3);                   # dark yellow text

# checks the cluster status before requesting cluster information
checkClusterStatus(){
  declare loginError="You must be logged in"
  declare connectError="Unable to connect"
  # all Bourne-style shells support file descriptor reassignment i.e 2>&1
  # note: oc std error stream is redirected to std out stream in order to gep it
  declare status=$(oc status 2>&1 | head -n 1 )
  if [[ $status == *"$connectError"* ]]; then
    echo -e "\n${cyan} - Status           : ${red}${bold}$status${reset}"
    return 1
  fi
  if [[ $status == *"$loginError"* ]]; then
    echo -e "\n${cyan} - Status           : ${red}${bold}$status${reset}"
    return 2
  fi
  echo -e "\n${cyan} - Status           : ${green}${bold}Cluster Available : ${reset}${status}"
  return 0    
}
#configure environment variables and write them to a .env file 
configureDebugEnvironment(){
  # all Bourne-style shells support file descriptor reassignment i.e 2>&1
  # note: oc std error stream is redirected to std out stream in order to gep it
  #set the defaults
  local title="Console Cluster Information"
  local environmentFileName="debug-environment.env"
  local environmentFileContents=""
  local clusterUrl=""
  #default values
  local alertManagerUrl="https://alertmanager-main-openshift-monitoring.apps.gitops1.devcluster.openshift.com"
  local thanosUrl="https://thanos-querier-openshift-monitoring.apps.gitops1.devcluster.openshift.com"
  
  echo -e "\n${cyan}*** $title ***${reset}\n" 
  #check to see if cluster is available
  checkClusterStatus
  if [ $? -eq 0 ] # please note the space before and after the file content
    then
      #cluster is available
      clusterUrl=$(oc whoami --show-server)
      alertManagerUrl=$(oc -n openshift-config-managed get configmap monitoring-shared-config -o jsonpath='{.data.alertmanagerPublicURL}')
      thanosUrl=$(oc -n openshift-config-managed get configmap monitoring-shared-config -o jsonpath='{.data.thanosPublicURL}')
      #export the vars
      export CONSOLE_CLUSTER_URL="${clusterUrl}"
      export CONSOLE_ALERTMANAGER_URL="${alertManagerUrl}"
      export CONSOLE_THANOS_URL="${thanosUrl}"
    else
      declare clusterUrl=$(oc whoami --show-server)
      export CONSOLE_CLUSTER_URL="error-no-cluster-available"
      export CONSOLE_ALERTMANAGER_URL="error-no-cluster-alert-manager-available"
      export CONSOLE_THANOS_URL="error-no-cluster-thanos-available"
  fi
  #other misc env variables
  export CONSOLE_DEBUGGER_API_PORT=2345
  export CONSOLE_HOST_NAME=$HOSTNAME
  export CONSOLE_API_PORT=9000
  #build environment file contents
  environmentFileContents='# '$title' #note: no spaces before and after the  = sign '
  environmentFileContents=$environmentFileContents'\nCONSOLE_CLUSTER_URL='$CONSOLE_CLUSTER_URL
  environmentFileContents=$environmentFileContents'\nCONSOLE_ALERTMANAGER_URL='$CONSOLE_ALERTMANAGER_URL
  environmentFileContents=$environmentFileContents'\nCONSOLE_THANOS_URL='$CONSOLE_THANOS_URL
  
  environmentFileContents=$environmentFileContents'\nCONSOLE_HOST_NAME='$CONSOLE_HOST_NAME
  environmentFileContents=$environmentFileContents'\nCONSOLE_API_PORT='$CONSOLE_API_PORT
  environmentFileContents=$environmentFileContents'\nCONSOLE_DEBUGGER_API_PORT='$CONSOLE_DEBUGGER_API_PORT
  #pipe contents to the debug file
  echo -e $environmentFileContents > ./$environmentFileName
  echo -e "\n${cyan} - Cluster Url      : ${white}$CONSOLE_CLUSTER_URL"
  echo -e   "${cyan} - AlertManager Url : ${white}$CONSOLE_ALERTMANAGER_URL"
  echo -e   "${cyan} - Thanos Url       : ${white}$CONSOLE_THANOS_URL"
  
  echo -e "${cyan}\n*** End $title ***\n${reset}"

}

configureDebugEnvironment

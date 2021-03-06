#!/bin/bash
#predefined colors
reset=`tput sgr0`
bold=`tput bold`

red=$(tput setaf 1)                      # bright red text
green=$(tput setaf 2)
darkcyan=$(tput setaf 6)                  # dim cyan text
cyan=$bold$darkcyan                     # bright cyan text
gray=$(tput setaf 7)                      # dim white text
darkgray="$bold"$(tput setaf 0)           # bold black = dark gray text
white="$bold$gray"                        # bright white text
yellow=$(tput setaf 3)                   # dark yellow text

# checks the cluster status before requesting cluster information
checkClusterStatus(){
  declare loginError="You must be logged in"
  declare connectError="Unable to connect"
  declare configError="Missing or incomplete configuration info"

  # all Bourne-style shells support file descriptor reassignment i.e 2>&1
  # note: oc std error stream is redirected to std out stream in order to gep it
  declare fullStatus=$(oc status 2>&1 > /dev/null)
  declare status=${fullStatus%%$'\n'*}  #$($fullstatus | head -n 1 )
  if [[ $status == *"$connectError"* ]]; then
    echo -e "\n${cyan} - Status             : \n\n${red}${bold}$status${reset}"
    return 1
  fi
  if [[ $status == *"$loginError"* ]]; then
    echo -e "\n${cyan} - Status             : \n\n${red}${bold}$status${reset}"
    return 2
  fi
  if [[ $status == *"$configError"* ]]; then
    echo -e "\n${cyan} - Status             : \n\n${red}${bold}$fullStatus${reset}"
    return 3
  fi

  echo -e "\n${cyan} - Status             : ${green}${bold}Cluster Available : ${reset}${status}"
  return 0
}

# updates the  required certificate file in ./examples
function retrieveClusterCertificate(){
  echo -e "$yellow$bold"
  source ./debug-get-ca-certificate.sh
  echo -e "$reset"
}

# Updates the required secret retrieved from the cluster.
# Only works if the cluster has been logged into
function retrievClusterSecret(){
  # update resources retrieved from the cluster
  echo -e "$yellow$bold"
  source ./debug-get-oauth-secret.sh
  echo -e "$reset"
}


#checkClusterStatus
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
  status=$?
  # echo "checkClusterStatus = $status"
  if [[ $status -eq 0 ]] # please note the space before and after the file content
    then
      #cluster is available
      retrieveClusterCertificate
      retrievClusterSecret

      clusterUrl=$(oc whoami --show-server)
      alertManagerUrl=$(oc -n openshift-config-managed get configmap monitoring-shared-config -o jsonpath='{.data.alertmanagerPublicURL}')
      thanosUrl=$(oc -n openshift-config-managed get configmap monitoring-shared-config -o jsonpath='{.data.thanosPublicURL}')
      #export the vars
      export CONSOLE_CLUSTER_URL="${clusterUrl}"
      export CONSOLE_ALERTMANAGER_URL="${alertManagerUrl}"
      export CONSOLE_THANOS_URL="${thanosUrl}"
    else
      export CONSOLE_CLUSTER_URL="error-no-cluster-available"
      export CONSOLE_ALERTMANAGER_URL="error-no-cluster-alert-manager-available"
      export CONSOLE_THANOS_URL="error-no-cluster-thanos-available"
      # only invoke oc if it is configured
      if [[ $status -ne 3 ]];then
        export CONSOLE_CLUSTER_URL=$(oc whoami --show-server)
      fi
  fi
  # go version
  declare goVersion=$(go version | cut -d' ' -f3 )
  declare GOVERSION="Missing or incorrect go installation ..."
  if [[ $goVersion == "go"* ]]
  then
    GOVERSION=${goVersion#go}
  fi
  declare dlvVersion=$(dlv version | sed -n '2 p' 2>&1 )
  declare DELVEVERSION="Missing or incorrect delve debugger installation ..."

  # delve debugger version"
  if [[ $dlvVersion == "Version: "* ]]
  then
    DELVEVERSION=$(echo -e $dlvVersion|cut -d' ' -f2)
  fi

  export CONSOLE_DEBUGGER_API_PORT=2345
  export CONSOLE_HOST_NAME=0.0.0.0 # $HOSTNAME # using the host name still has some problems with server origin testing in backend ..i.e web can only be 'localhost'
  export CONSOLE_API_PORT=9000

  declare gitStatus=$(git status 2>&1 > /dev/null)
  if [[ $gitStatus == *"not a git repository"* ]]
  then
    GIT_TAG="0.0.0-no-version-found"
  else
    GIT_TAG=${SOURCE_GIT_TAG:-$(git describe --always --tags HEAD)}
  fi
  LD_FLAGS="'-X github.com/openshift/console/pkg/version.Version=${GIT_TAG}'"
  GC_FLAGS="'all=-N -l'"

  export CONSOLE_BUILD_FLAGS="-gcflags=${GC_FLAGS} -ldflags=${LD_FLAGS}"
  #create the environment file contents
  environmentFileContents='# '$title' #note: ensure ther are no spaces before and after the  = sign '
  environmentFileContents=$environmentFileContents'\nCONSOLE_CLUSTER_URL='$CONSOLE_CLUSTER_URL
  environmentFileContents=$environmentFileContents'\nCONSOLE_ALERTMANAGER_URL='$CONSOLE_ALERTMANAGER_URL
  environmentFileContents=$environmentFileContents'\nCONSOLE_THANOS_URL='$CONSOLE_THANOS_URL

  environmentFileContents=$environmentFileContents'\nCONSOLE_HOST_NAME='$CONSOLE_HOST_NAME
  environmentFileContents=$environmentFileContents'\nCONSOLE_API_PORT='$CONSOLE_API_PORT
  environmentFileContents=$environmentFileContents'\nCONSOLE_DEBUGGER_API_PORT='$CONSOLE_DEBUGGER_API_PORT
  environmentFileContents=$environmentFileContents'\nCONSOLE_BUILD_FLAGS='$CONSOLE_BUILD_FLAGS
  #pipe environment file contents to the debug-environement file
  echo -e "\n${bold}${yellow} - Environment File        :${white} ${environmentFileName}"
  echo -e "${yellow} - Go Version              : ${white}${GOVERSION}"
  echo -e "${yellow} - Delve Debugger Version  : ${white}${DELVEVERSION}"
  echo -e "${yellow} - Delve Debugger Api Port : ${white}${CONSOLE_DEBUGGER_API_PORT}"
  echo -e "${yellow} - Delve Debugger Host     : ${white}${CONSOLE_HOST_NAME}"
  echo -e "${cyan} - Console Version         : ${white}${GIT_TAG}"
  echo -e "${cyan} - Console Api Port        : ${white}${CONSOLE_API_PORT}"
  echo -e   "${cyan} - Cluster Url             : ${white}$CONSOLE_CLUSTER_URL"
  echo -e   "${cyan} - AlertManager Url        : ${white}$CONSOLE_ALERTMANAGER_URL"
  echo -e   "${cyan} - Thanos Url              : ${white}$CONSOLE_THANOS_URL"
  touch ./$environmentFileName
  echo -e $environmentFileContents > ./$environmentFileName

  echo -e "${cyan}\n*** End $title ***\n${reset}"

}
configureDebugEnvironment

# set -x
reset=$(tput sgr0)
bold=$(tput bold)

red=$(tput setaf 1)                     # bright red text
green=$(tput setaf 2)
darkcyan=$(tput setaf 6)                # dim cyan text
cyan=$bold$darkcyan                     # bright cyan text
gray=$(tput setaf 7)                    # dim white text
darkgray=$bold$(tput setaf 0)           # bold black = dark gray text
white=$bold$gray                        # bright white text
yellow=$(tput setaf 3)                  # dark yellow text

echo -e "$green$bold *** Downloading debug-*.sh files ... *** $reset"


repo="https://raw.githubusercontent.com/mitchharpur/openshift-console-debugging/master/"


function downloadVSCodeFile(){
  local fileName=$1
  local fileBaseName="${fileName%.*}";
  local fileExtension="${fileName##*.}";
  local fileFolder=".vscode/";
  local filePath="./$fileFolder$fileName";

  if [[ -f $filePath  ]]
  then
    # Make a copy of the old file in order not to overwrite any previous developer settings

    local backupName=$(mktemp -u $fileBaseName.old.XXXX.$fileExtension)
    if [[ $OSTYPE == "darwin" ]];then
      # Note: mac bsd implements mktemp differently
      backupName="$(basename $(mktemp -q  -t $fileBaseName.old).$fileExtension)"
    fi
    hasBackup=0
    # Check for the presence of existing backups
    if ls $fileFolder$fileBaseName.old.*.$fileExtension > /dev/null 2>&1
    then
      hasBackup=1
    fi
    # Only make the backup once to prevent a built up  of files
    if [[ $hasBackup -eq 0 ]]
    then
      echo -e "$red$bold Note: $fileName already exists .... making a backup of the existing $fileName into $backupName $reset"
      mv $filePath $fileFolder$backupName
    fi
  fi
  local url="$repo$fileFolder$fileName"
  # Download the file
  echo -e "$cyan Downloading $filePath $reset"
  curl -fSL $url -o $filePath
}

for shellScript in debug-{setup,attach,build,connect,clean,environment,get-ca-certificate,get-oauth-secret,launch,run,install-plugins}.sh
do
    # remove the file if it exists
    if [[ -f ./$shellScript ]]
    then
      rm ./$shellScript
    fi
    url="$repo$shellScript"
    echo -e  "$cyan Downloading $shellScript $reset"
    curl -LJO $url
    echo -e "$yellow$bold Setting $shellScript mode to be executable $reset"
    chmod u+x $shellScript
done
# Create the folder if it does not already exist
[[ -d ./.vscode ]] || mkdir ./.vscode
for file in {launch,tasks}.json
do
 downloadVSCodeFile $file
done
unset file

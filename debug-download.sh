reset=`tput sgr0`
bold=`tput bold`

red="$(tput setaf 1)"                      # bright red text
green=$(tput setaf 2) 
darkcyan=$(tput setaf 6)                  # dim cyan text
cyan="$bold$darkcyan"                     # bright cyan text
gray=$(tput setaf 7)                      # dim white text
darkgray="$bold"$(tput setaf 0)           # bold black = dark gray text
white="$bold$gray"                        # bright white text
yellow=$(tput setaf 3)                   # dark yellow text

repo="https://raw.githubusercontent.com/mitchharpur/openshift-console-debugging/master/"




function downloadVSCodeFile(){
  local fileName="$1"
  local fileBaseName="${fileName%.*}";
  local fileExtension="${fileName##*.}";
  local fileFolder=".vscode/";
  local filePath="./$fileFolder$fileName";
  
  if [[ -f $filePath  ]]
  then
    #make a copy of the old file in order not to overwrite any previous developer settings
    local backupName=$(mktemp -u $fileBaseName.old.XXXX.$fileExtension)
    echo "$red$bold Note: $fileName already exists .... making a backup of the existing $fileName into $backupName $reset"
    mv $filePath $fileFolder$backupName
  fi
  local url="$repo$fileFolder$fileName"
  #download the file file
  echo "$cyan Downloading $filePath $reset"
  curl -fSL $url -o $filePath
}

for shellScript in debug-{attach,build,connect,environment,get-ca-certificate,get-oauth-secret,launch,run,install-plugins}.sh
do
    if [[ -f ./$shellScript ]]
    then
      rm ./$shellScript
    fi
    url="$repo$shellScript"
    echo  "$cyan Downloading $shellScript $reset"
    curl -LJO $url
    echo "$yellow$bold Setting $shellScript mode to be executable $reset"
    chmod u+x $shellScript
done
# create the folder if it does not exist
[[ -d ./.vscode ]] || mkdir ./.vscode
for file in {launch,tasks}.json
do
 downloadVSCodeFile $file
done
unset file

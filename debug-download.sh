repo="https://raw.githubusercontent.com/mitchharpur/openshift-console-debugging/master/"

for shellScript in debug-{attach,build,connect,environment,get-ca-certificate,get-oauth-secret,launch,run}.sh
do
    if [ -f ./$shellScript ]
    then
        echo "Removing : $shellScript ..."
        rm ./$shellScript
    fi
    url="$repo$shellScript"
    echo "Downloading : $url ..."
    curl -LJO $url
    echo "Setting execute permissions : $shellScript ..."
    chmod u+x $shellScript
done
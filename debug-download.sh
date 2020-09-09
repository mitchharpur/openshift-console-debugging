repo="https://raw.githubusercontent.com/mitchharpur/openshift-console-debugging/blob/master/"

for shellScript in debug-{attach,build,connect,environment,get-ca-certificate,get-oauth-secret,launch,run}.sh
do
    url="$repo$shellScript"
    echo "Downloading : $url ..."
    curl -LJO $url
    echo "Setting permissions : $shellScript ..."
    chmod u+x $shellScript
done
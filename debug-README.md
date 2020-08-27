# debug-openshift-console
File overlays to help VS Code debugging of the openshift console repo.


# Instructions
- Read [debugging go](./docs/debugging/debugging-go.md)
- Make sure go and delve are installed
- Make sure the scripts are executable.
```sh
chmod u+x debug-build.sh
chmod u+x debug-launch.sh
chmod u+x debug-connect.sh
chmod u+x debug-environment.sh
chmod u+x debug-get-ca-certificate.sh
chmod u+x debug-get-oauth-secret.sh
```
- Make sure you are logged into an openshift cluster and get the login token something resembling the following:
```
oc login --token=7dDyxSKIumWvfkCWcwM_9A2vtwx8YiNEZsm9yyh-Ad0 --server=https://api.gitops2.devcluster.openshift.com:6443
```

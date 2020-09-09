# Openshift Console Debugging
File overlays to help VS Code debugging of the openshift console repo.


# Instructions
- Read [debugging go](./docs/debugging/debugging-go.md)
- Make sure go and delve are installed
- Make sure you are logged into an openshift cluster and get the login token from the user interface. It should resembling something similar to the following:
  ```sh
  oc login --token=7dDyxSKIumWvfkCWcwM_9A2vtwx8YiNEZsm9yyh-Ad0 --server=https://api.gitops2.devcluster.openshift.com:6443
  ```
- Download the debug-download script from the github repo and execute it

  ```sh
  curl -LJO https://raw.githubusercontent.com/mitchharpur/openshift-console-debugging/master/debug-download.sh
  chmod u+x debug-download.sh
  ./debug-download.sh
  ```



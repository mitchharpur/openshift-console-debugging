# Openshift Console Debugging
Debug shell script overlays to help debugging the [Openshift console](https://github.com/openshift/console) in VSCode.


# Instructions
- ## 1) Read [Debugging The Console](./docs/debugging/debugging-go.md)

- ## 2) Install the [required software](install-requirements.md)
  > <span style="color:red">Note :</span> Verify that $GOPATH is a valid value and ``` go version ; go env ``` return valid values
  > <span style="color:red">Note :</span> Verify that $GOPATH/bin is in the system path  
  > <span style="color:red">Note :</span> Verify that delve is installed  by checking if``` dlv version ``` returns a valid value

- ## 3) Setup Script 
  >From the project <span style="color:red">**workspace folder**</span>, paste the following into a macOS Terminal or Linux shell prompt.
  ```sh
  /bin/bash -c "$(curl -fSLO raw.githubusercontent.com/mitchharpur/openshift-console-debugging/master/debug-download.sh ; chmod u+x debug-download.sh ; ./debug-download.sh;)";
  
  ```
  
  - Note: You must be logged in to an openshift cluster. Get the login command with token from the user interface. It should resemble something similar to the following:
  ```sh
  oc login 
  --token=7dDyxSKIumWvfkCWcwM_9A2vtwx8YiNEZsm9yyh-Ad0 --server=https://api.gitops2.devcluster.openshift.com:6443
  ```



# Openshift Console Debugging
File overlays to help VS Code debugging of the openshift console repo.


# Instructions
- ## Read [Debugging The Console](./docs/debugging/debugging-go.md)

- ## Install the [required software](install-requirements.md)
- ## Add the debugging scripts
  
  Run the following script from the openshift console project root
  ```sh
  /bin/bash -c "$(curl -fSLO raw.githubusercontent.com/mitchharpur/openshift-console-debugging/master/debug-download.sh)";
  chmod u+x debug-download.sh ; 
  ./debug-download.sh;
  ls -al debug-*.sh; 
  ```

- Make sure you are logged into an openshift cluster and get the login token from the user interface. It should resembling something similar to the following:
  ```sh
  oc login --token=7dDyxSKIumWvfkCWcwM_9A2vtwx8YiNEZsm9yyh-Ad0 --server=https://api.gitops2.devcluster.openshift.com:6443
  ```



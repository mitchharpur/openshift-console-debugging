# Openshift Console Debugging
Debug shell script overlays to help debugging the [Openshift console](https://github.com/openshift/console) in VSCode.


# Instructions
- ## 1) Read [Debugging The Openshift Console](./docs/debugging/)
  > This document will help you to understand how go debugging works in both VSCode and the terminal, and how that information is used to setup integrated debugging for the openshift console.

- ## 2) Run the Debugging Setup Script
  >From the console VSCode <span style="color:red">**workspace folder**</span>, paste the following into a macOS Terminal or Linux shell prompt and press return. Its probably a good idea to do this on a seperate branch to ensure the scripts dont get checked into the master or primary branch.
  ```sh
  /bin/bash -c "$(curl -fSLO raw.githubusercontent.com/mitchharpur/openshift-console-debugging/master/debug-download.sh ; chmod u+x debug-download.sh ; )"; ./debug-download.sh;  ./debug-setup.sh


  ```


  - <span style="color:red;">***Note :***</span> You must be logged in to an openshift cluster. Get the login command with token from the user interface. It should resemble something similar to the following:
  ```sh
  oc login
  --token=7dDyxSKIumWvfkCWcwM_9A2vtwx8YiNEZsm9yyh-Ad0 --server=https://api.gitops2.devcluster.openshift.com:6443
  ```



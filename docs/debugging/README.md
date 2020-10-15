# Debugging the Openshift console
## Understanding the Openshift console
- ### [Overview](console-overview.md)
- ### [Respository](console-git-repository-structure.md)
## Debuggers
- ### [How debugging works](how-debugging-works.md)
## Setup
- ### [Install the go compiler](installing-go.md)
- ### [Install the delve debugger](installing-delve.md)
- ### [Install the jq utility](install-jq.md)
- ### [Install the required VSCode Extensions](install-vscode-extensions.md)
- ### Things to verify : 
  ```bash
  # These should all return valid values:
  echo $GOPATH;
  go version;
  go env;
  echo $PATH; #system path
  echo $GOPATH/bin; # should be in system path
  dlv version
  ```

## Build Considerations
- ### [Disabling optimizations in go binaries](building-go-for-debugging.md)
## Debugging
- ### [Debugging go from the terminal](debugging-go-from-the-terminal.md)
- ### [Debugging go from the IDE](debugging-go-from-the-ide.md)
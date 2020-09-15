- ## Install [Go](https://golang.org/doc/)
  - Mac
    - [Using direct download](https://golang.org/doc/install)
    - [Using homebrew](https://docs.brew.sh) : ``` brew install go ```
  - Fedora
    - [Using direct download](https://golang.org/doc/install)
    - [Using homebrew](https://docs.brew.sh/Homebrew-on-Linux) : ``` brew install go ```
    - [Using dnf](https://developer.fedoraproject.org/tech/languages/go/go-installation.h) ``` sudo dnf install golang  ``` . 
    > **Note:** dnf is the method to get the best results on fedora
  > **Note :** Verify that $GOPATH is set
  
  > **Test :** 
  ```sh
   go version # should print go version
   echo $GOPATH # should point to ~/go by befault ... unless specifically set otherwise
   go env # should contain valid path values ... yours may differ 
   ```

- ## Install [Delve Debugger](https://github.com/go-delve/delve)
  - Mac
    - [Install](https://github.com/go-delve/delve/blob/master/Documentation/installation/osx/install.md)
    
  - Fedora
    - [Install](https://github.com/go-delve/delve/blob/master/Documentation/installation/linux/install.md)
    > **Note :** Best results when delve is built


>**Note :** Verify that the delve executable is in the path. It is typically $GOPATH/bin

>**Test :** dlv version

- ## Install the [jq](https://stedolan.github.io/jq/download/) utility 
This utility extracts json fragments from json returned from the cluster.
  - Mac
    ```sh
    brew install jq
    ```
  - Fedora
    ```sh
    sudo dnf install jq
    ```

- ## Install needed [VSCode](https://code.visualstudio.com/docs/editor/command-line) extensions from the command line or terminal
  > Remember to [activate](https://github.com/golang/vscode-go/blob/master/docs/commands.md#go-installupdate-tools) the go extension as outlined in the [extension online documentation](https://marketplace.visualstudio.com/items?itemName=golang.Go).
  Check what extensions are installed
  ```sh
  #list vscode extensions to see what extensions are installed
  code --list-extensions
  ```
  Install the following VSCode extensions:
  ```sh
   # go extension
   code --install-extension google.go 
   # extension to read enviroment files for command substitution
   code --install-extension rioj7.command-variable
   # extension to invoke shell tasks
   code --install-extension augustocdias.tasks-shell-input
   # extension to color code env files
   code --install-extension mikestead.dotenv

  ```
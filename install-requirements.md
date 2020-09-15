- ## 1.Install [Go](https://golang.org/doc/)
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

- ## 2.Install [Delve Debugger](https://github.com/go-delve/delve)
  > **Note :** Ensure $GOPATH is correct before doing this !!!
  - Mac
    - [Install](https://github.com/go-delve/delve/blob/master/Documentation/installation/osx/install.md)
    ```sh
      go get github.com/go-delve/delve/cmd/dlv
    ```
    
  - Fedora
    - [Install](https://github.com/go-delve/delve/blob/master/Documentation/installation/linux/install.md)
    ```sh
      git clone https://github.com/go-delve/delve.git $GOPATH/src/github.com/go-delve/delve
      cd $GOPATH/src/github.com/go-delve/delve
      make install
    ```
    > **Note :** Best results when delve is built


>**Note :** Verify that the delve executable is in the path. It is typically $GOPATH/bin

>**Test :** 
```sh
dlv version
```

- ## 3.Install the [jq](https://stedolan.github.io/jq/download/) utility 
This utility extracts json fragments from json returned from the cluster.
  - Mac
    ```sh
    brew install jq
    ```
  - Fedora
    ```sh
    sudo dnf install jq
    ```

- ## 4.Install needed [VSCode](https://code.visualstudio.com/docs/editor/command-line) extensions from the command line or terminal
  > Remember to [activate](https://github.com/golang/vscode-go/blob/master/docs/commands.md#go-installupdate-tools) the go extension as outlined  in the [golang vscode extension online documentation](https://marketplace.visualstudio.com/items?itemName=golang.Go)**(i.e Ctrl+Shift+P in VSCode then type Go: Install/Update Tools)**. If the extensions are grayed out in VSCode extension viewer, then restart VSCode.
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
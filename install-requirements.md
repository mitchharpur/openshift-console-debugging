- ## Install [Go](https://golang.org/doc/)
  - Mac
    - [Using direct download](https://golang.org/doc/install)
    - [Using homebrew](https://docs.brew.sh) : ``` brew install go ```
  - Fedora
    - [Using direct download](https://golang.org/doc/install)
    - [Using homebrew](https://docs.brew.sh/Homebrew-on-Linux) : ``` brew install go ```
    - [Using dnf](https://developer.fedoraproject.org/tech/languages/go/go-installation.h) ``` sudo dnf install golang ```
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


- ## Install needed VSCode go extensions 
  Check what extensions are installed
  ```sh
  #list go extensions to see what extensions are installed
  code --list-extensions
  ```
  Install the following VSCode extensions:
  ```sh
   # go extension
   code --install-extension google.go 
   # extension to read enviroment files
   code --install-extension rioj7.command-variable
   # extension to invoke shell tasks
   code --install-extension augustocdias.tasks-shell-input
   # extension to color code env files
   code --install-extension mikestead.dotenv

  ```
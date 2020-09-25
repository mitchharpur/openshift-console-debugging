# Installing Go

If you do not have go installed, more detailed instructions can be found [here](https://golang.org/doc/install).

  - Mac
    - [Using direct download](https://golang.org/doc/install)
    ## [Using homebrew](https://docs.brew.sh)  

    ```sh
     brew install go
    ```
    This will yield something like the following:
    ![brew install](images/brew-install-go.jpg)
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
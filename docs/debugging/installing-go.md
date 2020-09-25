# Installing Go

More detailed instructions on installong go can be found [here](https://golang.org/doc/install).

  ## Mac
  There are several ways to install go on a mac
  ### 1.[Using homebrew](https://docs.brew.sh)

  ```sh
  brew install go
  ```
  This will yield something like the following:
  ![brew install](images/brew-install-go.jpg)
  ### 2.[Using direct download](https://golang.org/doc/install)

  ## Fedora
  There are several ways to install go on fedora

  ### 1.[Using dnf](https://developer.fedoraproject.org/tech/languages/go/go-installation.html)
  ```sh
  sudo dnf install golang
  ```
  > **Note:**  dnf is the method to get the best results on fedora
  ### 2.[Using direct download](https://golang.org/doc/install)

  ### 3.[Using homebrew](https://docs.brew.sh/Homebrew-on-Linux)

  ```sh
  brew install go
  ```

  # Verify your Go Installation
  ## Check go version
  ```sh
  go version # should print the go version
  ```
  The output will yield something similar to the following

  ![go version](images/go-version.jpg)

  ## Verify that $GOPATH is set to a valid location
  ```sh
  echo $GOPATH # should point to ~/go by befault ... unless specifically set otherwise
  go env # should contain valid path values ... yours may differ
  ```

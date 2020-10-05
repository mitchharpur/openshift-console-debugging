# Installing Go

If you are interested in installing go from source, more detailed instructions can be found [here](https://golang.org/doc/install). The instructions below focus on using the [homebrew](https://docs.brew.sh) package manager for a mac and [dnf](https://fedoraproject.org/wiki/DNF) for fedora linux . Note that [homebrew can now also be used on linux if so preferred](https://docs.brew.sh/Homebrew-on-Linux)

  ## Mac
  There are several ways to install go on a mac
  ### 1. [Using homebrew](https://docs.brew.sh)

  ```sh
  brew install go
  ```
  The output should display something similar to what is shown below:

  ![brew install](images/brew-install-go.jpg)
  ### 2. [Using direct download](https://golang.org/doc/install)

  ## Fedora
  There are several ways to install go on fedora

  ### 1. [Using dnf](https://developer.fedoraproject.org/tech/languages/go/go-installation.html)

  ```sh
  sudo dnf install golang
  ```
  The output should display something similar to what is shown below:

  ![dnf go install](images/dnf-install-go.jpg)

  ### 2. [Using direct download](https://golang.org/doc/install)

  ### 3. [Using homebrew](https://docs.brew.sh/Homebrew-on-Linux)

  ```sh
  brew install go
  ```

  # Verify the Go Installation
  ## 1. Check go version
  ```sh
  go version # should print the go version
  ```
  The output should display something similar to what is shown below, depending on the platform and version installed.
  - Mac
  ![go version mac](images/go-version.jpg)
  - Fedora
  ![go version linux](images/go-version-linux.jpg)

  ## 2. Verify that $GOPATH is set to a valid location
  ```sh
  echo $GOPATH # should point to ~/go by befault ... unless specifically set otherwise
  ```
  In the output below, the logged in user is 'developer'

  ![go path](images/go-path-linux.jpg)

  ## 3. Verify that your go evironment has valid path values
  ```sh
  go env # should contain valid path values ... yours may differ if you used homebrew , dnf or direct download
  ```
  ![go env](images/go-env-linux.jpg)

# Install needed [VSCode](https://code.visualstudio.com/docs/editor/command-line) extensions from the command line or terminal

> Remember to [activate](https://github.com/golang/vscode-go/blob/master/docs/commands.md#go-installupdate-tools) the go extension as outlined in the [golang vscode extension online documentation](https://marketplace.visualstudio.com/items?itemName=golang.Go) (i.e Ctrl+Shift+P in VSCode then type Go: Install/Update Tools). If the extensions are grayed out in VSCode extension viewer, then restart VSCode. 

Check what extensions are installed

```bash
#list vscode extensions to see what extensions are installed
code --list-extensions
```
Install the following VSCode Extensions

```bash
 # go extension
 code --install-extension google.go 
 # extension to read enviroment files for command substitution
 code --install-extension rioj7.command-variable
 # extension to invoke shell tasks
 code --install-extension augustocdias.tasks-shell-input
 # extension to color code env files
 code --install-extension mikestead.dotenv
```
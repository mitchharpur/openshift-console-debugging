# Debugging Go from the terminal
In order to debug a go program  from the terminal, there are two scenarios:
1) ### Launch
>Compile and lauch the binary in debug mode in one step.
2) ### Attach
>Attach the debugger to an already running go program that has been compiled with optimizations disabled.

## 1) Launch
To compile, launch, and debug a Go program from the terminal in one step, you can use the [dlv debug](https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_debug.md) command. 

It’s the easiest way to debug from the terminal. 

The dlv debug command automatically disables optimizations when compiling, so there is no need to remember which build flags to use. 

The delve debugger can be launched in **headless** mode or in **interactive** mode. 

**Interactive mode** means that interacting with the debugger is done directly from the terminal used to lauch the debug session.
**Headless mode** means that a seperate **debugger client** is used to interact with the debugger

VS Code can be used as a debugger client when the [Go for VS Code extension](https://marketplace.visualstudio.com/items?itemName=golang.go) is installed. 

The delve debugger can also function as a terminal based debugger client to an existing debugging session. This is achieved by using the **delve connect** command to connect to the debugging session running in headless mode in another terminal. It could be on the same machine or a remote machine, as long as the ports are accessible and there is an awareness of the security implications of exposing the debugger api port.

### Interactive Mode

To start an **interactive** terminal based debug session, use the **dlv debug** command:

![dlv debug](images/dlv-debug-1.jpg)

This debug command will compile the go **main package** source code in *./cmd/bridge/main.go*, and produce the executable binary in  *./bin/bridge*. 
If the comilation is successful, the debugger will then automatically **launch** and attach to the executable in a **paused** state. A paused state means that the executable will be started but will not run untill the **continue** command is issued

The *interactive terminal* output will resembling the following:

![dlv debug](images/dlv-debug-2.jpg)

From this terminal, it is possible to directly interact with the debugger and issue more debug commands as needed.

![dlv debug](images/dlv-debug-3.jpg)

A list of interactions and commands is outlined [here](https://github.com/go-delve/delve/blob/master/Documentation/cli/README.md) .

### Headless mode
When the delve debugger is launched in **headless mode**, it functions as a server that can receive debugger commands.

When the debugger is run in **headless mode**, it exposes a debugging api that can be accessed using a **debugger client**. The debugger client sends commands to the debugger via the api to control the debugging session.

#### Debugger Clients

##### [VSCode](https://code.visualstudio.com/)
VSCode can function as a **debugger client** for the delve debugger if the [go extensions for VS Code](https://marketplace.visualstudio.com/items?itemName=golang.Go) are installed. These vscode extensions have the capability to automatically launch the delve debugger in headless mode and [connect to the api](https://github.com/go-delve/delve/tree/master/Documentation/api), providing a great integrated debugger client experience.

##### [Goland](https://www.jetbrains.com/help/go/debugging-code.html)
The JetBrains Goland IDE also offer this debugger client functionality and user experience, but without the need for any extensions.

#### Multiple debugger clients

The IDE’s that have been mentioned have the capability to automatically launch the delve debugger, but you may want more fine grained control over this experience. To manually launch the delve debugger in headless mode, you must use the **--headless** flag. The **--accept-multiclient** flag is an extra optional options to use if there is a need to *simultaneously connect several debugger clients* to the debugger (i.e both the IDE and the delve terminal client). 

#### Custom API listening port
Finally, the **--listen** flag allows a specific location and port to be used to expose the API. This is specifically helpful when remote debugging, where firewall restrictions may be in place. Note that there are security implications of opening the debugging port.

#### Example
##### Launching the headless server
To run the debugger in **headless** mode, it would look something like this:

![dlv debug](images/dlv-debug-4.jpg)

![dlv debug](images/dlv-debug-5.jpg)

##### Passing in debuggee arguments
If the program being debugged (the debuggee) has any arguments, you would add them after the -- separator as highlighted in the above example . The bridge executable has several arguments, as shown in ./examples/run-bridge.sh. file

##### Connecting to the debug session
At this point you can connect to the headless server using the **delve connect** command from another terminal

![dlv debug](images/dlv-debug-6.jpg)

![dlv debug](images/dlv-debug-7.jpg)

In the headless scenario mentioned above, the debugger  is now:
- listening on port  2345  for any extra debugger clients (for --accept-multiclient )
- using  v2  of the api
- running in headless mode and accepts connections from multiple clients 
- logging output to the terminal
- started in the paused state (adding the **--continue** flag will start executing the code immediately)
- The debugger client ( VSCode, delve ,Jetbrains etc) issues debugging commands through the api
##### Debugger client commands
Once the debugger client is connected, you can continue to set break-points, step through the code, etc. 
Commands: 
- **c** - will continue execution of the executable
- **r** - will restart the debuggee process
- **b** main.main and then c - will set a breakpoint on the main package and continue to that point
Subsequent n - will step through the code. 
- **p** [variable name] - will print the value of the variable 
- **q** - will quit the debugging session. Note: If you are connected to a headless delve process via the dlv connect, typing q will prompt to end the headless server too.

The meaning of the various dlv debug flags are explained in more detail [here](https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv.md).

Interacting with a debugger from the terminal is outlined in more detail [here](https://github.com/go-delve/delve/blob/master/Documentation/cli/README.md).

## 2) Attach

The [delve attach](https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_attach.md) command enables the capability to debug a running process.
To manually attach to a running Go binary, if possible and for best results, first compile the binary with optimizations disabled:



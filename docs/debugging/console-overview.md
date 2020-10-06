# Overview

The OpenShift console application is composed of three major subsystems, each with its own stack of technologies and sub-systems. A web application (aka **frontend**), a cluster proxy (aka **backend**) and a user selected **Kubernetes cluster**. 

![console-overview](images/console-overview.jpg)

When running on the developers desktop, the backend binary process exposes port 9000 by default and functions as an api endpoint to the the static web application running in the browser. 
> Note: The static web application is served up by the console at port 9000 by default

The web application interacts with the backend endpoint using http and websocket traffic. These requests are then translated by the backend into requests to the selected openshift cluster. This is why you can think of the backend binary as a proxy to the kubernetes cluster

When the console is deployed to a cluster, it effectively runs in a pod, but more specifically as a [kubernetes operator](https://www.redhat.com/en/topics/containers/what-is-a-kubernetes-operator). It still functions as a proxy to the cluster it is running in. This is conceptually show below. Note how the "backend" is no running in a pod instead of a stand alone binary on the desktop

![console-overview-deployed](images/console-overview-deployed.jpg)

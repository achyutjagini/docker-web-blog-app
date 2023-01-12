
[Problem Statement 1](https://github.com/Teaching-Assistants-of-Cloud-Computing/CloudHack/tree/master/Problem%20Statement%201)

## File Structure
```
.
|-- README.md
|-- app
|   |-- app.py
|   |-- requirements.txt
|   `-- templates
|       |-- base.html
|       |-- create-post.html
|       |-- edit-post.html
|       `-- home.html
|-- configmap.yaml
|-- deployments.yaml
|-- flask-app-image.dockerfile
|-- secret.yaml
`-- services.yaml
```
The `app` directory contains all the code pertaining to the flask app. You are only required to configure the mongo connection string variables as specified in `app.py`.  
The `flask-app-image.dockerfile` should specify the insructions to assemble the docker image for the flask app.  
The `.yaml` files in the root directory are to specify the kubernetes manifests that will bring up your microservices deployment of the problem statement.

## Pre-Requisites:

**Note: The walkthrough in this README is for Ubuntu**

Make sure you have the following tools installed in your system:
1. Docker [Ubuntu](https://docs.docker.com/engine/install/ubuntu/#:~:text=Install%20from%20a%20package&text=Go%20to%20https%3A%2F%2Fdownload,version%20you%20want%20to%20install) 
2. Kubernetes [Ubuntu](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/)
3. Minikube [Ubuntu](https://minikube.sigs.k8s.io/docs/start/)

## How to Run
**1.** Clone the repository by typing the following in your terminal:
```
git clone https://github.com/075-082-094-110-CloudHack-1/CloudHack.git
```
**2.** Navigate inside `Cloudhack` folder & start a minikube cluster by typing the following:
```
minikube start
```
**3.** Run the `secret.yaml` file so that the secrets (admin credentials) can be referenced in our deployments:
```
kubectl create -f secret.yaml
```
**4.** Run the Deployments by typing the following: 
```
kubectl create -f deployments.yaml
```
**5.** Deploy the services by typing the following:
```
kubectl create -f services.yaml
```
**6.** Run the `configmap.yaml` for mongo-express to use as a reference: 
```
kubectl create -f configmap.yaml
```
**7.** Get the names of your pods by typing:
```
kubectl get pods
```
Copy the NAME of the three pods somewhere because we will use them in the next step. This is also where you can see the status of your pods, if the status of any of the pods is `ContainerCreating`, wait for a minute & type the above command again to see if your pods are ready or not. 

**8.** Now we will enable port forwarding on all the pods so that we can interact with the kubernetes cluster from localhost - this basically maps the container port to a local system port of your choice. Run the following in three different terminal windows:

For Flask-webapp:
```
kubectl port-forward pods/flask-app-deployment-(something) 5001:5001
```
For Mongo Express:
```
kubectl port-forward pods/mongo-express-deployment-(something) 8081:8081
```
For MongoDB Server:
```
kubectl port-forward pods/mongodb-deployment-(something) 27017:27017
```

**9.** Open your web-browser & type the relevant localhost address in your url bar: 
- `localhost:5001` to access the Flask App
- `localhost:8081` to access Mongo Express

**10.** To terminate, press `Ctrl + C` in the terminal window & run the following command to stop the minikube cluster:
```
minikube stop
```


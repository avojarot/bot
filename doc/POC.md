# Proof of Concept (PoC) for Deploying GitOps with ArgoCD on Kubernetes

## Introduction

This document outlines the steps to deploy a Proof of Concept (PoC) GitOps system using ArgoCD on the Kubernetes cluster chosen during the Concept stage. The objective is to demonstrate the technical feasibility of integrating ArgoCD with Kubernetes, allowing the team to manage application deployments via a GitOps workflow.

## Prerequisites

- A Kubernetes cluster (Minikube, Kind, or k3d)
- kubectl CLI configured to interact with your cluster
- Docker installed on your machine

## Step 1: Deploy Kubernetes Cluster

### Minikube

To start a Kubernetes cluster using Minikube, execute the following command:

minikube start --driver=docker

### Kind

For Kind, use this command to create a new cluster:

kind create cluster --name argocd

### k3d

To set up a k3d cluster, run:

k3d cluster create argocd

### Verify Cluster Status

Ensure your cluster is running by checking the nodes:

kubectl get nodes

## Step 2: Install ArgoCD

### Create ArgoCD Namespace

Create a namespace for ArgoCD:

kubectl create namespace argocd

### Apply ArgoCD Installation Manifest

Deploy ArgoCD in your Kubernetes cluster:

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

### Verify Installation

Check if the ArgoCD pods are up and running:

kubectl get pods -n argocd

## Step 3: Access ArgoCD Web Interface

### Port Forwarding for UI Access

Find the argocd-server service:

kubectl get svc -n argocd

Forward the port to make the ArgoCD UI accessible on your local machine:

kubectl port-forward svc/argocd-server -n argocd 8080:443

You can now access the ArgoCD interface at https://localhost:8080.

### Login to ArgoCD

Retrieve the initial password for the admin user:

kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d

Use admin as the username and the decoded password to log in.

## Conclusion

With the completion of this PoC, ArgoCD has been successfully deployed and configured on your Kubernetes cluster. The system is now ready for further development and integration into the MVP phase.

For further details on using ArgoCD, refer to the [official documentation](https://argo-cd.readthedocs.io/en/stable/).

## Repository Link

[Insert link to the repository here]

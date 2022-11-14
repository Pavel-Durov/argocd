SHELL = /bin/bash
KIND_CLUSTER := test
K8S_CONTEXT := kind-$(KIND_CLUSTER)

argo-init:
	kubectl create namespace argocd --context ${K8S_CONTEXT}
	kubectl apply -n argocd --context ${K8S_CONTEXT} -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml


port-forward:
	kubectl port-forward $(kubectl get pods | grep argocd-server | grep Running | awk '{print $1}') 8080:8080

k8s-unset-context:
	kubectl config delete-context ${K8S_CONTEXT}

kind-up:
	kind create cluster --image kindest/node:v1.24.0@sha256:0866296e693efe1fed79d5e6c7af8df71fc73ae45e3679af05342239cdc5bc8e \
		--name $(KIND_CLUSTER) --config ./infra/kind/kind-config.yaml
	kubectl config set-context --current --namespace=productdb-adapterapi

kind-down:
	kind delete cluster --name $(KIND_CLUSTER)

kind-list-loaded-docker-images:
	docker exec -it ${KIND_CLUSTER}-control-plane crictl images

kind-load:
	kind load docker-image <IMAGE> --name $(KIND_CLUSTER)

kind-status:
	kubectl get nodes -o wide
	kubectl get svc -o wide
	kubectl get pods -o wide --watch --all-namespaces

kind-describe:
	kubectl describe nodes
	kubectl describe svc

argo-app-list:
	argocd app list

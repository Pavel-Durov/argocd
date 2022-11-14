# argocd

My record of progression in GitOps cert.

[Examples](https://github.com/Pavel-Durov/gitops-certification-examples/blob/main/simple-app/deployment.yml)
## ArgoCD cli
### Deploy demo app

```shell
$ argocd app create demo \
--project default \
--repo https://github.com/codefresh-contrib/gitops-certification-examples \
--path "./simple-app" \
--dest-namespace default \
--dest-server https://kubernetes.default.svc
```
> The application will appear in the ArgoCD dashboard.

### Sync
```shell
$ argocd app sync demo
```

## Resources
- https://learning.codefresh.io/path-player?courseid=gitops-with-argo
- https://opengitops.dev/
- https://github.com/argoproj-labs/argocd-autopilot
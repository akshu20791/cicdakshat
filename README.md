Step 5: Clean UP
Uninstall helm chart:
helm uninstall monitoring --namespace monitoring
Delete namespace:
kubectl delete ns monitoring
Delete Cluster & everything else:
eksctl delete cluster --name observability# devops-automation
this is end to end automation

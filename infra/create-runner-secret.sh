export REPO_URL=https://github.com/msraoudh/workshop-k8s
export RUNNER_TOKEN=BEIHWNVPH3ZGSA6M3OW4UV3IWSMP2

kubectl -n gha-runners create secret generic gha-runner-secrets \
  --from-literal=REPO_URL=$REPO_URL \
  --from-literal=RUNNER_TOKEN=$RUNNER_TOKEN

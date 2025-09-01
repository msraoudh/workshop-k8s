NAMESPACE=gha-runners
SA=gh-actions-deployer


CLUSTER=$(kubectl config view --minify -o jsonpath='{.clusters[0].name}')
SERVER=$(kubectl config view --minify -o jsonpath='{.clusters[0].cluster.server}')
CA_DATA=$(kubectl config view --raw --minify -o jsonpath='{.clusters[0].cluster.certificate-authority-data}')

TOKEN=$(kubectl -n $NAMESPACE create token $SA --duration=24h)

cat > kubeconfig-actions <<EOF
apiVersion: v1
kind: Config
clusters:
 - cluster:
      certificate-authority: /home/medsaid/.minikube/ca.crt
      extensions:
      - extension:
          last-update: Mon, 01 Sep 2025 18:23:08 UTC
          provider: minikube.sigs.k8s.io
          version: v1.36.0
        name: cluster_info
      server: https://192.168.58.2:8443
    name: minikube
contexts:
- context:
    cluster: minikube
    namespace: ${NAMESPACE}
    user: deployer
  name: deploy
current-context: deploy
users:
- name: deployer
  user:
    token: ${TOKEN}
EOF

base64 -w0 kubeconfig-actions > kubeconfig.b64
# quick view (optional)
cat kubeconfig.b64

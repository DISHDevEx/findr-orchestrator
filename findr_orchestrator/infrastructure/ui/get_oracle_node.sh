#install jq for mac
brew install jq

#get node port of oracle service
NODE_PORT=$(kubectl get service -n oracle oracle-service -o=jsonpath='{.spec.ports[0].nodePort}')

#get node ip of oracle pod
POD_NAME=$(kubectl get pod -n oracle -l app=oracle -o jsonpath='{.items[0].metadata.name}')
NODE_NAME=$(kubectl get pod $POD_NAME -n oracle -o jsonpath='{.spec.nodeName}')
NODE_IP=$(kubectl get node $NODE_NAME -o jsonpath='{.status.addresses[?(@.type=="ExternalIP")].address}')

#create oracle URL
ORACLE_URL="http://${NODE_IP}:${NODE_PORT}/oracle"  

#create json to set as external data in terraform
jq -n --arg oracle_url "$ORACLE_URL" '{"oracle_url":$oracle_url}'

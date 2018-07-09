//To open the kubernetes proxy for accessing the kubernetes dashboard:

kubectl proxy --address <<master-IP>> --accept-hosts='^*$'
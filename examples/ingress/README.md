## run pod temp
```
kubectl run tmp-shell --restart=Never --rm --tty -i --image nginx -- /bin/bash
apt-get update && apt-get install -y iputils-ping
```

## curl
```
curl --location 'http://ae95dfe9efdd5460eb8bf36fe89dd17f-1d56ccb12a0d4646.elb.us-west-2.amazonaws.com/persona-v1/person/hi'

curl --location 'http://ae95dfe9efdd5460eb8bf36fe89dd17f-1d56ccb12a0d4646.elb.us-west-2.amazonaws.com/persona-v1/person' --header 'Content-Type: application/json' --data '{
    "dni": "12345678",
    "name": "will",
    "lastname": "ape",
    "fathername" : "fathername",
    "age": 30
}'
```
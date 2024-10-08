## run pod temp
```
kubectl run tmp-shell --restart=Never --rm --tty -i --image nginx -- /bin/bash
apt-get update && apt-get install -y iputils-ping
```

## curl
```
curl --location 'http://a4f46bee2342a4bf9ac19cda93ed8ddb-52a3589d64c66a6b.elb.us-west-2.amazonaws.com/persona-v1/person/hi'
curl --location 'http://a4f46bee2342a4bf9ac19cda93ed8ddb-52a3589d64c66a6b.elb.us-west-2.amazonaws.com/persona-v1/person' --header 'Content-Type: application/json' --data '{
    "dni": "12345678",
    "name": "will",
    "lastname": "ape",
    "fathername" : "fathername",
    "age": 30
}'
```
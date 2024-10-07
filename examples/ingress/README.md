# curl
```
curl --location 'http://ae36f971db3b041cc977f1df3dc82091-7ccee452db6ab952.elb.us-west-2.amazonaws.com/persona-v1/person' \
--header 'Content-Type: application/json' \
--data '{
    "dni": "12345678",
    "name": "will",
    "lastname": "ape",
    "fathername" : "fathername",
    "age": 30
}'
```
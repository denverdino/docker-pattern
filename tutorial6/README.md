# About

This folder contains the artifacts to setup the secure Docker Registry

We will leverage Nginx to play as the HTTPS proxy for the Docker Registry and enable the secure access. All the artifacts for configuration can be found in "nginx" folder. 


# Generate password file for authentication

The follow command is used to create the password file with initial username/password.

```sh
cd nginx
htpasswd -bc docker-registry.htpasswd USERNAME PASSWORD
```

Or add additional user to the configuration file

```sh
htpasswd -b docker-registry.htpasswd USERNAME1 PASSWORD1
```


# Generate SSL certs and keys

We will leverage Nginx to play as the HTTPS proxy for the Docker Registry and enable the secure access. All the artifacts for configuration can be found in "nginx" folder. 

1) First let’s generate a new root key:

```sh
openssl genrsa -out dockerCA.key 2048
```

2) Generate a root certificate  and enter whatever you'd like at the prompts:

```sh
openssl req -x509 -new -nodes -key dockerCA.key -days 10000 -out dockerCA.cert
```

3) Generate a private key file for your server and copy it to /etc/ssl/private/docker-registry for Nginx to use:

```sh
openssl genrsa -out docker-registry.key 2048
```
 
4) Now we make a server certificate signing request, and OpenSSL will prompt you to answer a few questions. Do not enter a challenge password in the questions.

```sh
openssl req -new -key docker-registry.key -out docker-registry.csr
```
 
5) Finally we need to sign the certificate request, create the server certificate and copy this file to /etc/ssl/certs/docker-registry for Nginx to use:
 
```sh
openssl x509 -req -in docker-registry.csr -CA dockerCA.cert -CAkey dockerCA.key -CAcreateserial -out docker-registry.cert -days 1000
```


# References


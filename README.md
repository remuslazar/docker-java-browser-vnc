docker-java-browser-vnc
====

Abstract
----

A VNC enabled Docker Container to run the Firefox browser with an older Java JRE.


Purpose
----

To access older Web-Interfaces, e.g. IPMI Interface of older Supermicro
Motherboards.

Usage
----

Start the Docker Container

```
docker run --rm -e IMPORT_GITHUB_PUB_KEYS=remuslazar \
  -p 5900:5900 -p 1122:22 remuslazar/java-browser-vnc
```

#### SSH to the Container

```
ssh -p1122 alpine$(docker-machine ip $DOCKER_MACHINE_NAME)
```

Then, inside the container

#### Start e.g. firefox

```
firefox
```

#### Or, use Chrome

```
apk --no-cache add chromium
chromium-browser --no-sandbox
```

#### Run Java Web Start

To run the Java Web Start files (`*.jnlp`) you can use the javaws binary, which
is available in `$PATH`, e.g. using:

```
javaws ~/Downloads/launch.jnlp
```

Build Docker Image
----

```
docker build -t remuslazar/java-browser-vnc .
```

Author
----

Remus Lazar <rl at cron dot eu>

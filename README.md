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

SSH to the Container

```
ssh -p1122 alpine$(docker-machine ip $DOCKER_MACHINE_NAME)
```

Then, inside the container, start e.g. firefox

```
export DISPLAY=:99
firefox
```

Or, use Chrome

```
apk --no-cache add chromium
chromium-browser --no-sandbox
```

Build
----

```
docker build -t remuslazar/java-browser-vnc .
```

Author
----

Remus Lazar <rl at cron dot eu>

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

```
docker run --rm -e IMPORT_GITHUB_PUB_KEYS=remuslazar \
  -p 5900:5900 -p 1122:22 remuslazar/java-browser-vnc
```

Build
----

```
docker build -t remuslazar/java-browser-vnc .
```

Author
----

Remus Lazar <rl at cron dot eu>

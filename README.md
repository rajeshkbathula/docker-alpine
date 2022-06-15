# alpine  docker image with aws and asdf version control

>> PREREQVISITS: DOCKER DESKTOP VERSION > 3.x

* Only first time its required
```bash
docker build -t alpine-image .
```

* which project you want to execute replace that with your project absolute path as mentioned and run below command
```bash
docker run -it -v ~/.aws:/root/.aws -v <your-project>:/src/<your-project>  alpine-image:latest bash 
```

* Execute below command to install terraform required version
```bash
asdf install terraform <version>
``` 
example `asdf install terraform 0.13.5`
NOTE: Different version of terraform can be installed in similar fashion

* Execute below command to set specific terraform version to that terminal
```bash
asdf local terraform <version>
``` 
example `asdf local terraform 0.13.5`

then execute below steps to get into project and export aws profile 

```bash
export AWS_PROFILE=<AWS PROFILE>
cd /src/
```


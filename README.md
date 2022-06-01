# ubuntu-docker


only first time its required
```bash
docker build -t terraform-image .
```

which project you want to execute replace that with your project absolute path as mentioned and run below command
```bash
docker run -it -v ~/.aws:/root/.aws -v <your-project>:/src/<your-project>  terraform-image:latest bash 
```

then execute below steps to get into project and export aws profile 

```bash
export AWS_PROFILE=<AWS PROFILE>
cd /src/
```


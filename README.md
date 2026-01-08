# ollama-perplexica


## Docker compose to run multiple containers


Run a self-hosted LLm workflow with Ollama and Perplexica in Docker with Docker compose.

```
docker compose up -d
```

Visit http://localhost:8080 in your browser to access Ollama-webui.


Visit http://localhost:3000 in your browser to access Perplexica.



## Pre-load the docker with models

```
docker build -t tombrazier/ollama-models .
```

## Change where to save docker images

Docker images take a lot of storage (> 4GB) and your system partition may have limiting quotas. Hence, you may need to store docker images in a custom repository.

See https://evodify.com/change-docker-storage-location/


```
service docker stop
```

Modify the file `/etc/docker/daemon.json`

```
{
"data-root": "/mnt/newlocation"
}
```


```
system docker start
```

## build the docker and push to dockerhub

https://docs.docker.com/guides/reactjs/configure-github-actions/


## References

https://github.com/ItzCrazyKns/Perplexica

https://namrata23.medium.com/run-llms-locally-or-in-docker-with-ollama-ollama-webui-379029060324

https://github.com/mythrantic/ollama-docker

https://www.datacamp.com/fr/tutorial/docker-ollama-run-llms-locally

https://docs.docker.com/compose/intro/compose-application-model/

https://medium.com/@rosgluk/choosing-best-llm-for-perplexica-1bd179596739

https://github.com/ItzCrazyKns/Perplexica/discussions/312

https://ollama.readthedocs.io/en/faq/?h=default+context#how-do-i-use-ollama-behind-a-proxy
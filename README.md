# ollama-perplexica


## Features


TODO
* config Ollama context length
* RAGflow
* lightRAG
* Openwebui custom pipeline integration


## Models

- Chat model: `gemma3:4b`, `mistral:7b`, `llama3:8b`
- Embedding model: `nomic-embed-text-v1`


## Docker compose to run multiple containers


Run a self-hosted LLM workflow with Ollama and OpenWebUI in Docker with Docker compose.

```
git clone https://github.com/mythrantic/ollama-docker.git

docker compose up -d
```

Visit `http://localhost:8080` in your browser to access Ollama-webui.



Check olama is running at `http://127.0.0.1:11434/` adn get API tags with `curl http://127.0.0.1:11434/api/tags`. In API tags you can get the "remote_host" (e.g. https://ollama.com:443) to use in Perplexica `Add connection`.


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
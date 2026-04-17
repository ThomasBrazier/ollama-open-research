# ollama-perplexica


## Features

Actually, after running `docker compose up`, you can:
* Use Ollama (API `http://127.0.0.1:11434/`)
* Run a local AI chat with Openwebui [http://localhost:8080](http://localhost:8080)
* Select one of the preloaded models (downloaded at first run, can be long)
* All your history and database are saved locally in volumes (see `docker-compose.yaml` for volumes path)




TODO
* Comprehensive documentation and personalization
* Add CUDA/GPU support
* Add CI/CD. Github actions
* config Ollama context length
* RAGflow
* lightRAG
* Integrate Feynman, The open source AI research agent: https://github.com/getcompanion-ai/feynman
* Activate Agentic mode in Openwebui
* Openwebui custom pipeline integration
* Add NotebookLlama support (https://notebooklama.com/)


## Configuration

`Chat Control` -> `System Prompt` : where to save your system prompt. Generally you describe the role and define the functions of the LLM in this prompt, e.g., 'You are a research assistant and I need you to find relevant sources and summarize them in a formal academic tone.'

Also found in `Settings` -> `WebUI Settings` -> `System Prompt` to set it permanently.


### Agentic Mode and Web search

[https://docs.openwebui.com/features/extensibility/plugin/tools/#tool-calling-modes-default-vs-native](https://docs.openwebui.com/features/extensibility/plugin/tools/#tool-calling-modes-default-vs-native)


Go to `Admin Panel` -> `Settings` -> `Models` -> `Advanced Params` -> `Function Calling` -> `Native`





* [https://github.com/open-webui/open-webui/discussions/15614](https://github.com/open-webui/open-webui/discussions/15614)
* [https://docs.openwebui.com/features/chat-conversations/web-search/agentic-search/](https://docs.openwebui.com/features/chat-conversations/web-search/agentic-search/)

"Agentic web search works best with frontier models like GPT-5, Claude 4.5+, Gemini 3+, or MiniMax M2.5 that can reason about search results and decide when to dig deeper. Small local models may struggle with the multi-step reasoning required."



## Models

The list of models to preload at first run is in `models.txt`. By default:

- Chat model: `gemma4:latest`, `gemma3:4b`, `mistral:7b`, `llama3:8b`
- Embedding model: `nomic-embed-text-v1`




To check which models you can run on your local machine:

hf-mem (https://github.com/alvarobartt/hf-mem)

With `uv` installed, run:

```
uvx hf-mem --model-id google/gemma-4-E4B
```

Alternatively, to compare all available models:

llmfit (https://github.com/AlexsJones/llmfit)

```
# Install locally
curl -fsSL https://llmfit.axjns.dev/install.sh | sh -s -- --local

llmfit
```


## Docker compose to run multiple containers


Run a self-hosted LLM workflow with Ollama and OpenWebUI in Docker with Docker compose.

```
docker compose up -d
```

Visit `http://localhost:8080` in your browser to access Ollama-webui.



Check `Ollama` is running at `http://127.0.0.1:11434/` adn get API tags with `curl http://127.0.0.1:11434/api/tags`. In API tags you can get the "remote_host" (e.g. https://ollama.com:443) to use in Perplexica `Add connection`.



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

## Build the docker and push to dockerhub

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

https://github.com/mythrantic/ollama-docker
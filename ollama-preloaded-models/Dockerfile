FROM ollama/ollama:latest AS builder

# Copy the loading script to the docker image
COPY ./ollama_preload.sh /ollama_preload.sh
COPY ./models.txt /models.txt

# Ensure the script is executable
RUN chmod +x /ollama_preload.sh
RUN bash /ollama_preload.sh

# Final image
FROM ollama/ollama:latest

# Copy preloaded model cache
COPY --from=builder /root/.ollama /root/.ollama

# Expose Ollama port
EXPOSE 11434

CMD ["ollama", "serve"]
FROM ollama/ollama:latest AS builder

# Start Ollama server in background and wait for it to become ready
RUN nohup ollama serve > /tmp/ollama.log 2>&1 & \
    sleep 10 && \
    ollama pull gemma3:4b

# Final image
FROM ollama/ollama:latest

# Copy preloaded model cache
# COPY --from=builder /root/.ollama /root/.ollama

# Expose Ollama port
EXPOSE 11434

# FROM ollama/ollama:latest

# RUN ollama serve & sleep 5 && ollama pull gemma3:4b && pkill ollama

# EXPOSE 11434

CMD ["ollama", "serve"]
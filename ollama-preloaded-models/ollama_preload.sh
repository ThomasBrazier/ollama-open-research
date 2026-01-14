#!/bin/bash

# Start Ollama in the background.
/bin/ollama serve &
# Record Process ID.
pid=$!

# Pause for Ollama to start.
sleep 15

echo "🔴 Retrieve Ollama models..."
while read -r model; do
  ollama pull "$model"
done < models.txt
echo "🟢 Done!"

# Wait for Ollama process to finish.
wait $pid

# Source - https://stackoverflow.com/a
# Posted by M E, modified by community. See post 'Timeline' for change history
# Retrieved 2026-01-14, License - CC BY-SA 4.0

#!/bin/bash

# Start Ollama in the background.
/bin/ollama serve &
# Record Process ID.
pid=$!

# Pause for Ollama to start.
sleep 5

echo "🔴 Retrieve Ollama models..."
while read -r model; do
  ollama pull "$model"
done < models.txt
echo "🟢 Done!"

# Wait for Ollama process to finish.
wait $pid

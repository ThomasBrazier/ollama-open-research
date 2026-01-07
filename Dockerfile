FROM ollama/ollama:latest

# Install Perplexica
RUN apt-get update && apt-get install -y python3 python3-pip sqlite3 git nodejs npm && rm -rf /var/lib/apt/lists/*
RUN npm install --global yarn

WORKDIR /home/perplexica

RUN git clone https://github.com/ItzCrazyKns/Perplexica.git

RUN cp ./Perplexica/package.json Perplexica/yarn.lock ./
RUN yarn install --frozen-lockfile --network-timeout 600000

RUN cp ./Perplexica/tsconfig.json Perplexica/next.config.mjs Perplexica/next-env.d.ts Perplexica/postcss.config.js Perplexica/drizzle.config.ts Perplexica/tailwind.config.ts ./
RUN cp ./Perplexica/src ./src
RUN cp ./Perplexica/public ./public
RUN cp ./Perplexica/drizzle ./drizzle

RUN mkdir -p /home/perplexica/data
RUN yarn build

RUN apt-get update && apt-get install -y \
    python3-dev python3-babel python3-venv python-is-python3 \
    uwsgi uwsgi-plugin-python3 \
    git build-essential libxslt-dev zlib1g-dev libffi-dev libssl-dev \
    curl sudo \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /home/perplexica

RUN cp ./Perplexica/public ./public
RUN cp ./Perplexica/perplexica/.next/static ./public/_next/static
RUN cp ./Perplexica/.next/standalone ./
RUN cp ./Perplexica/data ./data
RUN cp ./Perplexica/drizzle ./drizzle

RUN mkdir /home/perplexica/uploads

RUN useradd --shell /bin/bash --system \
    --home-dir "/usr/local/searxng" \
    --comment 'Privacy-respecting metasearch engine' \
    searxng

RUN mkdir "/usr/local/searxng"
RUN mkdir -p /etc/searxng
RUN chown -R "searxng:searxng" "/usr/local/searxng"

RUN cp ./Perplexica/searxng/settings.yml /etc/searxng/settings.yml
RUN cp ./Perplexica/searxng/limiter.toml /etc/searxng/limiter.toml
RUN cp ./Perplexica/searxng/uwsgi.ini /etc/searxng/uwsgi.ini
RUN chown -R searxng:searxng /etc/searxng

USER searxng

RUN git clone "https://github.com/searxng/searxng" \
                   "/usr/local/searxng/searxng-src"

RUN python3 -m venv "/usr/local/searxng/searx-pyenv"
RUN "/usr/local/searxng/searx-pyenv/bin/pip" install --upgrade pip setuptools wheel pyyaml msgspec
RUN cd "/usr/local/searxng/searxng-src" && \
    "/usr/local/searxng/searx-pyenv/bin/pip" install --use-pep517 --no-build-isolation -e .

USER root

WORKDIR /home/perplexica
RUN cp ./Perplexica/entrypoint.sh ./entrypoint.sh
RUN chmod +x ./entrypoint.sh
RUN sed -i 's/\r$//' ./entrypoint.sh || true

RUN echo "searxng ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

EXPOSE 3000 8080

ENV SEARXNG_API_URL=http://localhost:8080

CMD ["/home/perplexica/entrypoint.sh"]

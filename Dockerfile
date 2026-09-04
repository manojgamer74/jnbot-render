FROM node:20-bookworm

WORKDIR /app

RUN apt-get update && \
    apt-get install -y wget unzip ca-certificates && \
    rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/usserwout/JNbot-updater/releases/download/v3.2.2/cli.zip -O cli.zip && \
    unzip -o cli.zip && \
    chmod +x ./jnbot && \
    rm cli.zip

CMD ["./jnbot", "--jnbot-server"]

FROM node:20-bookworm

WORKDIR /app

RUN apt-get update && \
    apt-get install -y wget unzip ca-certificates && \
    rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/usserwout/JNbot-updater/releases/download/v3.2.2/cli.zip -O cli.zip && \
    unzip -o cli.zip && \
    chmod +x ./jnbot && \
    rm cli.zip

COPY <<'EOF' server.js
const http = require("http");
const { spawn } = require("child_process");

const port = process.env.PORT || 10000;

http.createServer((req, res) => {
    res.writeHead(200, {"Content-Type": "text/plain"});
    res.end("JNbot is running");
}).listen(port, "0.0.0.0");

const bot = spawn("./jnbot", ["--jnbot-server"], {
    stdio: "inherit"
});

bot.on("exit", code => {
    console.log("JNbot exited:", code);
});
EOF

CMD ["./jnbot", "serve"]

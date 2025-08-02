# Dockerfile Command Cheatsheet

# Create non-root user
RUN adduser -D -s /bin/sh myuser

# Switch to non-root user  
USER myuser

## Core Instructions

| Command | When | Purpose | Example |
|---------|------|---------|---------|
| `FROM` | Build | Base image | `FROM ubuntu:22.04` |
| `RUN` | Build | Execute commands | `RUN apt-get update && apt-get install -y nginx` |
| `COPY` | Build | Copy files from host | `COPY ./app /usr/src/app` |
| `ADD` | Build | Copy + extract/download | `ADD app.tar.gz /usr/src/` |
| `WORKDIR` | Build | Set working directory | `WORKDIR /usr/src/app` |
| `CMD` | Runtime | Default command (overrideable) | `CMD ["nginx", "-g", "daemon off;"]` |
| `ENTRYPOINT` | Runtime | Fixed command | `ENTRYPOINT ["/entrypoint.sh"]` |
| `EXPOSE` | Documentation | Document ports | `EXPOSE 80 443` |

## Environment & Variables

| Command | Purpose | Example |
|---------|---------|---------|
| `ENV` | Set environment variables | `ENV NODE_ENV=production` |
| `ARG` | Build-time variables | `ARG VERSION=latest` |
| `USER` | Switch user context | `USER nginx` |

## Advanced Instructions

| Command | Purpose | Example |
|---------|---------|---------|
| `VOLUME` | Declare mount points | `VOLUME ["/data"]` |
| `LABEL` | Add metadata | `LABEL maintainer="you@example.com"` |
| `HEALTHCHECK` | Container health monitoring | `HEALTHCHECK CMD curl -f http://localhost/` |
| `ONBUILD` | Trigger for child images | `ONBUILD COPY . /app` |
| `SHELL` | Change default shell | `SHELL ["/bin/bash", "-c"]` |

## Best Practices

### Layer Optimization
```dockerfile
# Bad - creates multiple layers
RUN apt-get update
RUN apt-get install -y nginx
RUN apt-get clean

# Good - single layer
RUN apt-get update && \
    apt-get install -y nginx && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
```

### Multi-stage Builds
```dockerfile
# Build stage
FROM node:16 AS builder
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Production stage
FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html
```

### Security
```dockerfile
# Don't run as root
RUN adduser --disabled-password --gecos '' appuser
USER appuser

# Use specific versions
FROM ubuntu:22.04

# Minimize attack surface
RUN apt-get update && \
    apt-get install -y --no-install-recommends nginx && \
    rm -rf /var/lib/apt/lists/*
```

## Common Patterns

### Web Application
```dockerfile
FROM node:16-alpine
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY . .
EXPOSE 3000
USER node
CMD ["npm", "start"]
```

### Service with Init Script
```dockerfile
FROM alpine:latest
RUN apk add --no-cache service-name
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
EXPOSE 8080
CMD ["/entrypoint.sh"]
```

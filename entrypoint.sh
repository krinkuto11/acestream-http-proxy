#!/usr/bin/env bash
#shellcheck disable=SC2086

CONF_FILE="/app/acestream.conf"

# Build configuration from environment variables
CONF_CONTENT=""

# Add internal-buffering module if INTERNAL_BUFFERING is set to a non-empty value
if [ -n "${INTERNAL_BUFFERING}" ]; then
    CONF_CONTENT="${CONF_CONTENT}--use-internal-buffering=${INTERNAL_BUFFERING}\n"
fi

# Add http-port if HTTP_PORT is set
if [ -n "${HTTP_PORT}" ]; then
    CONF_CONTENT="${CONF_CONTENT}--http-port=${HTTP_PORT}\n"
fi

# Add https-port if HTTPS_PORT is set
if [ -n "${HTTPS_PORT}" ]; then
    CONF_CONTENT="${CONF_CONTENT}--https-port=${HTTPS_PORT}\n"
fi

# Add bind-all if BIND_ALL is set to any non-empty value
if [ -n "${BIND_ALL}" ]; then
    CONF_CONTENT="${CONF_CONTENT}--bind-all\n"
fi

# Add P2P port if P2P_PORT is set
if [ -n "${P2P_PORT}" ]; then
    CONF_CONTENT="${CONF_CONTENT}--port=${P2P_PORT}\n"
fi

# Add cache-limit (in GB) port if CACHE_LIMIT is set
if [ -n "${CACHE_LIMIT}" ]; then
    CONF_CONTENT="${CONF_CONTENT}--cache-limit=${CACHE_LIMIT}\n"
fi

# Write configuration to file
printf "%b" "$CONF_CONTENT" > "$CONF_FILE"

# Lanza usando el .conf generado
exec /app/start-engine --client-console "@/app/acestream.conf"

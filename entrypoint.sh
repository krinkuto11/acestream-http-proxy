#!/usr/bin/env bash
#shellcheck disable=SC2086

CONF_FILE="/app/acestream.conf"

# Requiere CONF
: "${CONF:?Define la variable de entorno CONF con el contenido del .conf}"

# Escribe exactamente lo recibido (con nuevas líneas)
printf "%s" "$CONF" > "$CONF_FILE"

# Lanza usando el .conf generado
exec /app/start-engine --client-console "@/app/acestream.conf"

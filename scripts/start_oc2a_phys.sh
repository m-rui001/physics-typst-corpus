#!/bin/sh
# opencode2api backend+proxy rooted at E:\phys so the agent's file tools can write there.
H='/e/tools/opencode1x/home'
export XDG_DATA_HOME="$H/data"
export XDG_STATE_HOME="$H/state"
export XDG_CONFIG_HOME="$H/config"
export XDG_CACHE_HOME="$H/cache"
export OPENCODE_CONFIG_CONTENT='{"plugin":["E:\\tools\\OpenCode2API-main\\plugin\\opencode2api-tool-lock.js"],"permission":{"read":"allow","write":"allow","edit":"allow","glob":"allow","grep":"allow","list":"allow","bash":"deny","webfetch":"deny"}}'
BIN='/e/tools/opencode1x/node_modules/.bin/opencode.cmd'

cd /e/phys || exit 1
"$BIN" serve --port 10001 --hostname 127.0.0.1 >/e/tools/opencode-backend.log 2>&1 &
BE=$!
trap 'kill $BE 2>/dev/null' EXIT INT TERM

cd /e/tools/OpenCode2API-main || exit 1
exec node index.js

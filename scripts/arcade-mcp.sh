#!/usr/bin/env bash
set -euo pipefail
unset CDPATH

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
if command -v python3.12 >/dev/null 2>&1; then
  DEFAULT_PYTHON="python3.12"
else
  DEFAULT_PYTHON="python3"
fi
PYTHON_BIN="${PYTHON_BIN:-${DEFAULT_PYTHON}}"
VENV_DIR="${ARCADE_AGENT_VENV:-${ROOT_DIR}/.arcade/mcp-venv}"
PACKAGE_SPEC="${ARCADE_AGENT_PACKAGE:-arcade-agent[mcp,languages]==0.3.0}"

if [ ! -x "${VENV_DIR}/bin/arcade-mcp" ]; then
  mkdir -p "$(dirname "${VENV_DIR}")"
  "${PYTHON_BIN}" -m venv "${VENV_DIR}" >&2
  "${VENV_DIR}/bin/python" -m pip install --upgrade pip >&2
  "${VENV_DIR}/bin/python" -m pip install "${PACKAGE_SPEC}" >&2
fi

cd "${ROOT_DIR}"
exec "${VENV_DIR}/bin/arcade-mcp" "$@"

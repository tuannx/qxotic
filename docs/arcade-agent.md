# Arcade Agent Architecture Analysis

This repository integrates [arcade-agent](https://github.com/lemduc/arcade-agent) (version 0.3.0) for automated software architecture recovery, structural smell detection, and modularity auditing.

## Canonical Comparison Baseline

The canonical local baseline is recorded in `.arcade/baselines/main-full.json`.

| Input | Value |
|---|---|
| Source | Repository root (`.`) |
| Language | `java` |
| Recovery algorithm | `pkg` |
| Arcade Agent version | `0.3.0` |

### Baseline Metrics

| Metric | Value |
|---|---|
| **BalancedArchitectureScore** | `0.5352` |
| **RCI** | `0.8909` |
| **TurboMQ** | `5.1438` |
| **BasicMQ** | `0.7348` |
| **TwoWayPairRatio** | `0.6667` |
| **Components** | 7 (`Default`, `Format`, `Jam`, `Jinfer`, `Jota`, `Json`, `Toknroll`) |
| **Entities** | 8,837 |
| **Edges** | 10,896 |
| **Architectural Smells** | 8 |

## Running Locally

### 1. Run Architecture Audit

Run the audit wrapper to ingest the source tree, parse dependencies, recover architecture components, and detect smells:

```bash
./scripts/architecture-audit.sh
```

This outputs:
- `arcade_analysis_results.json`: Full machine-readable architecture snapshot.
- `arcade_analysis_results.html`: Interactive HTML visualization report.

You can also use `make`:
```bash
make arch-audit
```

### 2. Compare Against Canonical Baseline

To check architectural drift and metric deltas against `main`:

```bash
./scripts/architecture-audit.sh --compare
```

This outputs:
- `arcade_analysis_results.comparison.md`: Markdown summary suitable for PR comments.

### 3. MCP Server Integration

Arcade Agent includes Model Context Protocol (MCP) support configured via `.mcp.json`.
Start the MCP server manually or let your IDE / Agent invoke:

```bash
./scripts/arcade-mcp.sh
```

## CI Integration

CI runs on pull requests and pushes to `main` via `.github/workflows/arcade-agent-analysis.yml`.
On `main`, the baseline artifact is refreshed. On pull requests, the action posts an architecture comparison diff comment.

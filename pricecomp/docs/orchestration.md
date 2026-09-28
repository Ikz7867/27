# Orchestration and contributor roster

The prompt pack describes Astra as the orchestrator: plan, delegate, integrate and verify, with a single owner review stop at Gate 1. Current orchestration uses the built-in agent fallback. The prompt pack's project-local custom agent role configuration was not installed in this workspace, so no claim is made that those custom role files are active.

| Workstream | Agent / model tier | Responsibility |
|---|---|---|
| Orchestrator | Root Astra | Owns intake integration, task briefs, Gate 1 packet, coordination and verification |
| Requirements intake | Intake — Luna, high | Provisional requirement register, source defects and decision log |
| Affiliate/network research | Network research — Luna, high | Official-source network/API and regional research |
| Market/travel research | Market/travel research — Luna, high | Official-source marketplace and travel provider research |
| Architecture | Architect — Sol, high | Schema, module/interface boundaries and implementation ownership |
| Blueprint review | Blueprint review — Sol, high | Independent read-only review of draft contracts, schema and design |

The first research pass, provisional requirements and architecture draft have been integrated. This is not final Gate 1 completion: the original specification and provider research gaps remain unresolved. Do not begin post-Gate-1 implementation until the owner approves the reconciled review packet. These are internal agents of the current chat, not separate sidebar chats.

## Coordination constraints from the prompt pack

- Keep writing work bounded to one deliverable with explicit paths and acceptance checks.
- Allow no more than three concurrent writers and avoid overlapping write paths.
- Keep route/config registries, migration index and language master under a single owner.
- If work is delegated, each brief should state goal, inputs, exact write scope, deliverable and checks.
- Integrate and verify findings before moving to the next dependent phase; stop at Gate 1 for owner approval.

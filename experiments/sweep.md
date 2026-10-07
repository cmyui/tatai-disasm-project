# Parser sweep evidence

Baseline: `1dacd0f`, after PR #6. Scope is preloaded single-core parsing on the
Windows i7-8700. Original semantic oracle: `4698eb4`; its layout snapshot is
`1dacd0f`. Native runs are serialized. No assembly regeneration is used.

## Historical controls

- Fixed/common positive-slider shape branches lost about 8%; speculation rose.
- Shortening SIMD arithmetic latency added instructions and lost throughput.
- Reading converted types with `vpextrd` lost about 1.5%; deriving the needed
  bit from raw input worked when combined with header pairing.
- Exact newline stores lost about 13%; three speculative stores remained best.
- A separate section-search pass lost about 2.3%; fused scanning worked.
- Wider decimal classification lost 0.64%; packed arithmetic plus SIMD integer
  reconstruction worked. Shorter source does not establish a speedup.
- Direct slider indexing won despite a larger table; this does not justify
  expanding other tables without measuring their working sets.

## Coverage and experiments

The matrix and stage results below are populated as each experiment completes.
Raw logs, executable/source hashes, source diffs, compiler flags and corpus
manifest hashes are retained under `build/sweep/`. Variant recipes are in
`tools/variants.py`; output assembly is isolated under `build/variants/`.

| Stage | Candidate/control | Result |
|---|---|---|
| Reference isolation | Separate allocator, layout and serializer | 94,098 maps + 247,680 guards match original; nonvolatile GPR/XMM checks pass |
| Timing constants | Dot hoist | 20,001 maps: +0.163% time, 14/30 faster pairs; no established win |
| Timing constants | Upper-lane digit constant | +0.521% time, 11/30; no established win |
| Timing constants | Memory digit operand | +0.140% time, 13/30; no established win |
| Timing controls | Loop-aligned dot hoist, SIMD integer reconstruction, bounded comma mask | Pending |

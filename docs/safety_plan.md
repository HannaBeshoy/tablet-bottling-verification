# Safety plan

This part treats the controller the way a safety-related automotive or
industrial function is treated: start from what can go wrong for the user,
inject hardware faults, measure how many of them are caught, then add
mechanisms and measure again.

## Hazards and safety goals

| Hazard | Effect | Safety goal |
|---|---|---|
| H1 Valve stays open | tablets overflow, wrong dose count in the bottle | SG1: the valve closes within a bounded time after the bottle is full or STOP is pressed |
| H2 Valve open while the conveyor moves | tablets fall between bottles | SG2: valve and conveyor are never on together |
| H3 Wrong number of tablets with no indication | bottle is sold with the wrong count | SG3: a wrong count is either prevented or signalled |
| H4 STOP has no effect | operator cannot stop the machine | SG4: STOP always leads to the safe state |

Safe state: valve closed, conveyor off, fault signal on.

## Fault model

| Kind | Where | Meaning |
|---|---|---|
| Stuck-at 0 / stuck-at 1 | every flip-flop output and every input of the control part | permanent hardware defect |
| Single bit flip | every flip-flop, at a random clock | transient upset |

Each fault is injected in simulation with `force` (stuck-at) or a one-clock
inversion (bit flip) while the same random stimulus runs as in the fault-free
case.

## Classification of each injected fault

| Class | Meaning |
|---|---|
| No effect | outputs equal the fault-free run |
| Safe | outputs differ, but no safety goal is violated |
| Detected | a safety goal would be violated, and the fault signal comes on in time |
| Dangerous | a safety goal is violated and nothing signals it |

The figure of merit is the share of faults that are not dangerous. It is
measured first on the unchanged design (baseline) and again after the
mechanisms are added.

## Mechanisms to evaluate in stage 4

| Mechanism | Aimed at |
|---|---|
| Watchdog on valve-open time | H1 |
| One-hot state code with a checker for illegal codes | H1, H2, H4 |
| Output interlock: valve gated by NOT conveyor | H2 |
| Duplicated tablet counter and comparator with comparison | H3 |
| Hamming-protected preset register (already built as a variant in the FPGA repository) | H3 |

Each mechanism is added on its own first, so the table of results shows what
each one buys and what it costs in flip-flops and look-up tables.

## Result

A failure-mode table (failure, cause, effect, detection, class before and
after) for the control part, built from the measured campaign and not from
judgement alone.

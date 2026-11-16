# Verification and safety of the tablet-bottling controller

The design under test is the controller from my
[tablet-bottling-fpga](https://github.com/HannaBeshoy/tablet-bottling-fpga)
repository: a state machine with counters that opens a valve until a bottle
holds the preset number of tablets, then moves the conveyor to the next
bottle. That repository tests it with directed tests, and
[tablet-bottling-formal](https://github.com/HannaBeshoy/tablet-bottling-formal)
proves properties of it. This repository adds the two things still missing:

1. **Random verification with coverage**: a reference model, random stimulus
   and a scoreboard, with functional coverage to show what was exercised.
2. **Safety analysis by fault injection**: hardware faults are injected into
   the running design, each one is classified, then safety mechanisms are
   added and the campaign is repeated.

I do it in stages. Each stage is finished and committed before the next one
starts.

## Stages

| Stage | What | Status |
|---|---|---|
| 0 | Plans: [verification plan](docs/verification_plan.md) and [safety plan](docs/safety_plan.md); fixed copy of the design | done |
| 1 | Reference model, random testbench, scoreboard, properties | not started |
| 2 | Functional coverage and closing the holes; testbench checked against deliberately broken designs | not started |
| 3 | Fault injection on the unchanged design: baseline numbers | not started |
| 4 | Safety mechanisms, one at a time, with the campaign repeated and the cost in logic | not started |
| 5 | Failure-mode table and report | not started |

## Folders

| Folder | Content |
|---|---|
| `rtl/` | unchanged copy of the design, see `rtl/SOURCE.md` |
| `docs/` | plans, later the report |
| `sim/` | testbenches and scripts |

## How to run

Needs Icarus Verilog (tested with version 12).

```sh
sim/smoke.sh     # checks that the design compiles
```

## Licence

MIT, see `LICENSE`.

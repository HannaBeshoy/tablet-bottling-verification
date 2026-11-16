# Verification plan

## What is verified

The control part of the tablet-bottling controller: the state machine
(`bottling_fsm`), the tablet counter, the comparator, the preset register
with its code converter, and the bottle counter, connected as in
`bottling_top`. The display and the button conditioning are covered by the
directed tests of the original repository and are not repeated here.

## Method

1. **Reference model.** A second description of the expected behaviour,
   written in the testbench in a different style from the design (a table of
   rules, not a copy of the `case` statement). It predicts state, valve,
   conveyor, tablet count and bottle count every clock.
2. **Random stimulus with constraints.** START, STOP, tablet pulses,
   bottle-in-place pulses, keypad entries and reset are driven at random, but
   with weights so that useful sequences happen often enough (for example
   STOP is rare and short most of the time, sometimes long).
3. **Scoreboard.** Every clock the design outputs are compared with the
   reference model. The first mismatch stops the run and prints the seed, so
   any failure can be repeated.
4. **Functional coverage.** Counters in the testbench record which of the
   situations below have happened. A run only counts as complete when every
   item has been hit.
5. **Properties.** Rules that must hold on every clock, checked
   independently of the reference model.

## Coverage items

| Group | Item |
|---|---|
| States | each of IDLE, FILL, DONE, MOVE visited |
| Transitions | each of the 8 legal transitions taken, and each state held for at least one clock |
| STOP | STOP seen in each state; STOP in the same clock as `full`; STOP in the same clock as `in_place` |
| START | START with preset 0 (must be ignored); START with the bottle already full; START while STOP is held |
| Preset | smallest (1), largest (99), a one-digit value, a two-digit value, a value changed between two runs |
| Counters | tablet count reaches the preset exactly; bottle counter carries from 9 to 10 and from 99 to 100 |
| Inputs out of turn | tablet pulse while the valve is closed; bottle-in-place pulse outside MOVE; keypad entry outside IDLE |
| Reset | reset in each state |

## Properties

| Number | Rule |
|---|---|
| P1 | valve and conveyor are never on in the same clock |
| P2 | the valve is open only in FILL |
| P3 | the bottle counter changes only in the clock after DONE, and only by +1 |
| P4 | the tablet count never exceeds the preset by more than the tablets that arrive in the closing clock |
| P5 | with STOP held, the machine is in IDLE at the latest two clocks later, unless it passes through DONE to count a full bottle |
| P6 | the preset changes only in IDLE |
| P7 | after reset, state is IDLE and all counters are 0 |

## Done means

- 0 mismatches over at least 100 seeds of 20,000 clocks each
- every coverage item hit
- every property held on every clock
- a deliberately broken copy of the design (one changed line at a time) is
  caught by the testbench: this checks the testbench itself

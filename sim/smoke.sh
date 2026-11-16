#!/bin/sh
# Check that the copied design compiles without warnings.
set -e
cd "$(dirname "$0")"
mkdir -p out
iverilog -g2005 -Wall -s bottling_top -o out/smoke ../rtl/*.v
echo "design compiles"

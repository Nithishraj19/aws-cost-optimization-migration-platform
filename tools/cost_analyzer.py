#!/usr/bin/env python3
"""Analyze supplied scenario assumptions; never connects to AWS."""
import json
import sys
from pathlib import Path

def analyze(data):
    if data.get("data_classification") != "ILLUSTRATIVE_SAMPLE_NOT_AWS_BILL":
        raise ValueError("Input must explicitly label its source classification.")
    rows = data.get("resources")
    if not isinstance(rows, list):
        raise ValueError("resources must be a list")
    print("Illustrative analysis based on supplied sample assumptions.")
    print("Not an AWS bill, price quote, or measured savings.")
    print("{:<28} {:>11} {:>11} {:>11}  {}".format("Resource","Current","Candidate","Delta*","Confidence"))
    current_total = candidate_total = 0.0
    for row in rows:
        current = float(row["monthly_cost"])
        candidate = float(row["candidate_monthly_cost"])
        if current < 0 or candidate < 0:
            raise ValueError("Costs cannot be negative.")
        current_total += current
        candidate_total += candidate
        print("{:<28} {:>10.2f} {:>10.2f} {:>10.2f}  {}".format(
            row["name"][:28], current, candidate, current-candidate, row.get("confidence","unspecified")))
        cpu = row.get("avg_cpu_pct")
        if cpu is not None and cpu < 30:
            print("  Review: average CPU {}%, peak {}; do not resize from average CPU alone.".format(
                cpu, row.get("peak_cpu_pct","unknown")))
        print("  Workload: {}".format(row.get("workload", "not classified")))
        print("  Configuration: {}".format(row.get("configuration", "not supplied")))
        usage = {key: row[key] for key in ("monthly_usage_hours", "storage_gb", "data_transfer_gb", "monthly_usage_gb", "instance_type", "region", "avg_cpu_pct", "avg_memory_pct") if row.get(key) is not None}
        if usage:
            print("  Usage inputs: {}".format(usage))
        print("  Cost driver: {}".format(row.get("kind", "not classified")))
        print("  Candidate: {}".format(row["candidate"]))
    print("Scenario totals: {:.2f} -> {:.2f}; difference {:.2f} {} / month".format(
        current_total, candidate_total, current_total-candidate_total, data.get("currency","")))
    print("Highest supplied current-cost resources:")
    for row in sorted(rows, key=lambda item: float(item["monthly_cost"]), reverse=True)[:3]:
        print("  {}: {:.2f} {} / month".format(row["name"], float(row["monthly_cost"]), data.get("currency", "")))
    print("*Arithmetic from user-supplied assumptions only; not a savings claim.")

if __name__ == "__main__":
    if len(sys.argv) != 2:
        raise SystemExit("Usage: python3 tools/cost_analyzer.py examples/resources.json")
    try:
        analyze(json.loads(Path(sys.argv[1]).read_text(encoding="utf-8")))
    except (OSError, ValueError, KeyError, TypeError, json.JSONDecodeError) as exc:
        raise SystemExit("Input error: {}".format(exc))

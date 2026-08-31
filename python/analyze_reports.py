import json
from pathlib import Path

reports_dir = Path("reports")

files = list(reports_dir.glob("*.json"))

if not files:
    print("No reports found.")
    exit()

cpu_values = []
memory_values = []
disk_values = []

for report_file in files:
    with open(report_file, "r") as file:
        data = json.load(file)

        cpu_values.append(data["cpu"]["value"])
        memory_values.append(data["memory"]["value"])
        disk_values.append(data["disk"]["value"])

cpu_avg = sum(cpu_values) / len(cpu_values)
memory_avg = sum(memory_values) / len(memory_values)
disk_avg = sum(disk_values) / len(disk_values)

print("=" * 50)
print("AWS ENVIRONMENT SUPPORT LAB")
print("REPORT ANALYSIS")
print("=" * 50)

print(f"Reports analyzed : {len(files)}")
print(f"Average CPU      : {cpu_avg:.2f}%")
print(f"Average Memory   : {memory_avg:.2f}%")
print(f"Average Disk     : {disk_avg:.2f}%")
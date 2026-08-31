import json
import random
from datetime import datetime


def check_cpu():
    return random.randint(10, 95)


def check_memory():
    return random.randint(20, 90)


def check_disk():
    return random.randint(15, 85)


def get_status(value, warning=70, critical=90):
    if value >= critical:
        return "CRITICAL"
    elif value >= warning:
        return "WARNING"
    return "HEALTHY"


cpu = check_cpu()
memory = check_memory()
disk = check_disk()

report = {
    "timestamp": datetime.now().isoformat(),
    "cpu": {
        "value": cpu,
        "status": get_status(cpu)
    },
    "memory": {
        "value": memory,
        "status": get_status(memory)
    },
    "disk": {
        "value": disk,
        "status": get_status(disk)
    }
}

with open("health_report.json", "w") as file:
    json.dump(report, file, indent=4)

print("Health report generated successfully.")
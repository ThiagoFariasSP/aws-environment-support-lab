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


def main():
    cpu = check_cpu()
    memory = check_memory()
    disk = check_disk()

    print("=" * 50)
    print("AWS ENVIRONMENT SUPPORT LAB")
    print("=" * 50)
    print(f"Timestamp : {datetime.now()}")
    print()

    print(f"CPU Usage     : {cpu}% [{get_status(cpu)}]")
    print(f"Memory Usage  : {memory}% [{get_status(memory)}]")
    print(f"Disk Usage    : {disk}% [{get_status(disk)}]")
    print()

    print("Health Check Completed")


if __name__ == "__main__":
    main()
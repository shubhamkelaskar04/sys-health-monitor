# **Automated System Health Monitoring Script**

A simple and effective Bash script to monitor key system metrics like disk usage, running services, memory status, and CPU performance.
This tool is especially useful for beginners, Linux learners, and system administrators who want quick system insights using a menu-driven script.

---

## 🔧 **Features**

✔️ Check Disk Usage
✔️ Check Running Services
✔️ Check Memory Status
✔️ Check CPU Performance
✔️ Generate Full System Health Report
✔️ Automatically save report to:
`/tmp/sys_health_report.txt`

---

## 📂 **Project Structure**

```
sys-monitor/
│── sys_health_reporter.sh     # Main script
│── README.md                  # Project documentation
│── venv/                      # Python virtual environment (if created)
```

---

## 🚀 **How to Run the Script**

### **1️⃣ Give execute permission**

```bash
chmod +x sys_health_reporter.sh
```

### **2️⃣ Run the script**

```bash
./sys_health_reporter.sh
```

---

## 🖥️ **Script Menu Output (from screenshots)**

When you run the script, you will see:

```
System Health Monitor Menu
1. Check Disk Usage
2. Check Running Services
3. Check Memory Status
4. Check CPU Performance
5. Generate Full Report
6. Exit
Enter choice [1-6]:
```

### **Sample Outputs from your screenshots**

#### ✔ Disk Usage

```
------ Disk Usage ------
Filesystem      Size  Used  Avail Use%  Mounted on
none            1.9G  0     1.9G  0%    /usr/lib/modules/...
drivers         477G  100G  377G 22%    /usr/lib/wsl/drivers
/dev/sdd        1007G 46G   952G  1%    /
...
```

#### ✔ Running Services

```
------ Running Services ------
UNIT                        LOAD   ACTIVE SUB     DESCRIPTION
cron.service                loaded active running Regular background job scheduler
prometheus.service          loaded active running Monitoring system...
grafana-server.service      loaded active running Grafana instance
...
```

#### ✔ Memory Status

```
------ Memory Status ------
Mem:   3.7Gi  used: 656Mi  free: 2.9Gi
Swap:  1.0Gi  used: 0B     free: 1.0Gi
```

#### ✔ CPU Performance

```
------ CPU Performance ------
top - 15:50:01 up 40 min, 1 user, load average: 0.03, 0.01, 0.00
PID USER  %CPU  %MEM   COMMAND
169 grafana  9.1  6.3   grafana
1 root       0.3  0.4   systemd
```

---

## 📄 **Full Script (Used in Your Project)**

```bash
#!/bin/bash
# script by: shubham kelaskar
# Created on: 19/11/2025

LOG_FILE="/var/log/sys_health.log"
REPORT_FILE="/tmp/sys_health_report.txt"

check_disk_usage() {
    echo "------ Disk Usage ------"
    df -h
}

check_running_services() {
    echo "------ Running Services ------"
    if command -v systemctl &> /dev/null; then
        systemctl list-units --type=service --state=running
    else
        service --status-all 2>/dev/null | grep '+'
    fi
}

check_memory_status() {
    echo "------ Memory Status ------"
    free -h
}

check_cpu_performance() {
    echo "------ CPU Performance ------"
    top -b -n1 | head -n 10
}

generate_report() {
    {
        echo "===== System Health Report - $(date) ====="
        check_disk_usage
        echo
        check_running_services
        echo
        check_memory_status
        echo
        check_cpu_performance
        echo "========================================="
    } > "$REPORT_FILE"

    echo "Report saved to $REPORT_FILE"
}

display_menu() {
    while true; do
        echo -e "\nSystem Health Monitor Menu"
        echo "1. Check Disk Usage"
        echo "2. Check Running Services"
        echo "3. Check Memory Status"
        echo "4. Check CPU Performance"
        echo "5. Generate Full Report"
        echo "6. Exit"
        read -rp "Enter choice [1-6]: " choice

        case $choice in
            1) check_disk_usage ;;
            2) check_running_services ;;
            3) check_memory_status ;;
            4) check_cpu_performance ;;
            5) generate_report ;;
            6) exit 0 ;;
            *) echo "Invalid choice, try again." ;;
        esac
    done
}

# Create log file if permission exists
sudo touch "$LOG_FILE" 2>/dev/null
sudo chmod 644 "$LOG_FILE" 2>/dev/null

display_menu
```

---



```
LOG_FILE="$HOME/sys_health.log"
```



Just tell me **“make it more professional”** or **“upload to GitHub guide”**.

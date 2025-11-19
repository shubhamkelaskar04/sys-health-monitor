#!/bin/bash
# Script by: Shubham Kelaskar
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

    # Log output
    cat "$REPORT_FILE" >> "$LOG_FILE"
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
            5) generate_report; echo "Report saved to $REPORT_FILE" ;;
            6) exit 0 ;;
            *) echo "Invalid choice, try again." ;;
        esac
    done
}

# Ensure log file exists
sudo touch "$LOG_FILE"
sudo chmod 644 "$LOG_FILE"

display_menu

# 🖥️ System Sentinel

A lightweight Linux system health monitoring dashboard built with Bash.

A beginner DevOps/Linux project that collects real system metrics, evaluates system health, and generates a visual web dashboard.

---

## 📌 About The Project

**System Sentinel** is a Bash-based Linux monitoring tool designed to collect and display important system health metrics.

The script gathers information directly from the Linux system and dynamically generates an HTML dashboard showing:

- 🖥️ **CPU Load**
- 🧠 **Memory Usage**
- 💾 **Disk Usage**
- ⏱️ **System Uptime**
- 🏷️ **Hostname**
- 🐧 **Operating System**
- 🟢🟡🔴 **Overall System Status**
- 🕐 **Last Updated Time**

The project was built to strengthen my understanding of Bash scripting, Linux commands, conditional logic, command-line utilities, and basic system monitoring.

---

## ✨ Features

### 📊 System Monitoring
*   **CPU Load** — Displays the system's current load averages.
*   **Memory Usage** — Displays used and total RAM along with utilization percentage.
*   **Disk Usage** — Displays root filesystem utilization.
*   **System Uptime** — Shows how long the system has been running.
*   **Hostname Detection** — Identifies the monitored machine.
*   **OS Detection** — Detects the installed Linux operating system.
*   **Timestamp** — Records when the metrics were collected.

### 🚦 Health Status Detection
System Sentinel evaluates memory and disk usage and assigns a basic health status:

| Status | Threshold | Meaning |
| :--- | :--- | :--- |
| 🟢 Healthy | < 75% | System resources are within normal range |
| 🟡 Warning | 75% - 89% | Resource usage requires attention |
| 🔴 Critical | ≥ 90% | Resource usage is critically high |

---

## 🛠️ Technologies Used

| Technology | Purpose |
| :--- | :--- |
| 🐚 **Bash** | Main scripting language |
| 🐧 **Linux** | Operating system and system metrics |
| 🌐 **HTML** | Dashboard structure |
| 🎨 **Tailwind CSS** | Dashboard styling |
| 🔧 **Git** | Version control |
| ☁️ **GitHub** | Project hosting |

### 🔧 Linux Commands Used
The script uses several standard Linux utilities: `uptime`, `free`, `df`, `hostname`, `grep`, `awk`, `cut`, `tr`, and `date`.

---

## ⚙️ How It Works

```text
┌──────────────────────┐
│     Linux System     │
└──────────┬───────────┘
           │
           ▼
┌──────────────────────┐
│   Bash Script        │
│ monitor-system.sh    │
└──────────┬───────────┘
           │
           ▼
┌──────────────────────┐
│   Collect Metrics    │
└──────────┬───────────┘
           │
           ▼
┌──────────────────────┐
│ Evaluate Conditions  │
└──────────┬───────────┘
           │
           ▼
┌──────────────────────┐
│   Generate HTML      │
└──────────┬───────────┘

#!/bin/bash

# ==========================================
# System Sentinel - Server Health Dashboard
# Beginner DevOps/Linux Learning Project
# ==========================================

# 1. Collect System Data
CPU_LOAD=$(uptime | awk -F'load average:' '{ print $2 }')
MEM_USAGE=$(free -h | awk '/^Mem:/ {print $3 "/" $2}')
MEM_PERCENT=$(free | awk '/^Mem:/ {printf "%.0f", ($3/$2)*100}')
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}' | tr -d '%')
UPTIME=$(uptime -p)
HOSTNAME=$(hostname)
OS_NAME=$(grep '^PRETTY_NAME=' /etc/os-release | cut -d= -f2 | tr -d '"')
LAST_UPDATED=$(date)

# 2. Determine Server Status
if [ "$DISK_USAGE" -ge 90 ] || [ "$MEM_PERCENT" -ge 90 ]; then
    STATUS="Critical"
    STATUS_COLOR="red"
elif [ "$DISK_USAGE" -ge 75 ] || [ "$MEM_PERCENT" -ge 75 ]; then
    STATUS="Warning"
    STATUS_COLOR="yellow"
else
    STATUS="Healthy"
    STATUS_COLOR="green"
fi

# 3. Define Output File
OUTPUT_FILE="dashboard.html"

# 4. Generate HTML Dashboard
cat <<EOF > "$OUTPUT_FILE"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <script src="https://cdn.tailwindcss.com"></script>

    <title>System Sentinel</title>
</head>

<body class="bg-slate-950 text-white font-sans min-h-screen p-6 md:p-10">

    <div class="max-w-5xl mx-auto">

        <!-- Header -->
        <header class="flex flex-col md:flex-row md:justify-between md:items-center
                       border-b border-slate-800 pb-6 mb-8">

            <div>
                <div class="flex items-center gap-3">
                    <h1 class="text-3xl font-bold text-blue-400">
                        System Sentinel
                    </h1>

                    <span class="text-xs bg-blue-500/10 text-blue-400
                                 border border-blue-500/20 px-2 py-1 rounded-full">
                        Bash Project
                    </span>
                </div>

                <p class="text-slate-500 text-sm mt-2">
                    Lightweight Linux Server Health Monitor
                </p>
            </div>

            <div class="mt-4 md:mt-0 text-right">
                <p class="text-slate-500 text-xs">LAST SYNC</p>
                <p class="text-slate-300 text-sm font-mono">
                    $LAST_UPDATED
                </p>
            </div>

        </header>


        <!-- Server Status -->
        <div class="bg-slate-900 border border-slate-800 rounded-2xl
                    p-6 mb-8 shadow-xl">

            <div class="flex items-center justify-between">

                <div>
                    <p class="text-slate-500 text-xs uppercase tracking-widest">
                        Server Status
                    </p>

                    <h2 class="text-2xl font-bold mt-1 text-$STATUS_COLOR-400">
                        ● $STATUS
                    </h2>
                </div>

                <div class="text-right">
                    <p class="text-slate-500 text-xs">HOSTNAME</p>
                    <p class="font-mono text-slate-300">
                        $HOSTNAME
                    </p>
                </div>

            </div>

        </div>


        <!-- System Information -->
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">

            <div class="bg-slate-900 p-6 rounded-xl border border-slate-800">
                <p class="text-slate-500 text-xs uppercase tracking-widest">
                    Operating System
                </p>

                <p class="text-lg font-semibold mt-2 text-blue-300">
                    $OS_NAME
                </p>
            </div>


            <div class="bg-slate-900 p-6 rounded-xl border border-slate-800">
                <p class="text-slate-500 text-xs uppercase tracking-widest">
                    System Uptime
                </p>

                <p class="text-lg font-mono mt-2 text-green-400">
                    $UPTIME
                </p>
            </div>


            <div class="bg-slate-900 p-6 rounded-xl border border-slate-800">
                <p class="text-slate-500 text-xs uppercase tracking-widest">
                    Monitoring
                </p>

                <p class="text-lg font-semibold mt-2 text-purple-400">
                    Active
                </p>
            </div>

        </div>


        <!-- Metrics -->
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6">

            <!-- CPU -->
            <div class="bg-slate-900 p-6 rounded-xl border border-slate-800
                        shadow-lg">

                <h2 class="text-slate-400 uppercase text-xs font-semibold
                           tracking-widest mb-3">
                    CPU Load
                </h2>

                <p class="text-2xl font-mono text-green-400">
                    $CPU_LOAD
                </p>

                <div class="mt-4 h-2 bg-slate-800 rounded-full">
                    <div class="h-2 bg-green-400 rounded-full w-1/2"></div>
                </div>

            </div>


            <!-- Memory -->
            <div class="bg-slate-900 p-6 rounded-xl border border-slate-800
                        shadow-lg">

                <h2 class="text-slate-400 uppercase text-xs font-semibold
                           tracking-widest mb-3">
                    Memory Usage
                </h2>

                <p class="text-2xl font-mono text-purple-400">
                    $MEM_USAGE
                </p>

                <div class="mt-4 h-2 bg-slate-800 rounded-full overflow-hidden">
                    <div
                        class="h-2 bg-purple-400 rounded-full"
                        style="width: ${MEM_PERCENT}%">
                    </div>
                </div>

                <p class="text-xs text-slate-500 mt-2">
                    ${MEM_PERCENT}% utilized
                </p>

            </div>


            <!-- Disk -->
            <div class="bg-slate-900 p-6 rounded-xl border border-slate-800
                        shadow-lg">

                <h2 class="text-slate-400 uppercase text-xs font-semibold
                           tracking-widest mb-3">
                    Disk Space
                </h2>

                <p class="text-2xl font-mono text-orange-400">
                    ${DISK_USAGE}% Used
                </p>

                <div class="mt-4 h-2 bg-slate-800 rounded-full overflow-hidden">
                    <div
                        class="h-2 bg-orange-400 rounded-full"
                        style="width: ${DISK_USAGE}%">
                    </div>
                </div>

            </div>

        </div>


        <!-- Refresh -->
        <div class="flex justify-center mt-10">

            <button
                onclick="location.reload()"
                class="bg-blue-500 hover:bg-blue-600 transition
                       px-5 py-2 rounded-lg text-sm font-semibold">

                Refresh Dashboard

            </button>

        </div>


        <!-- Footer -->
        <footer class="mt-16 pt-6 border-t border-slate-800
                       text-center text-slate-600 text-xs">

            <p>
                System Sentinel • Built with Bash + Linux
            </p>

            <p class="mt-2">
                A sytem monitoring Linux project
            </p>

        </footer>

    </div>

</body>
</html>
EOF

echo "Dashboard generated successfully: $OUTPUT_FILE"

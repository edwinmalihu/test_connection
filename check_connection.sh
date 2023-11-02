#!/bin/bash

#file_dev="/root/test-connectivity/maverick_ip_list_dev.txt"
#file_test="/root/test-connectivity/maverick_ip_list_dev.txt"
file_beta="\Users\1338\Documents\BNI Document\Devsecops\Maverik\Test Connection\test-connectivity\maverick_ip_list_beta.txt"

echo $file
timestamp=$(date +%Y%m%d_%H%M%S)

# Function to check Telnet connectivity for an IP address and port
check_telnet() {
    local ip=$1
    local ip_port=$2
    local timestamp=$3
    local environment=$4
    output_file_success="${timestamp}_telnet_success_${environment}.txt"
    output_file_failed="${timestamp}_telnet_failed_${environment}.txt"

    if nc -vz $ip_port; then
        echo "Telnet connection successful: $ip" >> "$output_file_success"
    else
        echo "Telnet connection failed: $ip" >> "$output_file_failed"
    fi
}

if [ ! -f "$file_beta" ]; then
    echo "File BETA not found: $file"
    exit 1
fi

# Loop through the IP addresses and check Telnet connectivity
while IFS= read -r line || [ -n "$line" ]; do
    ip=$(echo $line | cut -f1)
    port=$(echo $line | cut -f2)
    check_telnet "$ip" "$port" "$timestamp" "BETA" # Pass the IP and port as arguments to the function
done < "$file_beta"

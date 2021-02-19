port=$((netstat --listening --all --tcp --numeric | 
    sed '1,2d; s/[^[:space:]]*[[:space:]]*[^[:space:]]*[[:space:]]*[^[:space:]]*[[:space:]]*[^[:space:]]*:\([0-9]*\)[[:space:]]*.*/\1/g' |
    sort -n | uniq; seq 1 1024; seq 1 65535
) | sort -n | uniq -u | shuf -n 1)

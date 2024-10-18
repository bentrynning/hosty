curl -fsSL https://raw.githubusercontent.com/bentrynning/hosty/refs/heads/main/run/install.sh | bash
curl -fsSL https://raw.githubusercontent.com/bentrynning/secure-droplet/refs/heads/main/secure.sh | bash

# Connect to the droplet from local machine 
ssh -L 8080:localhost:8080 root@ip_address

# Kill the process
kill $(lsof -t -i:8080)
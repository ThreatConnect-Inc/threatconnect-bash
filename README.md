# Overview

The following script is an example that can be used to test connectivity to [ThreatConnect’s API](https://docs.threatconnect.com/en/latest/index.html).

# Testing API Connectivty

1. Rename the **config.sh-template** file to **config.sh**.
2. Update the following variables in the **config.sh** file:
    - API_ID
    - API_SECRET
    - API_HOST
    - DEFAULT_OWNER
3. Execute `./threatconnect.sh` or `sh ./threatconnect.sh`. If the script was executed successfully, all Organizations and Communities that the API credentials have access will be returned.

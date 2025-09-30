#!/bin/bash

# Producto final: linpeas_ctf.sh
python3 -m builder.linpeas_builder \
  --include "system_information,users_information,interesting_perms_files,interesting_files,procs_crons_timers_srvcs_sockets,software_information,network_information" \
  --exclude "container,cloud,api_keys_regex,different_procs_1min,dbus_analysis" \
  --output /tmp/linpeas_tmp.sh

echo '#!/bin/bash' > /tmp/linpeas_ctf.sh
echo 'TIMEOUT=240' >> /tmp/linpeas_ctf.sh
echo '( sleep $TIMEOUT && echo "Timeout alcanzado" && kill $$ ) &' >> /tmp/linpeas_ctf.sh
echo 'KILLER_PID=$!' >> /tmp/linpeas_ctf.sh
cat /tmp/linpeas_tmp.sh >> /tmp/linpeas_ctf.sh  # Agrega el contenido
echo 'kill $KILLER_PID 2>/dev/null' >> /tmp/linpeas_ctf.sh
chmod +x /tmp/linpeas_ctf.sh

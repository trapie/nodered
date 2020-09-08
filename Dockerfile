FROM nodered/node-red

# Copy package.json to the WORKDIR so npm builds all
# of your added nodes modules for Node-RED

COPY package.json .
RUN npm install --unsafe-perm --no-update-notifier --no-fund --only=production
RUN npm audit fix
# Copy _your_ Node-RED project files into place
# NOTE: This will only work if you DO NOT later mount /data as an external volume.
#       If you need to use an external volume for persistence then
#       copy your settings and flows files to that volume instead.
#COPY settings.js /data/settings.js
#COPY flows_cred.json /data/flows_cred.json
#COPY flows.json /data/flows.json

# You should add extra nodes via your package.json file but you can also add them here:
#WORKDIR /usr/src/node-red
#RUN npm install node-red-node-smooth

#node-red-docker@1.1.3 start /usr/src/node-red
#node $NODE_OPTIONS node_modules/node-red/red.js $FLOWS "--userDir" "/data"
HEALTHCHECK &{["CMD-SHELL" "node /healthcheck.js"] "0s" "0s" "0s" '\x00'}
ENTRYPOINT [npm start --cache /data/.npm -- --userDir /data]
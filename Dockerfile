FROM nodered/node-red

# Copy package.json to the WORKDIR so npm builds all
# of your added nodes modules for Node-RED
#USER root
#WORKDIR /data
#WORKDIR /usr/src/node-red
#COPY package.json .
#RUN npm install --unsafe-perm --no-update-notifier --no-fund --only=production
#RUN npm install node-red-contrib-dwd-local-weather
#RUN npm audit fix
# Copy _your_ Node-RED project files into place
# NOTE: This will only work if you DO NOT later mount /data as an external volume.
#       If you need to use an external volume for persistence then
#       copy your settings and flows files to that volume instead.
#COPY settings.js /data/settings.js
#COPY flows_cred.json /data/flows_cred.json
#COPY flows.json /data/flows.json
#        "node-red-contrib-dwd-local-weather": "~0.1.9",
#        "node-red-contrib-gree-hvac": "~0.1.3",
#        "node-red-contrib-harmony-websocket": "~2.2.3",
#        "node-red-contrib-loxone": "~0.10.10",
#        "node-red-contrib-netatmo-dashboard": "~0.5.2",
#        "node-red-node-rbe": "~0.2.9",
#        "@fetchbot/node-red-contrib-ikea-home-smart": "~0.3.2",
#        "node-red-contrib-influxdb": "~0.4.1",
#        "node-red-contrib-neato-botvac": "~0.2.2",
#        "node-red-contrib-solaredge": "~0.1.0",
#        "node-red-contrib-boolean-logic-ultimate": "~1.0.17",
#        "node-red-contrib-sum": "~0.1.1",
#        "node-red-dashboard": "~2.23.2"
# You should add extra nodes via your package.json file but you can also add them here:
WORKDIR /usr/src/node-red
RUN npm install node-red-contrib-dwd-local-weather@~0.1.9
RUN npm install node-red-contrib-gree-hvac@~0.1.3
RUN npm install node-red-contrib-loxone@~0.10.10
RUN npm install node-red-contrib-netatmo-dashboard@~0.5.2
RUN npm install @fetchbot/node-red-contrib-ikea-home-smart@~0.3.2
RUN npm install node-red-contrib-influxdb@~0.4.1
RUN npm install node-red-contrib-harmony-websocket@~2.2.3
RUN npm install node-red-contrib-neato-botvac@~0.2.2
RUN npm install node-red-contrib-solaredge@~0.1.0
RUN npm install node-red-contrib-boolean-logic-ultimate@~1.0.17
RUN npm install node-red-contrib-sum@~0.1.1
RUN npm install node-red-dashboard@~2.23.2
USER node-red
#node-red-docker@1.1.3 start /usr/src/node-red
#node $NODE_OPTIONS node_modules/node-red/red.js $FLOWS "--userDir" "/data"
HEALTHCHECK &{["CMD" "node /healthcheck.js"] "0s" "0s" "0s" '\x00'}
#ENTRYPOINT npm start --cache /data/.npm -- --userDir /data
ENTRYPOINT ["npm", "start", "--cache", "/data/.npm", "--", "--userDir", "/data"]
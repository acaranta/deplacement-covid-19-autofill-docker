FROM node AS buildgen

RUN apt-get update && \
    apt-get -y install xvfb gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 \
      libdbus-1-3 libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 \
      libgtk-3-0 libnspr4 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 \
      libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 \
      libxtst6 ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils wget git && \
    rm -rf /var/lib/apt/lists/*

# Fetch upstream code to be dockerized, built and run
RUN git clone https://github.com/LAB-MI/attestation-deplacement-derogatoire-q4-2020.git /app  
WORKDIR /app

# Adding new autofill JS functions
ADD autofill.js /app/src/js

# Injecting autofill functions call to main code
ADD mainjsimport.js /tmp
RUN cat /tmp/mainjsimport.js >>src/js/main.js 

# Build/compile the project
RUN npm i
RUN PUBLIC_URL="/" npm run build:dev

# Generate final lighter image, not containing the source and/or build tools, for faster transfers and use
FROM httpd:2.4
COPY --from=buildgen /app/dist/* /usr/local/apache2/htdocs/

FROM node AS buildgen

RUN apt-get update && \
    apt-get -y install xvfb gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 \
      libdbus-1-3 libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 \
      libgtk-3-0 libnspr4 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 \
      libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 \
      libxtst6 ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils wget git && \
    rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/LAB-MI/attestation-deplacement-derogatoire-q4-2020.git /app  
WORKDIR /app
ADD autofill.js /app/src/js
ADD mainjsimport.js /tmp
#RUN cat src/js/autofill.js >> src/js/main.js 
RUN cat /tmp/mainjsimport.js >>src/js/main.js 

RUN npm i
RUN PUBLIC_URL="/" npm run build:dev

FROM httpd:2.4
COPY --from=buildgen /app/dist/* /usr/local/apache2/htdocs/

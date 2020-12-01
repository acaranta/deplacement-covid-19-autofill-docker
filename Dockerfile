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

# Fix new version
RUN sed -i 's/travail: 488/travail: 553/;s/achats: 417/achats_culturel_cultuel: 482/;s/sante: 347/sante: 434/;s/famille: 325/famille: 410/;s/handicap: 291/handicap: 373/;s/sport_animaux: 269/sport_animaux: 349/;s/convocation: 199/convocation: 276/;s/missions: 178/missions: 252/;s/enfants: 157/enfants: 228/;s/107, 657/92, 702/;s/107, 627/92, 684/;s/240, 627/214, 684/;s/124, 596/104, 665/;s/59,/47,/;s/93, 122/78, 76/;s/76, 92, 11/63, 58, 11/;s/246, 92, 11/227, 58, 11/' /app/src/js/pdf-util.js
RUN sed -i 's/"achats"/"achats_culturel_cultuel"/' /app/src/form-data.json
RUN wget https://media.interieur.gouv.fr/deplacement-covid-19/certificate.0eed39bb.pdf -O /app/src/certificate.pdf

RUN npm i
RUN PUBLIC_URL="/" npm run build:dev

FROM httpd:2.4
COPY --from=buildgen /app/dist/* /usr/local/apache2/htdocs/

# Générateur de certificat de déplacement

## Utilisation avec Docker
soit builder le conteneur localement :
```console
$ docker build -t attesationcovid .
```
et le lancer :
```console
$ docker run -p 80:80 attestationcovid
```

Ou depuis le hub :
```console
$ docker run -p 80:80 acaranta/attestation-deplacement-covid-autofill
```

## Autofill
Cett version proposee permet de passer en parametre de l'URL les champs a remplir, reste a selectionner la raison et generer votre atestation normalement.
exemple d'URL :
```
http://<containeraddress>/index.html?firstname=Jean&lastname=Dupont&birthday=01/01/1970&lieunaissance=Lyon&address=999 Avenue de France&town=Paris&zipcode=75000
```
## Crédits

Ce projet a été réalisé à partir d'un fork du dépôt [covid-19-certificate](https://github.com/lab-mi/covid-19-certificate).


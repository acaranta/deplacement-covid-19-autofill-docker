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
Cette version proposee permet de passer en parametre de l'URL les champs a remplir, reste a selectionner la raison et generer votre atestation normalement.
Ce qui est proposé ici n'est en aucune facon prevu pour tricher/contourner quoi que ce soit, mais pour permettre un remplissage des donnees fixes plus rapidemment (via bookmark ou tag NFC par exemple).

exemple d'URL :
```
http://<containeraddress>/index.html#firstname=Jean&lastname=Dupont&birthday=01/01/1970&placeofbirth=Lyon&address=999 Avenue de France&city=Paris&zipcode=75000&reason=achats
```

`reason` peut prendre les valeurs suivantes :
* travail
* achats
* sante
* famille
* handicap
* sport_animaux
* convocation
* missions
* enfants

Si l'ensemble des paramètres est passé sur l'URL, et qu'ils sont valides,  le PDF de l'attestation sera automatiquement généré.
## Crédits

Ce projet a été réalisé à partir d'un fork du dépôt [LAB-MI/attestation-deplacement-derogatoire-q4-2020](https://github.com/LAB-MI/attestation-deplacement-derogatoire-q4-2020).

Le code JS à été revu par un pro, qui a fait quelque chose de propre, beau, ajouté la gestion de la "raison" ainsi que la lancement de la génération du PDF directement :) ... Merci Dom ! ^^

Merci à @alexisries pour la conversion des URI Fragments.

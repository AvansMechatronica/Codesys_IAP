# Thema: Stuctured Text Programming
## Context: Bekermagazijn

In deze opdracht ga je het bekermagazijn programeren in de **IEC-61131 PLC programeertaal Structured Text**.

![image](../images/beker_magazijn_real_world.png)

**Bekermagzijn Realworld**

![image](../images/beker_magazijn_sumulatie.png)

**Bekermagzijn Simulatie**

## Besturingseisen
De volgende besturingseisen zijn aan de orde:
* Na opstarten programma gaat groene-lamp branden
* Na drukken op “start” wordt 1 beker uitgestoten
    * Alleen als het magazijn niet leeg is
    * Gedurende het uitstoten is groene-lamp uit
*Als magazijn leeg is zal gele-lamp oplichten
*Als gestart wordt als magazijn leeg is zal rode-lamp oplichten en groene lamp uitgaan. Het systeem gaat in  de “Error”
*De “Error” situatie kan worden opgelost door het geven van een Reset
    * Na de Reset gaat de rode-lamp uit en de groene-lamp aan
* Als er op de “noodstop” wordt gedrukt worden alle actuatoren (direct) gedeactiveerd en gaat het systeem in “Error”

## Opdracht 1 Simulatie
* Maak eerst een testspecificatie
* Maak een structured-tekst programma van de beschreven besturingseisen 
* Maak hiervoor gebruik van het voorbereide Codesys project:
    * *“Magazijn Structured Text 2V1 - Structured Text.project”*
    * Download: https://github.com/AvansMechatronica/Codesys_IAP.git
    * Zie map: Opdrachten\IAP
* Plaats je structured tekst code in de “main (PRG)” POU
    * *Let op: Wijzig in geen geval de code in de map Simulatie*

* Test simulatie de simulatie aan de hand van je testspecificatie

### Tips voor de opdracht
* Maak gebruik van de handleiding van Codesys, zie Blackboard
* Plaats programma’s in de tab “POUs”, Programma, kies functionele programma namen
* De Inputs en Outputs zijn gedefinieerd in de GVL lijst.
* Gebruik de juiste prefix voor de namen van variabelen
* Zorg dat het “Device (CODESYS Control Win V3)” project actief is

## Opdracht 2 Realworld
* Om het programma te testen in realworld wordt er gebruik gemaakt van één van de PLC opstellingen met een bekermagazijn.
* Configureer de inputs en outputs van de Hitachi PLC
* Zoek de juiste IO op in de documentatie van de PLC opstelling
* Gebruik het programma (“main” POU) uit opdracht 1(simulatie) om de werking te testen
* Test de functionaliteit van het programma aan de hand van je testspecificatie

### Tips voor de opdracht
* Zorg dat het “HX-CP1S08 CPU (HX-CP1S08)” project actief is
* Configureer de gateway op de juiste wijze

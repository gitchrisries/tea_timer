
// Tee Objekt
class Tea<a, b, c> {
  a name;
  b duration;

  Tea(this.name, this.duration);
}


// Zur Speicherung der Favoriten
// TODO: Mit File oder Datenbank realisieren
List<Tea> favouriteList = [];

// Teeliste
// TODO: Evtl auch mit File oder Datenbank realisieren -> parsen
var teaList = [
  Tea("Grüner Tee", "5 Minuten"),
  Tea("Schwarzer Tee", "3 Minuten"),
  Tea("Rooibos Tee", "4 Minuten"),
  Tea("Kamille Tee", "2 Minuten"),
  Tea("Marokanische Minze", "5 Minuten"),
  Tea("Limonen Tee", "2 Minuten"),
  Tea("Apfel Tee", "2 Minuten")
];
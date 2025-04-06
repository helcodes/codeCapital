class Asset {
  String type;
  String subtype;
  float risiko;
  int id;
  int miete;
  int wert;
  String name;
  String standort;
  String besitzer;
  int bewertung;
  
  String toString() {
    return("id="+this.id+" name="+this.name+" besitzer="+this.besitzer+" standort="+this.standort+" type="+this.type+" subtype="+this.subtype);
  }
}

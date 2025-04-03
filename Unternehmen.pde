class Unternehmen {
  int id;
  String name;
  String mutter;
  String landSitz;
  String landGruendung;
  int schulden;
  int unternehmenswert;
  int liquideMittel;
  int marktkapitalisierung;
  String kreditrating;
  
  Unternehmen(String [] fields) {
    this.name=fields[0];
    this.mutter=fields[1];
    this.landGruendung=fields[2];
    this.landSitz=fields[3];
    this.unternehmenswert=int(fields[4]);
    this.liquideMittel=int(fields[5]);
    this.marktkapitalisierung=int(fields[6]);
    this.schulden=int(fields[7]);
    this.kreditrating=fields[8];
    this.id=int(fields[9]);
  }
  
  Unternehmen() {
  }
  
  public void readFromJson() {
    
  }
  
}

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

class Unternehmen {
  int id;
  String name;
  int mutter;
  String landSitz;
  String landGruendung;
  int schulden;
  int unternehmenswert;
  int liquideMittel;
  int marktkapitalisierung;
  String kreditrating;
  int x;//=random(0, 1200);
  int y;//=random(0, 800);
  int w=100;
  int h= 80;
  color col;
  //Unternehmen parent;
  
  /*void setParent(Unternehmen u) {
    this.parent=u;
  }*/
  
  Unternehmen(String [] fields) {
    int i=0;
    this.id=int(fields[i]); i++;
    this.name=fields[i]; i++;
    this.mutter=int(fields[i]); i++;
    this.landGruendung=fields[i]; i++;
    this.landSitz=fields[i]; i++;
    this.unternehmenswert=int(fields[i]); i++;
    this.liquideMittel=int(fields[i]); i++;
    this.marktkapitalisierung=int(fields[i]); i++;
    this.schulden=int(fields[i]); i++; //<>//
    this.kreditrating=fields[i]; i++; //<>//
    this.x=int(fields[i]); i++;
    this.y=int(fields[i]);
    this.col=getUniqueColor();
    println("Unternehmen this.x=",x);
  }
  
  
  Unternehmen(JSONObject uj) {
    println(uj.toString());
    this.id = uj.getInt("id");
    this.name = uj.getString("name");
    this.mutter = uj.getInt("mutter");
    this.landSitz = uj.getString("land_sitz");
    this.landGruendung = uj.getString("land_gruendung");
    this.schulden = uj.getInt("schulden");
    this.unternehmenswert = uj.getInt("unternehmenswert");
    this.liquideMittel = uj.getInt("liquide_mittel");
    this.marktkapitalisierung = uj.getInt("marktkapitalisierung");
    this.kreditrating = uj.getString("kreditrating");
    this.x = uj.getInt("x");
    this.y = uj.getInt("y");
    this.col=getUniqueColor();
  }
  
  color getUniqueColor() {
    String input = this.liquideMittel + this.marktkapitalisierung + this.schulden + this.kreditrating;
    int hash = getHash(input);
    
    // Extrahiere RGB-Werte aus dem Hash
    int r = (hash >> 16) & 0xFF; // Rot (höherwertiges Byte)
    int g = (hash >> 8) & 0xFF;  // Grün (mittleres Byte)
    int b = hash & 0xFF;         // Blau (niedrigstes Byte)
    
    // Rückgabe der berechneten Farbe
    return color(r, g, b);
  }
  
  private int getHash(String input) {
    try {
      MessageDigest digest = MessageDigest.getInstance("MD5");
      byte[] hashBytes = digest.digest(input.getBytes());
      return ((hashBytes[0] & 0xFF) << 24) | ((hashBytes[1] & 0xFF) << 16) |
             ((hashBytes[2] & 0xFF) << 8) | (hashBytes[3] & 0xFF); // Nur die ersten 4 Bytes
    } catch (NoSuchAlgorithmException e) {
      e.printStackTrace();
      return 0; // Falls der Hash-Algorithmus nicht verfügbar ist
    }
  }
  
  public void readFromJson() {
    
  }
  
  String toString() {
    return("id="+this.id+" name="+this.name+" mutter="+this.mutter+" landSitz="+this.landSitz+" landGruendung="+this.landGruendung+" schulden="+this.schulden+
    " unternehmenswert="+this.unternehmenswert+" liquideMittel="+this.liquideMittel+" marktkapitalisierung="+this.marktkapitalisierung+" kreditrating="+this.kreditrating+
    " x="+this.x+" y="+this.y+" w="+this.w+" h="+this.h);
  }
  
}

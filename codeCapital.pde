import processing.data.*;
import controlP5.*;

/*
Mögliche Spielzüge
Fremdfinanzierung: Kapitalakkumulation, Übernahmen
Expansion
Vermögensschutz durch gezieltes Einsetzen diverser Finanztools (zB Trusts, Stiftungen, Tochterfirmen)
Verbriefung von Schulden
Wertsteigerungen durch Bilanzhandling/optimierung
Wertsteigerung konkreter Assets
Wertsteigerung der eigenen Marke bzw. Projekte
strategische Partnerschaften und politische Netzwerke
Tracking von Merkmalen
wirtschaftliche (Verschuldungsgrad, Liquidität, Spekulationsrisiko)
strategische (Expansionsrate, Diversifikation, mediale Kontrolle)
moralische (Vertrauenswürdigkeit, Gesetzestreue, Nachhaltigkeit, Skandale, Systemkritik)
*/

JSONObject data;
String selectedSpielzug = "";
String fn = new String("data.json");
int current_score_zeit;
int cur_score_prestige;
int cur_score_eigenkapital;
int cur_score_fremdkapital;
ReadManager readM = new ReadManager();
boolean valsChanged=true;

Score [] scores;
Asset [] assets;
Unternehmen [] unternehmen;
int lastTime = 0;  // letzte Ausführungszeit
int interval = 1000; // ms

GUIManager gui;


String name, mutter;
float unternehmenswert, schulden, liquide_mittel;
float x, y, w, h;
//w = sqrt(unternehmenswert) * 5; // Skalierung für Darstellung
//h = sqrt(unternehmenswert) * 5;
// Score-Balken Variablen
float eigenkapital, fremdkapital, prestige;
float balkenX = 150, balkenY = 400, balkenBreite = 100, maxHoehe = 200;



  void draw() {
    
    /*if (valsChanged){
      //if (millis() - lastTime >= interval) {
        //drawUnternehmen();
        println("main draw - updateFromData");
        updateFromData();
        //drawScoreBalken();//Score-Balken
        //lastTime = millis();  // Zeitstempel aktualisieren
      //}
      valsChanged=false;
    }*/
  }


void setup() {
  size(1200, 600);
  background(50);
  
  //cp5 = new ControlP5(this);
  
  readJsonData(fn);//data
  updateFromData();
  gui = new GUIManager(this);
  
  //read possible moves
  JSONArray movesStructurej = data.getJSONArray("possible_moves_structure");
  JSONArray movesCapAquj = data.getJSONArray("possible_moves_aquire_capital");
  //println("movesStructurej ",movesStructurej);
  //println("movesCapAquj ",movesCapAquj);
  
}


void updateFromData() {
  eigenkapital = constrain(eigenkapital + random(-2, 3), 0, maxHoehe);
  fremdkapital = constrain(fremdkapital + random(-2, 3), 0, maxHoehe);
  prestige = constrain(prestige + random(-2, 3), 0, 100);
  
  assets = readM.readAssets();
  unternehmen = readM.readUnternehmen();
  scores = readM.readScores();
}


void readJsonData(String filename) {
  File datei = new File(dataPath(filename));
  if (datei.exists()) {
    println(dataPath(fn));
    data=loadJSONObject(dataPath(fn));
    current_score_zeit        =data.getInt("current_score_zeit");
    scores = readM.readScores();
    
    for (int i = 0; i < scores.length; i++) {
      Score score = scores[i];
      if (score.zeit==current_score_zeit) {
        cur_score_prestige    =score.prestige;
        cur_score_eigenkapital=score.eigenkapital;
        cur_score_fremdkapital=score.fremdkapital;
      }
    }
  println("Die Datei existiert.");
  //println(data.toString());
  } else {
    println(dataPath(fn));
    data = createJSON();
    println("Die Datei existiert nicht.");
  }
}

JSONObject createJSON() {
  data = new JSONObject();
  JSONArray possible_moves = new JSONArray();
  possible_moves.append("immobilie kaufen");
  possible_moves.append("immobilie verkaufen");
  possible_moves.append("konzern kaufen");
  possible_moves.append("konzern verkaufen");
  possible_moves.append("ehk kaufen");
  possible_moves.append("ehk verkaufen");
  possible_moves.append("tochter gruenden");
  possible_moves.append("spv gruenden");
  possible_moves.append("verbriefen");
  data.setJSONArray("possible_moves", possible_moves);
  
  JSONObject score = new JSONObject();
  JSONArray scores = new JSONArray();
  
  score.setInt("zeit", 0);
  score.setFloat("prestige", 50.0);
  score.setFloat("eigenkapital", 1000000.0);
  score.setFloat("fremdkapital", 500000.0);
  scores.append(score);
  score = new JSONObject();
  score.setInt("zeit", 1);
  score.setFloat("prestige", 51.0);
  score.setFloat("eigenkapital", 2000000.0);
  score.setFloat("fremdkapital", 600000.0);
  scores.append(score);
  data.setJSONArray("scores", scores);
  
  JSONObject besitz = new JSONObject();
  besitz.setFloat("wert", 5000000.0);
  data.setJSONObject("besitz", besitz);
  
  saveJSONObject(data, dataPath(fn));
  
  return data;
}




void saveCompanies(Unternehmen u) {
  current_score_zeit=current_score_zeit+1;
  data.setInt("current_score_zeit", current_score_zeit);
  //data.setFloat("current_score_prestige", cur_score_prestige);
  //data.setFloat("current_score_eigenkapital", cur_score_eigenkapital);
  //data.setFloat("current_score_fremdkapital", cur_score_fremdkapital);
  
  JSONArray unternehmenja = data.getJSONArray("unternehmen");
  JSONObject unternehmenj = new JSONObject();
  unternehmenj.setInt("id", u.id);
  unternehmenj.setString("name", u.name);
  unternehmenj.setInt("mutter", u.mutter);
  unternehmenj.setString("land_gruendung", u.landGruendung);
  unternehmenj.setString("land_sitz", u.landSitz);
  unternehmenj.setInt("unternehmenswert", u.unternehmenswert);
  unternehmenj.setInt("liquide_mittel", u.liquideMittel);
  unternehmenj.setInt("marktkapitalisierung", u.marktkapitalisierung);
  unternehmenj.setInt("schulden", u.schulden);
  unternehmenj.setString("kreditrating", u.kreditrating);
  unternehmenj.setInt("x", u.x);
  unternehmenj.setInt("y", u.y);
  unternehmenja.append(unternehmenj);
  data.setJSONArray("unternehmen", unternehmenja);
  saveJSONObject(data, dataPath(fn));
  
}

void saveScores() {
  current_score_zeit=current_score_zeit+1;
  data.setInt("current_score_zeit", current_score_zeit);
  //data.setFloat("current_score_prestige", cur_score_prestige);
  //data.setFloat("current_score_eigenkapital", cur_score_eigenkapital);
  //data.setFloat("current_score_fremdkapital", cur_score_fremdkapital);
  
  JSONArray scoresja = data.getJSONArray("scores");
  JSONObject score = new JSONObject();
  score.setInt("zeit", current_score_zeit);
  score.setFloat("prestige", cur_score_prestige);
  score.setFloat("eigenkapital", cur_score_eigenkapital);
  score.setFloat("fremdkapital", cur_score_fremdkapital);
  scoresja.append(score);
  //scores.add(score);
  data.setJSONArray("scores", scoresja);
  saveJSONObject(data, dataPath(fn));
  
}


int getMaxUid() {
  int maxid=0;
  for (Unternehmen u : unternehmen) {
    if (u.id>maxid) maxid=u.id;
  }
  return maxid;
}


Unternehmen getUByName(String name) {
  for (Unternehmen u : unternehmen) {
    if (u.name.equals(name)) return u;
  }
  return null;
}

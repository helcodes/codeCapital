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

ControlP5 cp5;
JSONObject data;
String selectedSpielzug = "";
Textlabel statusLabel;
String fn = new String("data.json");
int current_score_zeit;
int cur_score_prestige;
int cur_score_eigenkapital;
int cur_score_fremdkapital;
ReadManager readM = new ReadManager();
Textfield companyInputField;
Button companyCreateButton;
DropdownList possibleMovesList1;
boolean valsChanged=true;
PFont font;

Score [] scores;
Asset [] assets;
Unternehmen [] unternehmen;
int lastTime = 0;  // letzte Ausführungszeit
int interval = 1000; // ms

CompanyWindow companyWindow;
NewsFeedWindow newsFeedWindow;


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
  cp5 = new ControlP5(this);
  font = createFont("Arial", 18);
  
  readJsonData(fn);//data
  
  //read possible moves
  JSONArray movesStructurej = data.getJSONArray("possible_moves_structure");
  JSONArray movesCapAquj = data.getJSONArray("possible_moves_aquire_capital");
  //println("movesStructurej ",movesStructurej);
  //println("movesCapAquj ",movesCapAquj);
  
  updateFromData();
  //assets = readM.readAssets();//read assets aus data
  //unternehmen = readM.readUnternehmen();//read unternehmen aus data
  
  companyWindow = new CompanyWindow();
  //newsFeedWindow = new NewsFeedWindow();
  
  /*int j=assets.length;
  println("assets.length ",j);
  for (int i = 0; i < assets.length; i++) {
    Asset asset = assets[i];
    println(asset.type," ",asset.subtype," ",asset.risiko," ",asset.wert," ",asset.name," ",asset.sitz," ",asset.bewertung);
  }*/
  
  addGUIElements();
}


void updateFromData() {
  eigenkapital = constrain(eigenkapital + random(-2, 3), 0, maxHoehe);
  fremdkapital = constrain(fremdkapital + random(-2, 3), 0, maxHoehe);
  prestige = constrain(prestige + random(-2, 3), 0, 100);
  
  assets = readM.readAssets();
  unternehmen = readM.readUnternehmen();
  scores = readM.readScores();
}

void addGUIElements() {
    statusLabel = cp5.addTextlabel("status")
                    .setText("Wähle einen Spielzug aus")
                    .setPosition(20, 30)
                    .setColor(color(255, 255, 255));
              
     possibleMovesList1 = cp5.addDropdownList("possibleMovesList")
       .setPosition(20, 50)
       .setSize(280, 200)
       .setBarHeight(30)
       .setFont(font)
       .setItemHeight(20)
       .addItems(data.getJSONArray("possible_moves_structure").getStringArray())
       .setOpen(false);
    possibleMovesList1.getCaptionLabel().setText("Mögliche Spielzüge") ;
    
    cp5.addButton("ausfuehren")
       .setLabel("Spielzug ausführen")
       .setPosition(380, 50)
       .setFont(font)
       .setSize(240, 40);
    
    companyCreateButton = cp5.addButton("gruenden")
       .setLabel("Gründe Unternehmen")
       .setPosition(380, 300)
       .setFont(font)
       .setSize(280, 40)
       .onClick(new CallbackListener() {
                public void controlEvent(CallbackEvent theEvent) {
                  gruendeUnternehmen();
                }
              });
       //.hide();
    
    companyInputField = cp5.addTextfield("input")
       .setPosition(380, 120)
       .setSize(400, 30)
       .setFont(font)
       .setFocus(true)
       .setColor(color(200, 200, 200))
       .setText("Gamma Alpha Österreich Österreich 21800 200 20000 2000 BB")
       .hide();
       
    cp5.getController("input").getCaptionLabel().setText("Bitte Unternehmensdaten eingeben \n(name mutter land-Gruendung land-Sitz unternehmenswert \nliquide-Mittel marktkapitalisierung schulden kreditrating");
    //Gamma Alpha Österreich Österreich 21800 200 20000 2000 BB
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


void possibleMovesList(int n) {
  selectedSpielzug = cp5.get(DropdownList .class, "possibleMovesList").getItem(n).get("name").toString();
  statusLabel.setText("Ausgewählt: " + selectedSpielzug);
}

void ausfuehren() {
  if (selectedSpielzug.equals("")) return;//kein spielzug selektiert
  statusLabel.setText("Spielzug ausgeführt: " + selectedSpielzug);
  
  if (selectedSpielzug.equals("tochter gruenden")) {
    companyInputField.show();
    companyInputField.setFocus(true);
    companyCreateButton.show();
  } else  if (selectedSpielzug.equals("immobilie kaufen")) {
  } else  if (selectedSpielzug.equals("immobilie verkaufen")) {
  } else  if (selectedSpielzug.equals("unternehmen kaufen")) {
  } else  if (selectedSpielzug.equals("spv gruenden")) {
  } else  if (selectedSpielzug.equals("verbriefung erstellen")) {
  } else  if (selectedSpielzug.equals("verbriefung verkaufen")) {
  }
}


void gruendeUnternehmen() {
  if (companyInputField.getText().equals("")) return;//kein spielzug selektiert
  println(companyInputField.getText() + " " + str(getMaxUid()));
  String[] companyFields = split(companyInputField.getText() + " " + str(getMaxUid()), " ");
  
  Unternehmen u = new Unternehmen(companyFields);
  saveCompanies(u);//gespeichert in data
  unternehmen = readM.readUnternehmen();//TODO: ersetzen durch aufruf in 1. draw
  
  //TODO: update scores
  cur_score_prestige=cur_score_prestige;
  cur_score_eigenkapital=cur_score_eigenkapital;
  cur_score_fremdkapital=cur_score_fremdkapital;


  saveScores();//bei einem zug
  valsChanged=true;
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
  unternehmenj.setString("mutter", u.mutter);
  unternehmenj.setString("land_gruendung", u.landGruendung);
  unternehmenj.setString("land_sitz", u.landSitz);
  unternehmenj.setInt("unternehmenswert", u.unternehmenswert);
  unternehmenj.setInt("liquide_mittel", u.liquideMittel);
  unternehmenj.setInt("marktkapitalisierung", u.marktkapitalisierung);
  unternehmenj.setInt("schulden", u.schulden);
  unternehmenj.setString("kreditrating", u.kreditrating);
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


/////////////// Ab hier zeichnen

String name, mutter;
float unternehmenswert, schulden, liquide_mittel;
float x, y, w, h;
//w = sqrt(unternehmenswert) * 5; // Skalierung für Darstellung
//h = sqrt(unternehmenswert) * 5;

// Score-Balken Variablen
float eigenkapital, fremdkapital, prestige;
float balkenX = 150, balkenY = 400, balkenBreite = 100, maxHoehe = 200;

class CompanyWindow extends PApplet {//2. Fenster
  CompanyWindow() {
    PApplet.runSketch(new String[]{"MySecondWindow"}, this);
  }

  void settings() {
    size(1200, 600);
  }

  void setup() {
    background(100);
  }

  void draw() {
    fill(255);
    textSize(16);
    //text("Zweites Fenster", 80, 150);
    stroke(0);
    //background(240);
    
    
    if (valsChanged){
      //if (millis() - lastTime >= interval) {
        println("CompanyWindow draw - updateFromData");
        updateFromData();
        drawUnternehmen();
        
        //drawScoreBalken();//Score-Balken
        lastTime = millis();  // Zeitstempel aktualisieren
      //}
      valsChanged=false;
    }
  }
  
  void drawUnternehmen() {
    
    x=10; y=10;
    w=10; h=10;
    int divideBy=200;
    float xU=x; float yU=y; float wU=w; float hU=h;
    //float xMU=x; float yMU=y; float wMU=w; float hMU=h;
    stroke(0);
    //float randomValue = random(-5, 5);
    //for (int i = 0; i < assets.length; i++) {
    //  Asset asset = assets[i];
    //}
    for (Unternehmen u : unternehmen) {
      //if (!u.mutter.equals("")) {
        //Unternehmen mutterU = getUByName(u.mutter);
        //if (mutterU != null) {
          //line(mutterU.xU + mutterU.wU / 2, mutterU.yU, mutterU.xU + mutterU.wU / 2, mutterU.yU + mutterU.hU);
          //wU=log(u.unternehmenswert)*3;
          //hU=log(u.unternehmenswert)*3;
          //xU=xU+10+wU;
          //yU=yU+10+hU;
          xU=xU+30;
          yU=yU+30;
          
          fill(255);//Unternehmenswert weiss
          rect(xU, yU, (u.unternehmenswert/divideBy)*1, hU+10);
          println("xU ",xU, "yU ",yU, "wU ",wU, "hU ",hU);
          
          fill(255, 0, 0, 150);// Schulden rot
          rect(xU, yU+5, (u.schulden / divideBy), hU);
          //rect(xU, yU, wU*3, hU); // Basisrechteck
          
          fill(0, 0, 255, 150);// Liquide Mittel (blau)
          rect(xU+(u.schulden / divideBy), yU+5, (u.liquideMittel / divideBy), hU);
          //rect(xU + wU * ( u.liquideMittel / divideBy), yU, wU * (u.liquideMittel / u.unternehmenswert), hU);
      
          // Text für Namen
          fill(0);
          textSize(12);
          textAlign(CENTER, CENTER);
          //text(name, x + w / 2, y + h / 2);
      
        //}
      //}
    }
  }
  
  // Score-Balken für Eigenkapital, Fremdkapital, Prestige
  void drawScoreBalken() {
    fill(200);
    rect(balkenX, balkenY, balkenBreite, maxHoehe);
  
    fill(0, 0, 255);// Eigenkapital Blau
    rect(balkenX, balkenY + maxHoehe - eigenkapital, balkenBreite / 2, eigenkapital);
    
    fill(255, 0, 0);// Fremdkapital Rot
    rect(balkenX + balkenBreite / 2, balkenY + maxHoehe - fremdkapital, balkenBreite / 2, fremdkapital);
  
    // Prestige-Symbol (zwischen Strich und Kreis)
    float prestigeSize = map(prestige, 0, 100, 2, 20);
    fill(0);
    ellipse(balkenX + balkenBreite + 20, balkenY + maxHoehe - prestige, prestigeSize, prestigeSize);
  }
  
}








class NewsFeedWindow extends PApplet {
  
  int feedHeight = 300; // Höhe des Newsfeeds
  int feedStartY; // Y-Position für den Start des Newsfeeds
  String[] news = {  // Anfangsnachrichten
    "News 1: Unternehmen A geht neue Partnerschaft ein.",
    "News 2: Aktien von Firma B steigen um 5%.",
    "News 3: Finanzbericht von Firma C veröffentlicht.",
    "News 4: Unternehmenswert von Firma D wächst.",
    "News 5: Neue Investitionen in Firma E angekündigt.",
    "News 5: Neue Investitionen in Firma a angekündigt.",
    "News 5: Neue Investitionen in Firma b angekündigt.",
    "News 5: Neue Investitionen in Firma c angekündigt.",
    "News 5: Neue Investitionen in Firma b angekündigt.",
    "News 5: Neue Investitionen in Firma c angekündigt.",
    "News 5: Neue Investitionen in Firma d angekündigt.",
    "News 5: Neue Investitionen in Firma b angekündigt.",
    "News 5: Neue Investitionen in Firma c angekündigt.",
    "News 5: Neue Investitionen in Firma d angekündigt.",
    "News 5: Neue Investitionen in Firma b angekündigt.",
    "News 5: Neue Investitionen in Firma c angekündigt.",
    "News 5: Neue Investitionen in Firma d angekündigt.",
    "News 5: Neue Investitionen in Firma b angekündigt.",
    "News 5: Neue Investitionen in Firma c angekündigt.",
    "News 5: Neue Investitionen in Firma d angekündigt.",
    "News 5: Neue Investitionen in Firma b angekündigt.",
    "News 5: Neue Investitionen in Firma c angekündigt.",
    "News 5: Neue Investitionen in Firma d angekündigt.",
    "News 5: Neue Investitionen in Firma d angekündigt.",
    "News 5: Neue Investitionen in Firma E angekündigt."
  };
  int newsIndex = 0; // Aktuellen Index für die Nachricht
  int updateInterval = 500; // Intervall zum Hinzufügen einer neuen Nachricht
  int lastUpdateTime = 0; // Zeitpunkt des letzten Updates
  
  
  NewsFeedWindow() {
    PApplet.runSketch(new String[]{"NewsFeedWindow"}, this);
  }
  
  
  void settings() {
    size(500, 300);
  }
  
  void setup() {
    background(255);
    feedStartY = height - feedHeight; // Position des Newsfeeds
  }
  
  
  void draw() {
    
    // Zeichen des Newsfeed-Bereichs
    fill(240);
    noStroke();
    rect(0, feedStartY, width, feedHeight);
  
    // Aktualisiere den Newsfeed alle 2 Sekunden
    if (millis() - lastUpdateTime > updateInterval) {
      lastUpdateTime = millis();
      addNewFeedItem();  // Neue Nachricht zum Feed hinzufügen
    }
  
    // Nachrichten im Newsfeed anzeigen
    fill(0);
    textSize(14);
    int yOffset = feedStartY + 10; // Startposition für Text im Feed
  
    for (int i = 0; i < news.length; i++) {
      text(news[i], 10, yOffset);
      yOffset += 20;
      if (yOffset > feedStartY + feedHeight - 20) {
        break; // Wenn der Feed voll ist, stoppe das Zeichnen
      }
    }
  }
  
  void addNewFeedItem() {
    // Neue Nachricht hinzufügen und den Index erhöhen
    newsIndex = (newsIndex + 1) % 5; // Bei 5 Nachrichten zurücksetzen
    String newItem = "News " + (newsIndex + 1) + ": Neue wichtige Finanznachricht.";
    // Verschiebe die ältesten Nachrichten und füge die neue hinzu
    for (int i = 0; i < news.length - 1; i++) {
      news[i] = news[i + 1];
    }
    news[news.length - 1] = newItem;
  }
}

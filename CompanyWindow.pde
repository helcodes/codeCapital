class CompanyWindow extends PApplet {//2. Fenster
  color background = color(173, 216, 230);//hellblau

  CompanyWindow() {
    PApplet.runSketch(new String[]{"MySecondWindow"}, this);
  }

  void settings() {
    size(1200, 600);
  }

  void setup() {
    background(background);
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

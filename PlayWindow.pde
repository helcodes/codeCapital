class PlayWindow extends PApplet {//3. Fenster
  Unternehmen selectedU = null;
  color background = color(193, 216, 230);//hellblau

  PlayWindow() {
    PApplet.runSketch(new String[]{"PlayWindow"}, this);
  }

  void settings() {
    size(1200, 600);
  }

  void setup() {
    background(background);
    fill(255);
    textSize(16);
    //text("Zweites Fenster", 80, 150);
    stroke(0);
    //background(240);
    
    noLoop();
    
  //testen: grafische elemente
    for (Unternehmen u : unternehmen) {
      display(u);//u.display();
    }
  
    if (selectedU != null) {
      fill(0);
      text("Bearbeite: " + selectedU.name, 20, height - 20);
    }
  }

  void draw() {
    //rect(100, 100, 100, 100);
    background(background);
    fill(255, 0, 0);
    if (frameCount % 10 == 0) {
      ellipse(mouseX, mouseY, 10, 10);
    }
    
    /*//u hervorheben
    if (selectedU != null) {
      strokeWeight(4);
      stroke(0, 0, 255);
    } else {
      strokeWeight(1);
      stroke(0);
    }*/
    
    
    for (Unternehmen u : unternehmen) {
      drawConnections(u);
      display(u);//u.display();
    }
    
    if (selectedU!=null) {
      int yOffset = 120;
      //println("ASSET-SIZE for selectedU=",getAssets().size());
      for (Asset a : getAssets()) {
        fill(50);
        text(a.name + " - " + a.wert + "€ - Standort: " + a.standort, 800, yOffset);
        yOffset += 30;
      }
    }
    
  }
  
  void drawConnections(Unternehmen u){
    Unternehmen uParent=null;
    for (Unternehmen uP : unternehmen) {
      if (u.mutter==uP.id) {
        uParent=uP;
        break;
      }
    }
    //line(u.x+random(1,10), u.y+random(1,10), uParent.x+random(1,10), uParent.y+random(1,10));//straight line
    beginShape();//fuzzy line
    for (float i = 0; i <= 1; i += 0.05) {
      float x = lerp(u.x+30, uParent.x+30, i) + random(-2, 2);
      float y = lerp(u.y+30, uParent.y+30, i) + random(-2, 2);
      vertex(x, y);
    }
    endShape();
    
  }
    
  //testen: grafische elemente
  void mousePressed() {
    //println("mousepressed:",mouseX,"/",mouseY);
    selectedU = null;
    for (Unternehmen u : unternehmen) {
      if (clicked(u,mouseX, mouseY)) {//if (u.clicked(mouseX, mouseY)) {
        selectedU = u;
        redraw();
        break;
      }
    }
    //println("selectedU=",selectedU.toString()," null",selectedU!=null);
    
  }
  
  ArrayList<Asset> getAssets() {
    ArrayList<Asset> uAssets = new ArrayList<Asset>();
    for (Asset a : assets) {
      if (a.besitzer.equals(selectedU.name)) {
        println("ASSET:",a.toString());
        uAssets.add(a);
      }
    }
    return uAssets;
  }
  
  //TODO: funktion hier oder in Unternehmen?
  void display(Unternehmen u) {
    
    if (selectedU != null && selectedU==u) {
      strokeWeight(4);
      stroke(0, 0, 255);
    }
    //color farbe = color(random(100, 255), random(100, 255), random(100, 255));
    fill(u.col);
    stroke(0);
    //rect(u.x+random(1,10), u.y+random(1,10), u.w+random(1,10), u.h+random(1,10));//straight line
    fuzzyRect(u.x+random(1,10), u.y+random(1,10), u.w+random(1,10), u.h+random(1,10));//fuzzy line
    fill(0);
    textAlign(CENTER, CENTER);
    text(u.name, u.x + u.w/2, u.y + u.h/2);
    
    
      strokeWeight(1);
      stroke(0);
  }
  
  void fuzzyRect(float x, float y, float w, float h) {
    beginShape();
    for (float i = 0; i <= 1; i += 0.1) {
      float x1 = lerp(x, x + w, i) + random(-5, 5); // X-Variation
      float y1 = lerp(y, y, i) + random(-5, 5);     // Y-Variation oben
      vertex(x1, y1);
    }
  
    for (float i = 0; i <= 1; i += 0.1) {
      float x1 = lerp(x + w, x + w, i) + random(-5, 5);  // X-Variation rechts
      float y1 = lerp(y, y + h, i) + random(-5, 5);       // Y-Variation rechts
      vertex(x1, y1);
    }
  
    for (float i = 0; i <= 1; i += 0.1) {
      float x1 = lerp(x + w, x, i) + random(-5, 5);  // X-Variation unten
      float y1 = lerp(y + h, y + h, i) + random(-5, 5); // Y-Variation unten
      vertex(x1, y1);
    }
  
    for (float i = 0; i <= 1; i += 0.1) {
      float x1 = lerp(x, x, i) + random(-5, 5);   // X-Variation links
      float y1 = lerp(y + h, y, i) + random(-5, 5);  // Y-Variation links
      vertex(x1, y1);
    }
    
    endShape(CLOSE);
  }
  
  boolean clicked(Unternehmen u,float mx, float my) {
    //println("u.x=",u.x," u.y=",u.y," u.w=",u.w," mx=",mx," my",my);
    boolean clickU=(mx > u.x) && (mx < (u.x + u.w)) && (my > u.y) && (my < (u.y + u.h));
    if (clickU) {
      println(u.toString());
    }
    return (clickU);
  }
  
}

import controlP5.*;

class GUIManager implements ControlListener{
  ControlP5 cp5;
Textlabel statusLabel;
Textfield companyInputField;
Button companyCreateButton;
Button spielzugAusfButton;
DropdownList possibleMovesList1;
DropdownList companiesList;
DropdownList assetsList;
Button raiseRentButton;

CompanyWindow companyWindow;
NewsFeedWindow newsFeedWindow;
PlayWindow playWindow;

color background = color(50);//dunkelgrau
//color background = color(173, 216, 230);//hellblau

PFont font;  

  GUIManager(PApplet p) {
    
    cp5 = new ControlP5(p);
    font = createFont("Arial", 18);
      
      
    //assets = readM.readAssets();//read assets aus data
    //unternehmen = readM.readUnternehmen();//read unternehmen aus data
    
    companyWindow = new CompanyWindow();
    //newsFeedWindow = new NewsFeedWindow();
    playWindow = new PlayWindow();
    
    /*int j=assets.length;
    println("assets.length ",j);
    for (int i = 0; i < assets.length; i++) {
      Asset asset = assets[i];
      println(asset.type," ",asset.subtype," ",asset.risiko," ",asset.wert," ",asset.name," ",asset.sitz," ",asset.bewertung);
    }*/
    
    addGUIElements(cp5);
    possibleMovesList1.addListener(this);
    spielzugAusfButton.addListener(this);
    companyCreateButton.addListener(this);
    companiesList.addListener(this);
    assetsList.addListener(this);
    raiseRentButton.addListener(this);
    
  }
  
  void addGUIElements(ControlP5 cp5) {
      statusLabel = cp5.addTextlabel("status")
                      .setText("Wähle einen Spielzug aus")
                      .setPosition(20, 30)
                      .setColor(color(255, 255, 255));
                
      possibleMovesList1 = cp5.addDropdownList("possibleMovesList")
         .setPosition(20, 50)
         .setSize(280, 200)
         .setItemHeight(30)
         .setBarHeight(30)
         .setColorBackground(color(60))
         .setColorActive(color(90))
         .setColorForeground(color(120))
         .setFont(font);
      possibleMovesList1.addItems(data.getJSONArray("possible_moves_structure").getStringArray());
      possibleMovesList1.setOpen(false);
      possibleMovesList1.close();
      possibleMovesList1.getCaptionLabel().setText("Mögliche Spielzüge") ;
      
      companiesList = cp5.addDropdownList("companiesList")
         .setPosition(20, 150)
         .setSize(280, 200)
         .setItemHeight(30)
         .setBarHeight(30)
         .setColorBackground(color(60))
         .setColorActive(color(90))
         .setColorForeground(color(120))
         .setFont(font);
      for (int i = 0; i < unternehmen.length; i++) {
        Unternehmen currentUnternehmen = unternehmen[i];
        companiesList.addItem(currentUnternehmen.name,currentUnternehmen.id);//TODO: id
      }
      companiesList.setOpen(false);
      companiesList.close();
      //companiesList.getCaptionLabel().setText("Mögliche Spielzüge") ;
      
      
      assetsList = cp5.addDropdownList("assetsList")
         .setPosition(20, 250)
         .setSize(280, 200)
         .setItemHeight(30)
         .setBarHeight(30)
         .setColorBackground(color(60))
         .setColorActive(color(90))
         .setColorForeground(color(120))
         .setFont(font);
         
      for (int i = 0; i < assets.length; i++) {
        Asset currentAsset = assets[i];
        println("currentAsset.name:",currentAsset.name);
        assetsList.addItem(currentAsset.name,currentAsset.id);
      }
      assetsList.setOpen(false);
      assetsList.close();
      //assetsList.getCaptionLabel().setText("Mögliche Spielzüge") ;
      
      /*possibleMovesList1.onClick(new CallbackListener() {
        public void controlEvent(CallbackEvent theEvent) {
          String selected = possibleMovesList1.getItem((int) possibleMovesList1.getValue()).get("name").toString();
          println("Ausgewählt: " + selected);
          possibleMovesList1.close();
          background(background);
        }
      });*/
    
    /*cp5.addListener(new ControlListener() {
      public void controlEvent(ControlEvent e) {
        if (e.isFrom(possibleMovesList1)){// && e.getAction() == ControlP5.ACTION_RELEASED) {
          String selected = possibleMovesList1.getItem((int) possibleMovesList1.getValue()).get("name").toString();
          println("Ausgewählt: " + selected);
          possibleMovesList1.close(); // schließt die Liste nach Auswahl
          background(background);
        }
      }
    });*/
      
    spielzugAusfButton = cp5.addButton("ausfuehren")
         .setLabel("Spielzug ausführen")
         .setPosition(380, 50)
         .setFont(font)
         .setSize(240, 40);
         
         
    raiseRentButton = cp5.addButton("raiseRentButton")
         .setLabel("Miete erhöhen")
         .setPosition(380, 150)
         .setFont(font)
         .setSize(240, 40);
         
    /*cp5.addListener(new ControlListener() {
      public void controlEvent(ControlEvent e) {
        if (e.isFrom(spielzugAusfButton)){
        }
      }
    });*/
      
      companyCreateButton = cp5.addButton("gruenden")
         .setLabel("Gründe Unternehmen")
         .setPosition(380, 300)
         .setFont(font)
         .setSize(280, 40);
         /*.onClick(new CallbackListener() {
                  public void controlEvent(CallbackEvent theEvent) {
                    gruendeUnternehmen();
                  }
                });*/
         //.hide();
         
      
      companyInputField = cp5.addTextfield("input")
         .setPosition(380, 120)
         .setSize(400, 30)
         .setFont(font)
         .setFocus(true)
         .setColor(color(200, 200, 200))
         .setText("4 Gamma2 3 Österreich Österreich 21800 200 20000 2000 BB 400 100")
         .hide();
         
      //cp5.getController("input").getCaptionLabel().setText("Bitte Unternehmensdaten eingeben \n(name mutter land-Gruendung land-Sitz unternehmenswert \nliquide-Mittel marktkapitalisierung schulden kreditrating");
      
      //possibleMovesList1.addListener(cp5);
      //Gamma Alpha Österreich Österreich 21800 200 20000 2000 BB
      //cp5.getController("possibleMovesList1").addListener(p);
      //cp5.getController("spielzugAusfButton").addListener(p, "controlEvent");
  }
  
  void controlEvent(ControlEvent e) {
        println("ControlEvent:");
        
         if(e.getController().getName()=="ausfuehren") {
           
        println("ControlEventxx:");
         }
        if(e.isController()) { 
         print("control event from : "+e.getController().getName());
         println(", value : "+e.getController().getValue());
        }
        
      if (e.isFrom(possibleMovesList1)){
        selectedSpielzug = possibleMovesList1.getItem((int) possibleMovesList1.getValue()).get("name").toString();
        println("Ausgewähltxx: " + selectedSpielzug);
        possibleMovesList1.close(); // schließt die Liste nach Auswahl
        background(background);
      }
      
      if (e.isFrom(spielzugAusfButton)){
        
        println("Spielzug ausgeführtxx: " + selectedSpielzug);//statusLabel.setText("Spielzug ausgeführt: " + selectedSpielzug);
        if (selectedSpielzug.equals("")) return;//kein spielzug selektiert
        println("Spielzug ausgeführtxx: " + selectedSpielzug);//statusLabel.setText("Spielzug ausgeführt: " + selectedSpielzug);
        
        if (selectedSpielzug.equals("tochter gruenden")) {
          companyInputField.show();
          companyInputField.setFocus(true);
          companyCreateButton.show();
        } else  if (selectedSpielzug.equals("immobilie kaufen")) {
        println("immobilie kaufen");
        } else  if (selectedSpielzug.equals("immobilie verkaufen")) {
        println("immobilie verkaufen");
        } else  if (selectedSpielzug.equals("unternehmen kaufen")) {
        println("unternehmen kaufen");
        } else  if (selectedSpielzug.equals("spv gruenden")) {
        println("spv gruenden");
        } else  if (selectedSpielzug.equals("verbriefung erstellen")) {
        println("verbriefung erstellen");
        } else  if (selectedSpielzug.equals("verbriefung verkaufen")) {
        println("verbriefung verkaufens");
        }
      }
        
      if (e.isFrom(companyCreateButton)){
        gruendeUnternehmen();
      }
      
      
      if (e.isFrom(companiesList)){
        background(background);
      }
      
      if (e.isFrom(assetsList)){
        background(background);
      }
      
      if (e.isFrom(raiseRentButton)){
        background(background);
      }
      
      
  }
  
/*  void possibleMovesList(int n) {
    selectedSpielzug = cp5.get(DropdownList .class, "possibleMovesList").getItem(n).get("name").toString();
    println("Ausgewählt: " + selectedSpielzug);//statusLabel.setText("Ausgewählt: " + selectedSpielzug);
    possibleMovesList1.close();
    background(background);
  }
  */
  void ausfuehrenx() {
    if (selectedSpielzug.equals("")) return;//kein spielzug selektiert
    println("Spielzug ausgeführt: " + selectedSpielzug);//statusLabel.setText("Spielzug ausgeführt: " + selectedSpielzug);
    
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
    if (companyInputField.getText().equals("")) return;//kein spielzug selektiert //<>//
    println("inputfield="+companyInputField.getText() + " " + str(getMaxUid()));
    String[] companyFields = split(companyInputField.getText() + " " + str(getMaxUid()), " ");
    
    Unternehmen u = new Unternehmen(companyFields);
    println("Unternehmen neu="+u.toString());
    saveCompanies(u);//gespeichert in data
    playWindow.redraw();
    unternehmen = readM.readUnternehmen();//TODO: ersetzen durch aufruf in 1. draw
    
    //TODO: update scores
    cur_score_prestige=cur_score_prestige;
    cur_score_eigenkapital=cur_score_eigenkapital;
    cur_score_fremdkapital=cur_score_fremdkapital;
  
  
    saveScores();//bei einem zug
    valsChanged=true;
  }
}

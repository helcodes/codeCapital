
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

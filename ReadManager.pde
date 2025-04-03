class ReadManager {
  Asset [] assets;
  Score [] scores;
  Schuld [] schulden;
  Glaeubiger [] glaeubiger;
  Unternehmen [] unternehmen;
  //ArrayList<Asset> assets;
  
  public void readFromJson() {
    
  }
  
  
public Schuld [] readSchulden() {
  JSONArray schuldenj = data.getJSONArray("schulden");
  schulden = new Schuld[schuldenj.size()];
  for (int i = 0; i < schuldenj.size(); i++) {
    Schuld schuld = new Schuld();
    JSONObject schuldj = schuldenj.getJSONObject(i);
    schuld.id = schuldj.getInt("id");
    schuld.unternehmen = schuldj.getString("unternehmen");
    schuld.glaeubiger = schuldj.getString("glaeubiger");
    schuld.betrag = schuldj.getInt("betrag");
    schuld.rateProZeit = schuldj.getInt("rateProZeit");
    schuld.verbleibend = schuldj.getInt("verbleibend");
    schulden[i]=schuld;
    //println("ASSETS: ",asset.type," ",asset.subtype," ",asset.risiko," ",asset.wert," ",asset.name," ",asset.sitz," ",asset.bewertung);
  }
  return schulden;
}


public Unternehmen [] readUnternehmen() {
  JSONArray unternehmenj = data.getJSONArray("unternehmen");
  unternehmen = new Unternehmen[unternehmenj.size()];
  for (int i = 0; i < unternehmenj.size(); i++) {
    Unternehmen unternehmen1 = new Unternehmen();
    JSONObject unternehmen1j = unternehmenj.getJSONObject(i);
    //println(unternehmen1j);
    unternehmen1.id = unternehmen1j.getInt("id");
    unternehmen1.name = unternehmen1j.getString("name");
    unternehmen1.mutter = unternehmen1j.getString("mutter");
    unternehmen1.landSitz = unternehmen1j.getString("land_sitz");
    unternehmen1.landGruendung = unternehmen1j.getString("land_gruendung");
    unternehmen1.schulden = unternehmen1j.getInt("schulden");
    unternehmen1.unternehmenswert = unternehmen1j.getInt("unternehmenswert");
    unternehmen1.liquideMittel = unternehmen1j.getInt("liquide_mittel");
    unternehmen1.marktkapitalisierung = unternehmen1j.getInt("marktkapitalisierung");
    unternehmen1.kreditrating = unternehmen1j.getString("kreditrating");
    unternehmen[i]=unternehmen1;
    //println("ASSETS: ",asset.type," ",asset.subtype," ",asset.risiko," ",asset.wert," ",asset.name," ",asset.sitz," ",asset.bewertung);
  }
  return unternehmen;
}


public Glaeubiger [] readGlaeubiger() {
  JSONArray glaeubigerj = data.getJSONArray("glaeubiger");
  glaeubiger = new Glaeubiger[glaeubigerj.size()];
  for (int i = 0; i < glaeubigerj.size(); i++) {
    Glaeubiger glaeubiger1 = new Glaeubiger();
    JSONObject glaeubiger1j = glaeubigerj.getJSONObject(i);
    glaeubiger1.name = glaeubiger1j.getString("name");
    glaeubiger1.landSitz = glaeubiger1j.getString("land_sitz");
    glaeubiger[i]=glaeubiger1;
    //println("ASSETS: ",asset.type," ",asset.subtype," ",asset.risiko," ",asset.wert," ",asset.name," ",asset.sitz," ",asset.bewertung);
  }
  return glaeubiger;
}

public Score [] readScores() {
  JSONArray scoresj = data.getJSONArray("scores");
  scores = new Score[scoresj.size()];
  for (int i = 0; i < scoresj.size(); i++) {
    Score score = new Score();
    JSONObject scorej = scoresj.getJSONObject(i);
    score.eigenkapital = scorej.getInt("eigenkapital");
    score.prestige = scorej.getInt("prestige");
    score.zeit = scorej.getInt("zeit");
    scores[i]=score;
    //println("ASSETS: ",asset.type," ",asset.subtype," ",asset.risiko," ",asset.wert," ",asset.name," ",asset.sitz," ",asset.bewertung);
  }
  return scores;
}
  
public Asset [] readAssets() {
  //JSONArray assetsj = data.getJSONArray("asset");
  JSONArray assetsj = data.getJSONArray("asset");
  //JSONObject asset_immo = assetsj.getJSONObject(0);
  //JSONObject asset_konzerne = assetsj.getJSONObject(1);
  //JSONObject asset_ekh = assetsj.getJSONObject(2);
  
  assets = new Asset[assetsj.size()];
  
  for (int i = 0; i < assetsj.size(); i++) {
    Asset asset = new Asset();
    //JSONArray assetsj2 = assetsj.getJSONArray("assets");
    JSONObject assetj = assetsj.getJSONObject(i);
    asset.type = assetj.getString("type");
    asset.subtype = assetj.getString("subtype");
    asset.risiko = assetj.getFloat("risiko");
    asset.wert = assetj.getInt("wert");
    asset.name = assetj.getString("name");
    asset.sitz = assetj.getString("sitz");
    asset.bewertung = assetj.getInt("bewertung");
    assets[i]=asset;
    //println("ASSETS: ",asset.type," ",asset.subtype," ",asset.risiko," ",asset.wert," ",asset.name," ",asset.sitz," ",asset.bewertung);
  }
  
  /*JSONArray immobilien = asset_immo.getJSONArray("immobilien");
  JSONObject immobilie = immobilien.getJSONObject(0);
  String immo_type = immobilie.getString("type");
  String immo_name = immobilie.getString("name");
  int immo_wert = immobilie.getInt("wert");
  println(immo_type," ",immo_name," ",immo_wert);
  
  JSONArray konzerne = asset_konzerne.getJSONArray("konzerne");
  JSONObject konzern = konzerne.getJSONObject(0);
  String konzern_type = konzern.getString("type");
  String konzern_name = konzern.getString("name");
  int konzern_wert = konzern.getInt("wert");
  println(konzern_type," ",konzern_name," ",konzern_wert);
  
  JSONArray ekhs = asset_ekh.getJSONArray("einzelhandelsketten");
  JSONObject ekh = ekhs.getJSONObject(0);
  String ekh_type = ekh.getString("type");
  String ekh_name = ekh.getString("name");
  int ekh_wert = ekh.getInt("wert");
  println(ekh_type," ",ekh_name," ",ekh_wert);*/
  
  return assets;
}
  
}

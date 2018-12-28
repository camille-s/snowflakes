import processing.pdf.*;

JSONArray json;
Snowflake[] flakes;
float margin = 140;
PFont frutiger;

void setup() {
  size(800, 280);

  String[] cities = loadJson("snow.json");
  
  String filename = makeFilename(cities);
  
  beginRecord(PDF, filename);
  
  frutiger = createFont("FrutigerLTStd-Cn", 20);
  textFont(frutiger);
  
  fill(10);
  noLoop();
}

void draw() {
  background(255);
  
  for (int i = 0; i < flakes.length; i++) {
    flakes[i].display();
  }
  
  endRecord();
}

String makeFilename(String[] cities) {
  //float[] date = { year(), month(), day() };
  //float[] time = { hour(), minute() };
  //String dateStr = join(nf(date), "");
  //String timeStr = join(nf(time), "");
  //String[] datetime = { dateStr, timeStr }; 
  String name = join(cities, "_").toLowerCase();
  
  return "snowflakes_" + name + ".pdf";
}

////////////////////////////////

String[] loadJson(String path) {
  json = loadJSONArray(path);
  flakes = new Snowflake[json.size()];
  String[] cities = new String[json.size()];
  
  for (int i = 0; i < json.size(); i++) {
    JSONObject flakeJson = json.getJSONObject(i);
    String city = flakeJson.getString("city");
    JSONArray dataJson = flakeJson.getJSONArray("data");
    int n = dataJson.size();
    float[] dates = new float[n];
    float[] values = new float[n];
    for (int j = 0; j < n; j++) {
      JSONObject observation = dataJson.getJSONObject(j);
      dates[j] = observation.getFloat("date");
      values[j] = observation.getFloat("value");
    }
    
    float x;
    if (json.size() == 1) {
      x = width / 2.0;
    } else {
      x = map(float(i), 0, json.size() - 1, margin, width - margin);
    }
    //float x = map(float(i), 0, json.size() - 1, margin, width - margin);
    //float x = lerp(margin, width - margin, float(i) / (json.size() - 1));
    float r = 2 * sqrt(max(dates));
    flakes[i] = new Snowflake(city, x, height / 2.0, r, dates, values);
    
    cities[i] = city;
  }
  return cities;
}

void keyPressed() {
  if (key == 's') {

  }
}

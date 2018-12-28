class Snowflake {
  String name;
  float x, y;
  float radius;
  float[] dates, values;
  int wedge = 60;
  color c = color(114, 185, 232, 120);
  
  Snowflake(String name_, float x_, float y_, float r_, float[] dates_, float[] values_) {
    name = name_;
    x = x_;
    y = y_;
    dates = dates_;
    values = values_;
    radius = r_;
  }
  
  void display() {
    for (int theta = 0; theta < 360; theta += wedge) {
      pushMatrix();
      translate(x, y);
      stroke(c);
      strokeWeight(2);
      strokeCap(SQUARE);
      rotate(radians(theta));
      line(0, 0, radius, 0);
      
      ticks();
            
      popMatrix();
    }
    drawName();
  }
  
  void ticks() {
    for (int i = 0; i < dates.length; i++) {
      float tickX = lerp(0, radius, dates[i] / max(dates));
      float tickY = values[i];
      line(tickX, -tickY / 2, tickX, tickY / 2);
    }
  }
  
  void drawName() {
    textAlign(CENTER);
    text(name, x, height - 24);
  }
};

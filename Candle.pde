class Candle {
  float size;
  float locX;
  float locY;

  Candle(float _size, float _locX, float _locY) {
    size = _size;
    locX = _locX;
    locY = _locY;
  }
  
  
  void display() {
    if (lightDark == false) {
    stroke(255,255,255);
      fill(255,255,255);
    } else {
     stroke(255,255,255); 
       fill(255,255,255);
    }
  
    ellipse(locX, locY, size+(pulseValue*5), size+(pulseValue*5));
  }
    void nodisplay() {
      stroke(255,255,255);
      noFill();
    ellipse(locX, locY, size, size);
  }
}
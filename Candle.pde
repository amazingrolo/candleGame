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
   
    stroke(255,255,255);
      fill(255,255,255);
  
  
  
    ellipse(locX, locY, size+(pulseValue*5), size+(pulseValue*5));
  }
      void nodisplay() {
      stroke(255,255,255);
      noFill();
    ellipse(locX, locY, size, size);
  }
  
  
  void displayMode() {
    fill(0,255,0);
          stroke(255,255,255);
    ellipse(locX, locY-100, 10, 10);
  }
  
    void nodisplayMode() {
    noFill();
          stroke(255,255,255);
    ellipse(locX, locY-100, 10,10);
  }
  

}
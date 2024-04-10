import processing.core.PApplet;

class Button {
  PApplet p; 
  float x, y; 
  float width, height; 
  String label; 
  boolean isOver = false;
  boolean labelVisible = true;
  boolean active; 

  
  Button(PApplet p, String label, float x, float y, float width, float height, boolean active) {
    this.p = p;
    this.label = label;
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.active = active;
  }

  
  boolean isOver(float mx, float my) {
    if (mx >= x && mx <= x + width && my >= y && my <= y + height) {
      isOver = true;
      return true;
    } else {
      isOver = false;
      return false;
    }
  }

 
  void display() {
    p.fill(255);
    p.rect(x, y, width, height);
    if (labelVisible) {
      p.fill(0);
      p.textAlign(PApplet.CENTER, PApplet.CENTER);
      p.text(label, x + width / 2, y + height / 2);
    }
  }
}

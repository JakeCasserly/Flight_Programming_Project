class Button {
  float x, y; 
  float width, height; 
  String label; 
  boolean isOver;
  boolean labelVisible; 
  
 
  Button(String lbl, float xPos, float yPos, float w, float h, boolean isVisible) {
    label = lbl;
    x = xPos;
    y = yPos;
    width = w;
    height = h;
    isOver = false;
    labelVisible = isVisible; 
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
    
    
    
    if (labelVisible && isOver) {
      fill(0); 
      textSize(12);
      textAlign(CENTER, CENTER);
      text(label, x + width / 2, y + height / 2);
    }
  }
}

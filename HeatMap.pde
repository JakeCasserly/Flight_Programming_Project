// HeatMap
// Jake Casserly's code for Heat map using an svg file

class HeatMap {
  int xpos;
  int ypos;
  PShape img;
  
  HeatMap(int xpos, int ypos, PShape img) {
    this.xpos = xpos;
    this.ypos = ypos;
    this.img = img;
  }
  
  void draw() {
    img.enableStyle();
    noStroke();
    fill(255);
    rect(70,210,1380,720);
    img.setFill(color(20, 50, 123));
    shape(img, 200, 264);
  }
  
}
  

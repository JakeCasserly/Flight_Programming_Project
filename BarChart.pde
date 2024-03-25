// barChart
// Jake Casserly's code for Bar Chart 20/03/2024

class barChart {
  int x;
  int y;
  double height;
  double width;
  
  barChart (int x, int y, double height, double width) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
  }
  
  void draw() {
    fill(255);
    strokeWeight(7);
    line(300, 150, 300, 800);
    line(300, 800, 900, 800);
  }
}

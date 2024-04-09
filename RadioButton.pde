class RadioButton 
{
  float x,y, radius;
  String label;
  color highlightColor;
  
   RadioButton(float x, float y, int radius, String label, color highlightColor)
   {
     this.x = x;
     this.y = y;
     this.radius = radius;
     this.label = label;
     this.highlightColor = highlightColor;
     
   }

   boolean checkMouse(float mx, float my) 
   {
      return (mx > x-radius/2 && mx < x+radius/2 && my > y-radius/2 && my < y+radius/2);
   }
  
  void draw()
  {
    if(checkMouse(mouseX,mouseY))
    {
      stroke(highlightColor);
      fill(255, 255, 0);
      ellipse(x,y,radius,radius);
      fill(highlightColor);
      ellipse(x,y,radius*0.6,radius*0.6);
    }
    else    
    {
      fill(255, 255, 0);
      ellipse(x,y,radius,radius);
    }
    textSize(radius);
    fill(0);
    text(label,x+textWidth(label)*0.75,y);
  }
}

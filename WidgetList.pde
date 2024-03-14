class WidgetList 
{
  ArrayList<Widget> buttons;
  
  WidgetList() 
  {
    buttons = new ArrayList<Widget>();
  }
  
  void addButton(String label, color widgetColor, int screen) 
  {
    float x = (buttons.size() * 500) + 60;
    Widget button = new Widget(x, 400, 400, 100, label, widgetColor, screen);
    buttons.add(button);
  }
  
  void display() 
  {
    for (Widget button : buttons) 
    {
      button.display();
    }
  }
  
  void checkButtons(float mx, float my) 
  {
    for (Widget button : buttons) 
    {
      button.checkMouse(mx, my);
    }
  }
  
  void checkButtonsBorder(float mx, float my)
  {
    for (Widget button : buttons) 
    {
      button.checkBorder(mx, my);
    }
  }
}

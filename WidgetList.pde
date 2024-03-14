class WidgetList 
{
  ArrayList<Widget> buttons;
  ArrayList<Widget> flightScreenButtons;
  
  WidgetList() 
  {
    buttons = new ArrayList<Widget>();
    flightScreenButtons = new ArrayList<Widget>();
  }
  
  void addButton(String label, color widgetColor, int screen) 
  {
    float x = (buttons.size() * 500) + 60;
    Widget button = new Widget(x, 400, 400, 100, label, widgetColor, screen);
    buttons.add(button);
  }
  
  void addFlightScreenButton(String label, color widgetColor, int screen) 
  {
    float x = (flightScreenButtons.size() * 305);
    Widget button = new Widget(x, 100, 290, 100, label, widgetColor, screen);
    flightScreenButtons.add(button);
  }
  
  void display() 
  {
    for (Widget button : buttons) 
    {
      button.display();
    }
    for(Widget button : flightScreenButtons)
    {
      button.display1();
    }
  }
  
  void checkButtons(float mx, float my) 
  {
    for (Widget button : buttons) 
    {
      button.checkMouse(mx, my);
    }
    for (Widget button : flightScreenButtons) 
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
    for (Widget button : flightScreenButtons) 
    {
      button.checkBorder(mx, my);
    }
  }
}

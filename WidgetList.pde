class WidgetList 
{
  ArrayList<Widget> buttons;
  ArrayList<Widget> flightScreenButtons;
  ArrayList<Widget> heatMapStates;
  ArrayList<Widget> barChartButtons;
  
  WidgetList() 
  {
    buttons = new ArrayList<Widget>();
    flightScreenButtons = new ArrayList<Widget>();
    heatMapStates = new ArrayList<Widget>();
    barChartButtons = new ArrayList<Widget>();
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
    Widget button = new Widget(x, 50, 290, 35, label, widgetColor, screen);
    flightScreenButtons.add(button);
  }
  
  void addBarChartButton(String label, color widgetColor, int screen)
  {
    Widget button = new Widget(1220, 110, 290, 35, label, widgetColor, screen);
    barChartButtons.add(button);
  }
  
  boolean checkBarChartButton(float mx, float my)
  {
    if (mx > 1220 && mx < 1220 + width && my > 110 && my < 140)
    {
      return true;
    }
    return false;
  }
  
  void setBarChartButtonLabel(String newLabel) 
  {
    for (Widget button : barChartButtons) 
    {
        button.label = newLabel;
    }
  }
  
  void addState(String label, color widgetColor, int screen, float xpos, float ypos) 
  {
    //float x = (buttons.size() * 500) + 60;
    Widget button = new Widget(xpos, ypos, 400, 100, label, widgetColor, screen);
    buttons.add(button);
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
    for(Widget button : barChartButtons)
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
    for (Widget button : flightScreenButtons) 
    {
      button.checkMouse(mx, my);
    }
    for(Widget button : barChartButtons)
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
    for(Widget button : barChartButtons)
    {
      button.checkBorder(mx, my);
    }
  }
}

class StateDetailsScreen {
    Button backButton;
    String state = ""; 
    
    
    StateDetailsScreen() {
        
        backButton = new Button("Back", 50, 700, 100, 50, true); 
    }

    void setState(String state) {
        this.state = state;
    }

    void display() {
        fill(240); 
        rect(0, 0, width, height);
        backButton.display();
        
        fill(0); 
        textSize(24);
        textAlign(LEFT, TOP);
        text("Details for " + state, 50, 50); 
    }

    boolean backButtonHovered(int mouseX, int mouseY) {
        return backButton.isOver(mouseX, mouseY);
    }
}

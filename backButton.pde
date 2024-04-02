class BackButton {
    float x, y; 
    float width, height; 
    String label; 
    color baseColor; 
    color hoverColor; 
    boolean labelVisible; 

   
    BackButton(String label, float x, float y, float width, float height, boolean labelVisible) {
        this.label = label;
        this.x = x;
        this.y = y;
        this.width = width;
        this.height = height;
        this.labelVisible = labelVisible;
      
    }

    
    boolean isOver(int mouseX, int mouseY) {
        return mouseX >= x && mouseX <= x + width && mouseY >= y && mouseY <= y + height;
    }

    
    void display() {
        if (isOver(mouseX, mouseY)) {
            fill(0, 0, 0, 127);
        } else {
            noFill();
        }
        rect(x, y, width, height, 7); 

        if (labelVisible) {
            fill(0); // Black text
            textAlign(CENTER, CENTER);
            text(label, x + width / 2, y + height / 2);
        }
    }
}

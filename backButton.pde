class BackButton {
    float x, y; 
    float width, height; 
    String label; 
    color baseColor; 
    color hoverColor; 
    boolean labelVisible; 

   
    BackButton(String label, float x, float y, float width, float height, boolean labelVisible, color baseColor, color hoverColor) {
        this.label = label;
        this.x = x;
        this.y = y;
        this.width = width;
        this.height = height;
        this.labelVisible = labelVisible;
        this.baseColor = baseColor;
        this.hoverColor = hoverColor;
    }

    
    boolean isOver(int mouseX, int mouseY) {
        return mouseX >= x && mouseX <= x + width && mouseY >= y && mouseY <= y + height;
    }

    
    void display() {
        if (isOver(mouseX, mouseY)) {
            fill(hoverColor);
        } else {
            fill(baseColor);
        }
        rect(x, y, width, height, 7); 

        if (labelVisible) {
            fill(0); // Black text
            textAlign(CENTER, CENTER);
            text(label, x + width / 2, y + height / 2);
        }
    }
}

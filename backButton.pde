import processing.core.PApplet; // Import PApplet

class BackButton {
    PApplet p; 
    float x, y; 
    float width, height; 
    String label; 
    int baseColor; 
    int hoverColor; 
    boolean labelVisible; 

    
    BackButton(PApplet p, String label, float x, float y, float width, float height, boolean labelVisible) {
        this.p = p; 
        this.label = label;
        this.x = x;
        this.y = y;
        this.width = width;
        this.height = height;
        this.labelVisible = labelVisible;
        
        this.baseColor = p.color(200);
        this.hoverColor = p.color(255, 200, 200);
    }

    
    boolean isOver(int mouseX, int mouseY) {
        return mouseX >= x && mouseX <= x + width && mouseY >= y && mouseY <= y + height;
    }

    
    void display() {
        p.stroke(0); 
        if (isOver(p.mouseX, p.mouseY)) {
            p.fill(hoverColor); 
        } else {
            p.fill(baseColor); 
        }
        p.rect(x, y, width, height, 7); 

        if (labelVisible) {
            p.fill(0); 
            p.textAlign(PApplet.CENTER, PApplet.CENTER);
            p.text(label, x + width / 2, y + height / 2);
        }
    }
}

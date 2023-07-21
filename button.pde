//Simple button class I wrote because I realised processing doesnt have one pre-built
class Button {
  float buttonWidth ;   
  float buttonHeight;
  float buttonX;
  float buttonY;
  boolean mouseOverButton;

  int currentButtonColor;
  int buttonDefaultColor;
  int buttonHighlight;

  Button(float xPos, float yPos, float buttonWidth, float buttonHeight, int buttonDefaultColor) { // constructor
    this.buttonX = xPos;
    this.buttonY = yPos;
    this.buttonWidth  = buttonWidth;
    this.buttonHeight = buttonHeight;
    //Both start default
    this.currentButtonColor = buttonDefaultColor;
    this.buttonDefaultColor = buttonDefaultColor; // used for resetting
  }

  public void drawButton() {
    noFill();
    stroke(this.currentButtonColor);
    rect(this.buttonX, this.buttonY, this.buttonWidth, this.buttonHeight, 7); // 7 for curvey edges
    this.returnHover();
  }

  public boolean returnHover() {
    if (mouseX >= this.buttonX && mouseX <= this.buttonX + this.buttonWidth && mouseY >= this.buttonY && mouseY <= this.buttonY + this.buttonHeight) {
      this.currentButtonColor = buttonHighlight; // draw it highlighted (highlight defined in main file)
      return true;
    } else {
      this.currentButtonColor = this.buttonDefaultColor; // draw it as not highlighted
      return false;
    }
  }
}

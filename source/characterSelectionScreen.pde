public void characterSelect() {
  background(255, 255, 255);


  switch(player.getColour()) {   
    case(0):
    currentCharacterColour = color(0, 0, 255);
    characterSelectionImage = loadImage("BlueBackgroundFinal.png");
    break;

    case(1):
    currentCharacterColour = color(255, 0, 0);
    characterSelectionImage = loadImage("RedBackgroundFinal.png");
    break;

    case(2):
    currentCharacterColour = color(255,0,255);
    characterSelectionImage = loadImage("PurpleBackgroundFinal.png");
    break;
    
    case(3):
    currentCharacterColour = color(0,255,0);
    characterSelectionImage = loadImage("GreenBackgroundFinal.png");
    break;
    
    case(4):
    currentCharacterColour = color(255, 195, 11);
    characterSelectionImage = loadImage("YellowBackgroundFinal.png");
    break;
  }


  image(characterSelectionImage, 0, 0);


  player.drawCharacterSheet();
  if (rightKey) {
    if (!chaosMode) {
      level = 2;
    } else {
      level = 3;
    }
  }
  if (leftKey && spamPrevention) {
    player = new Character();     
    spamPrevention = false;
  }

  quitButton.returnHover();
  image(backArrow, -15, height-100);
}

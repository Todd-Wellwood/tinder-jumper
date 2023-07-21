public void characterSelect() {
  background(255, 255, 255);
  switch(player.getColour()) {   // display background dependant on character colour
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


  image(characterSelectionImage, 0, 0); // draw background


  player.drawCharacterSheet();
  if (rightKey && !rightHeldOnDeath) { // player selected a character (death prevention for instant selecting charcter)
    if (!chaosMode) {
      level = 2; // if they clicked normal mode
    } 
    else {
      level = 3; // else go to chaos mode
    }
  }
  if (leftKey && spamPrevention) { // spam prevention makes it so you can only flick through one at a time
    player = new Character();      // generate new character
    spamPrevention = false; // turn it off till they release (Re-enables)
  }

  quitButton.returnHover();
  image(backArrow, -15, height-100); // draw back button
}

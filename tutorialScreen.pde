public void displayTutorial() {
  image(tutorialScreen, 0, 0);

  fill(255, 0, 255); // wall of text that explains how to play
  textSize(35);
  text("How To Play:\nMove: Left and Right Arrow Keys\nPowerup: Spacebar\nCharacter Select:\nLeft To Reject, Right To Accept\n\nEach Character Has Traits!\nFat - Platforms Insta Break\nColourblind - GrayScale\nFly in Eye - Randomly Blink!\nTech Savy - New Powerup at 25m\nHat - Cool Hat\nFlipped! - Game runs upside down", 20, 210); // purple fill
  strokeWeight(1);
  fill(255, 192, 203);
  text("How To Play:\nMove: Left and Right Arrow Keys\nPowerup: Spacebar\nCharacter Select:\nLeft To Reject, Right To Accept\n\nEach Character Has Traits!\nFat - Platforms Insta Break\nColourblind - GrayScale\nFly in Eye - Randomly Blink!\nTech Savy - New Powerup at 25m\nHat - Cool Hat\nFlipped! - Game runs upside down", 20, 210); // purple fill


  fill(255, 0, 255);
  text("To Unlock Chaos Mode\nReach 50 Meters!", 100, 870);
  strokeWeight(1);
  fill(255, 192, 203);
  text("To Unlock Chaos Mode\nReach 50 Meters!", 100, 870);





  
  // Credits
  strokeWeight(5);
  fill(255, 0, 255);
  textSize(35);
  text("Made by Todd Wellwood!", 80, height-30); // purple border
  strokeWeight(1);
  fill(255, 255, 255);
  text("Made by Todd Wellwood!", 80, height-30); // purple border

  quitButton.returnHover();
  image(backArrow, -15, height-100);
}

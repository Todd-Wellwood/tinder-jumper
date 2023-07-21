public void runChaosGame() {
  if (flipped == true) {
    scale(1, -1);
    translate(0, -height);
  }
  drawBackground(); // draw the background
  if (totalHeight/150 > 25 && player.techSavy == true && restockAvalible) { // restock player with new powerup once over 25 meteres
    player.powerup = (int) randomInt(0, 3);
    restockAvalible = false;
  }
  textSize(50);
  text((int) Math.ceil(totalHeight/150) + " Meters!", width/2- 80, 100); // display total height
  fill(255, 255, 255);
  if (platformsArray.size() < platformCount) { // spawn new platform if array of platforms isnt full
    platformsArray.add(new Platform(false));
  }

  for (int i = 0; i < platformsArray.size(); i++) { // for every platform (used arraylist not hashset)
    if (!platformsArray.get(i).broken) { // if it isnt already broken
      if (platformsArray.get(i).superPlatform == false) {     // if not super platform 
        platformsArray.get(i).movePlatform(); // move it
      }
      platformsArray.get(i).drawPlatform();   // draw platform in current place
      if (player.checkVelocity() && platformsArray.get(i).checkBounce(player.getCenter(), player.getFeetPos())) {
        player.hitPlatform(); // if players feet is on platform then run the hitplatform
      }
    }
    if (platformsArray.get(i).getHeight() > height) { // if off the screen
      if (platformsArray.get(i).superPlatform == true) { // if it was superplatform lower max count (This stops game from breaking platform pre-laid out positioning
        platformCount--;
      };
      platformsArray.remove(i); // remove the platform once off screen
    };
  }
  if ( keyCode == ' ') { // if spacebar pressed
    player.usePowerup(); // use powerup
  }
  player.drawCharacter(); // draw character
  player.checkHeight(); // check if character is too high


  pushMatrix();
  if (flipped == true) { // translate the button back to regular viewing
    scale(1, -1);
    translate(0, -height);
  }

  quitButton.returnHover();
  image(backArrow, -15, height-100);
  popMatrix();

  if (totalHeight /150 > highScore) { // if bigger than the highscore,
    highScore = (int) totalHeight / 150; // highscore = new score
  }
  if (player.colourblind) { // if colourblind run in grayscale
    filter(GRAY);
  }
}

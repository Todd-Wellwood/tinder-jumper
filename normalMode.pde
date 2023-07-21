public void runNormalGame() {
  if (flipped == true) { // draw game inverted
    scale(1, -1);
    translate(0, -height);
  }
  drawBackground(); // draw backgorund
  if(totalHeight/150 > 25 && player.techSavy == true && restockAvalible){ // if tech savy character restock once pased 25 meters
    player.powerup = (int) randomInt(0, 3);
    restockAvalible = false;
  }
  
  // draws the meters counter at the top of the screen
  textSize(50);
  text((int) Math.ceil(totalHeight/150) + " Meters!", width/2- 80, 100);
  fill(255, 255, 255);

  if (platformsArray.size() < platformCount) { // adds a new platform if one went off teh screen
    platformsArray.add(new Platform(false));
  }

  for (int i = 0; i < platformsArray.size(); i++) {
    if (!platformsArray.get(i).broken) { // if it isnt already broken
      platformsArray.get(i).drawPlatform();   // draw platform on screen
      if (player.checkVelocity() && platformsArray.get(i).checkBounce(player.getCenter(), player.getFeetPos())) {
        player.hitPlatform(); // if falling down and the player is ontop of platform report the user hit a platform
      }
    }
    if (platformsArray.get(i).getHeight() > height) { // if platform off screen
      if (platformsArray.get(i).superPlatform == true) { 
        platformCount--; // super platform needs to remove one from total count so that spacing isnt broken
      };
      platformsArray.remove(i); // remove the platform
    };
  }
  if ( keyCode == ' ') { // use powerup on spacebar pressed
    player.usePowerup();
  }


  // Game ending portal
  if (Math.ceil(totalHeight/150) >= 50) { // if player is higher than 50 meteres spawn the portal
    image(portal, width/2-150, portalYPos);
    portalYPos++;
    if (dist(player.xPos + (player.characterWidth/2), player.yPos, width/2, portalYPos+150) < 100) { // if the player within the  portal
      chaosModeUnlocked = true; // unlock chaos mode
      delay(500); // pause
      // reset back to menu
      player = new Character();
      resetVariables(false);
      level = -1;
    }
  }

  player.drawCharacter();
  player.checkHeight();

 
  pushMatrix(); // push  so that flipping works properly and doesnt effect button
  if (flipped == true) {
    scale(1, -1);
    translate(0, -height);
  }

  quitButton.returnHover();
  image(backArrow, -15, height-100);
  popMatrix();
  
  if(player.colourblind){ // black and white filter if colourblind
      filter(GRAY);
  }
}

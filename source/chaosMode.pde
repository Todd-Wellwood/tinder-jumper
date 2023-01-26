public void runChaosGame() {
  if (flipped == true) {
    scale(1, -1);
    translate(0, -height);
  }
  drawBackground();


  textSize(50);
  text((int) Math.ceil(totalHeight/150) + " Meters!", width/2- 80, 100);
  fill(255, 255, 255);

  if (platformsArray.size() < platformCount) {
    platformsArray.add(new Platform(false));
  }

  for (int i = 0; i < platformsArray.size(); i++) {
    if (!platformsArray.get(i).broken) { // if it isnt already broken
      if (platformsArray.get(i).superPlatform == false) {      
        platformsArray.get(i).movePlatform();
      }
      platformsArray.get(i).drawPlatform();   
      if (player.checkVelocity() && platformsArray.get(i).checkBounce(player.getCenter(), player.getFeetPos())) {
        player.hitPlatform();
      }
    }
    if (platformsArray.get(i).getHeight() > height) {
      if (platformsArray.get(i).superPlatform == true) {
        platformCount--;
      };
      platformsArray.remove(i);
    };
  }
  if ( keyCode == ' ') {
    player.usePowerup();
  }


  player.drawCharacter();
  player.checkHeight();


  pushMatrix();
  if (flipped == true) {
    scale(1, -1);
    translate(0, -height);
  }

  quitButton.returnHover();
  image(backArrow, -15, height-100);
  popMatrix();

  if (totalHeight /150 > highScore) {
    highScore = (int) totalHeight / 150;
  }
  if (player.colourblind) {
    filter(GRAY);
  }
}

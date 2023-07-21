public void drawBackground() {
  background(0, 2, 3);
  if (backgroundYpos < 1000) { // draw the main background till its offscreen
    image(backgroundImage1, 0, backgroundYpos); 
  } 
  if (backgroundYpos > 0) { // if the other one is even slightly the screen draw thte stars
    image(star1Image, 0, star1YPos);
    image(star2Image, 0, star2YPos);
  }

  if (star1YPos >= 1000) {
    star1YPos = -1000 - (1000 - star1YPos);
  }
  if (star2YPos >= 1000) {
    star2YPos = -1000 - (1000 - star2YPos);
  }
}

public void moveBackground() {
  if (backgroundYpos < 3000) { // scrolls main background down while its still being drawn
    backgroundYpos -= player.getVelocity();
  }
  if (backgroundYpos >= 0) { // scrolls background down
    float decreaseAmmount = player.getVelocity();
    star1YPos -= decreaseAmmount;
    star2YPos -= decreaseAmmount;
  }
}

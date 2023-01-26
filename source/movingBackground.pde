public void drawBackground(){

 background(255, 255, 255);
  if (backgroundYpos < 1000) {
    image(backgroundImage1, 0, backgroundYpos);
  } 
  if (backgroundYpos > 0) {
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

public void moveBackground(){
      if (backgroundYpos < 3000) {
        backgroundYpos -= player.getVelocity();
      }
      if (backgroundYpos > 0) {
        float decreaseAmmount = player.getVelocity();
        star1YPos -= decreaseAmmount;
        star2YPos -= decreaseAmmount;
      }

}

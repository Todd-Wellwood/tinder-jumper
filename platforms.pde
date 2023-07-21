class Platform {
  float platformXPos;
  float platformYPos;
  int platformWidth;
  int platformHeight;
  boolean breakable;
  boolean broken;
  boolean superPlatform;
  boolean movingRight;
  int platformSize;
  int platformSpeed;

  Platform(boolean superPlatform) {
    this.broken = false; // all platforms start unbroken
    this.platformSpeed = (int) randomInt (2, MAXPLATFORMSPEED); // platform speed for chaos mode
    this.platformSize = (int) randomInt(0, 3); // size of platform
    if ((int) randomInt(0, 4) == 1 || player.fat) { // if players fat all platforms are breakable, else random change
      this.breakable = true;
    }

    switch(this.platformSize) {// sets the correct size and direction to start moving
      case(0):
      this.platformWidth = 85;
      this.movingRight = true;
      break;

      case(1):
      this.platformWidth = 105;
      this.movingRight = false;
      break;

      case(2):
      this.platformWidth = 125;
      this.movingRight = true;
      break;
    }    
    this.platformHeight = 20;
    this.platformXPos  = (float) randomInt(0, width - this.platformWidth); // random xpos within screen bounds


    this.platformYPos =  -1 - this.platformHeight; // drawn off screen 

    if (count < platformCount) {
      this.platformYPos = (height/5)*count-(this.platformHeight); // clever math to space out all the platforms
      count++;
    }
    if (superPlatform) { // if super platform
      this.platformWidth = width; // width of screen
      this.platformXPos  = 0 ;
      this.platformYPos =  (int) player.getFeetPos(); // spawn directly at players feet
      this.superPlatform = true;
      platformCount++; // incrememnt so that it doesnt break the spacing out of other platforms
      this.breakable = false; // super platforms are always unbreakable
    }
  }

  public void drawPlatform() {
    if (!this.broken) { // if it is not broken then draw it
      if (this.superPlatform) { // if super platform draw super platform
        image(platformSuper, this.platformXPos, this.platformYPos);
      } else if (!this.breakable) { // if not breakable 
        switch(this.platformSize) {    // draw at correct size
          case(0):
          image(platformSmall, this.platformXPos, this.platformYPos);
          break;

          case(1):
          image(platformMedium, this.platformXPos, this.platformYPos);
          break;

          case(2):
          image(platformLarge, this.platformXPos, this.platformYPos);
          break;
        }
      } else { // if breakable
        switch(this.platformSize) {    //draw breakable at correct size
          case(0):
          image(platformSmallBreakable, this.platformXPos, this.platformYPos);
          break;

          case(1):
          image(platformMediumBreakable, this.platformXPos, this.platformYPos);
          break;

          case(2):
          image(platformLargeBreakable, this.platformXPos, this.platformYPos);
          break;
        }
      }
    }
    //rect(this.platformXPos, this.platformYPos, this.platformWidth, this.platformHeight);
  }

  public void movePlatform() { // move platform left and right changing direction if it goes off the screen
    if (this.platformXPos <= 0) {
      this.movingRight = true;
    } else if (this.platformXPos + this.platformWidth >= width) {
      this.movingRight = false;
    }

    if (this.movingRight) {
      this.platformXPos += this.platformSpeed;
    } else {
      this.platformXPos -= this.platformSpeed;
    }
  }

  public void decreaseHeight() { // move platform further down the screen equal to the players velocity
    this.platformYPos -= player.getVelocity();
  }

  public float getHeight() {
    return this.platformYPos ; // get the platforms yPos
  }


  public boolean checkBounce(float characterXCenter, float characterYFeet) { // return true if the player bounced off it
    if (characterXCenter > this.platformXPos && characterXCenter < this.platformXPos + this.platformWidth && characterYFeet > this.platformYPos && characterYFeet < this.platformYPos + this.platformHeight) {
      if (this.breakable) { // if breakable
        this.broken = true; // set to broken
      }

      return true;
    }
    return false;
  }
}

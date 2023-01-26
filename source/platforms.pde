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
    this.broken = false;
    this.platformSpeed = (int) randomInt (2, MAXPLATFORMSPEED);
    this.platformSize = (int) randomInt(0, 3);
    if ((int) randomInt(0, 4) == 1 || player.fat) {
      this.breakable = true;
    }

    switch(this.platformSize) {    
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
    this.platformXPos  = (float) randomInt(0, width - this.platformWidth);


    this.platformYPos =  -1 - this.platformHeight;

    if (count < platformCount) {
      this.platformYPos = (height/5)*count-(this.platformHeight);
      count++;
    }
    if (superPlatform) {
      this.platformWidth = width;
      this.platformXPos  = 0 ;
      this.platformYPos =  (int) player.getFeetPos(); 
      this.superPlatform = true;
      platformCount++;
      this.breakable = false;
    }
  }

  public void drawPlatform() {
    if (!this.broken) {
      if (this.superPlatform) {
        image(platformSuper, this.platformXPos, this.platformYPos);
      } 
      else if (!this.breakable) { // if not breakable
        switch(this.platformSize) {    
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
      } 
      else { // if breakable
        switch(this.platformSize) {    
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
  
  public void movePlatform(){
    if(this.platformXPos <= 0){
      this.movingRight = true;
    }
    else if(this.platformXPos + this.platformWidth >= width){
      this.movingRight = false;
    }
    
    if(this.movingRight){
      this.platformXPos += this.platformSpeed;
    }
    else{
      this.platformXPos -= this.platformSpeed;
    }
    
  
  }

  public void decreaseHeight() {
    this.platformYPos -= player.getVelocity();
  }

  public float getHeight() {
    return this.platformYPos ;
  }


  public boolean checkBounce(float characterXCenter, float characterYFeet) {
    if (characterXCenter > this.platformXPos && characterXCenter < this.platformXPos + this.platformWidth && characterYFeet > this.platformYPos && characterYFeet < this.platformYPos + this.platformHeight) {
      if (this.breakable) {
        this.broken = true;
      }

      return true;
    }
    return false;
  }
}

class Character {
  String name;
  float xPos;
  float yPos;
  int powerup = 0;
  int trait1;
  int trait2 = 5;
  int characterWidth;
  int characterHeight;
  int colour;
  float velocity;
  boolean hat;
  boolean colourblind;
  boolean fat;


  Character() { // constructor
    alive = true;

    this.powerup = (int) randomInt(0, 3);
    this.trait1 = (int) randomInt(0, 5);
    while (trait1 == trait2 || trait2  == 5) {
      this.trait2 = (int) randomInt(0, 5);
    }
    this.name = makeRandomName();
    this.xPos = width/2;
    this.yPos = height-height/8;
    this.characterWidth = 50;
    this.characterHeight = 60;
    this.velocity = -13;
    this.colour = (int) randomInt(0, 5);
  }

  public void runTrait() {


    if (this.trait1 == 0 || this.trait2 == 0) {// hat
      this.hat = true;
    } 
    if (this.trait1 == 1 || this.trait2 == 1) { //Fly
      if ((second() == 12 || second() == 24 ||second() == 36 ||second() == 48 ||second() == 59) &&( totalHeight/150 > 7)) {
        fill(0, 0, 0);
        rect(0, 0, width, height/2-height/8);
        rect(0, height/2+height/8, width, height);
        noFill();
        blinkProtection = true;
      } else if ((second() == 0 || second() == 13 || second() == 25 || second() == 37 || second() == 49 ) && ( totalHeight/150 > 7 && blinkProtection)) { // fly fully coverted
        fill(0, 0, 0);
        rect(0, 0, width, height/2);
        rect(0, height/2, width, height);
        noFill();
      }
    } 
    if (this.trait1 == 2 || this.trait2 == 2) { //flipped
      flipped = true;
    }
    if (this.trait1 == 3 || this.trait2 == 3) {
      this.colourblind = true;
    }
    if (this.trait1 == 4 || this.trait2 == 4) { // fat
      this.fat = true;
    }
  }

  public int getColour() {  
    return this.colour;
  }

  public void displayPowerup() {
    if (this.powerup == 0) { // Jetpack
      image(jetpackImage, 0, 0);
    } else if (this.powerup == 1) { // Dash
      image(dashImage, 0, 0);
    } else if (this.powerup == 2) { // Platform Spawner
      image(spawnerImage, 0, 0);
    }
    noFill();
    stroke(255, 255, 255);
    strokeWeight(2);
    rect(0, 1, 100, 100);
  }

  public void checkHeight() {
    if (this.yPos <= height/2 -height/5) {
      /**IF ABOVE THE HEIGHT LIMIT**/
      this.yPos = height/2 -height/5;
      moveBackground();
      for (int i = 0; i < platformsArray.size(); i++) {
        platformsArray.get(i).decreaseHeight();
      }
    }
    if (this.yPos >= height) {
      alive = false;
    }
  }

  public void usePowerup() {
    if (this.powerup == 0) { // Jetpack
      this.powerup = -1;
      this.velocity = -30;
    }
    if (this.powerup == 1) { // Dash

      if (leftKey) {

        this.xPos -= 15;
      } else if (rightKey) {

        this.xPos += 15;
      }
    }
    if (this.powerup == 2) { // Platform Spawner
      this.powerup = -1;
      platformsArray.add(new Platform(true));
    }
  }

  public String powerUpName() {
    if (this.powerup == 0) { // Jetpack
      return "Jetpack";
    }
    if (this.powerup == 1) { // Rabbit Boots
      return "Dash";
    }
    if (this.powerup == 2) { // Platform Spawner
      return "Lifesaver";
    } else {
      return "ERROR";
    }
  }



  public void drawCharacterSheet() {
    textSize(47);
    fill(currentCharacterColour);
    text(this.name, 44, height/1.7);

    text("Special: "+this.powerUpName(), 32, height/1.7+120);
    text("Trait One:" +this.getTrait(this.trait1), 32, height/1.7+200);
    text("Trait Two:" +this.getTrait(this.trait2), 32, height/1.7+260);
    textSize(10);
  }

  public void drawCharacter() {
    fill(currentCharacterColour);
    textSize(20);
    text(this.name, this.xPos-(this.name.length()* 3), this.yPos -30);
    textSize(10);
    if (facingRight) {
      switch(player.getColour()) {   
        case(0):

        characterImage = loadImage("BlueSmallRight.png");
        break;

        case(1):

        characterImage = loadImage("RedSmallRight.png");
        break;

        case(2):
 
        characterImage = loadImage("PurpleSmallRight.png");
        break;

        case(3):
    
        characterImage = loadImage("GreenSmallRight.png");
        break;

        case(4):

        characterImage = loadImage("YellowSmallRight.png");
        break;
      }
    } else {
      switch(player.getColour()) {
        case(0):
        fill(0, 0, 255);
        characterImage = loadImage("BlueSmallLeft.png");
        break;

        case(1):
        fill(255, 0, 0);
        characterImage = loadImage("RedSmallLeft.png");
        break;

        case(2):
        fill(255, 0, 255);
        characterImage = loadImage("PurpleSmallLeft.png");
        break;

        case(3):
        fill(0, 255, 0);
        characterImage = loadImage("GreenSmallLeft.png");
        break;

        case(4):
        fill(255, 195, 11);
        characterImage = loadImage("YellowSmallLeft.png");
        break;
      }
    }


    image(characterImage, this.xPos, this.yPos);
    if (this.hat) {
      image(topHat, this.xPos, this.yPos-20);
    }
    player.moveCharacter();
    player.displayPowerup();
    player.runTrait();
  }

  public void moveCharacter() {
    totalHeight -= this.velocity;
    if (leftKey) { // left
      this.xPos -= 10;
      wrapAround();
    } else if (rightKey) { // right
      this.xPos += 10;
      wrapAround();
    }
    this.yPos += this.velocity;   
    this.velocity += 0.4;
    if (keyCode == 136) { // TESTING
      this.velocity = -100;
    }
  }

  public void wrapAround() {
    if (this.xPos + this.characterWidth < 0) {
      this.xPos = width;
    } else if (this.xPos > width) {
      this.xPos = 0;
    }
  }



  public float getCenter() {
    return this.xPos + (this.characterWidth/2);
  }

  public void hitPlatform() {
    this.velocity = -15;
  }

  public boolean checkVelocity() {
    if (this.velocity > 0) {
      return true;
    }
    return false;
  }

  public float getFeetPos() {
    return this.yPos+this.characterHeight;
  }

  public float getVelocity() {
    return this.velocity;
  }

  public String getTrait(int trait) {
    if (trait == 0) { // TopHat
      return " Cool hat";
    }
    if (trait == 1) { // Fly in the eye
      return " Fly in eye";
    }
    if (trait == 2) { 
      return " Flipped!";
    } 
    if (trait == 3) {
      return " ColourBlind";
    }
    if (trait == 4) {
      return " Fat ";
    } else {
      return "ERROR";
    }
  }

  public String makeRandomName() {
    String name1 = names1[(int) randomInt( 0, names1.length)];
    String name2 = names2[(int) randomInt(0, names2.length)];
    return name = name1+" "+name2;
  }

  private String[] names1 =
    {"Duke", "Rambo", "Sir", "Raven", "King", "Lord", "Captain", "Mr", 
    "Dagger", "Boris", "Ace", "Rocket", "Buster", "Jax", "Diesel", "Neo", "Bob", "Charlie", "Emilia", "Jasmine", 
    "Rachel", "Elliott", "Maggie", "JagBir", "Tim", "Amazir", "Nadya", "Todd"

  };

  private String[] names2 =
    {"Blazington", "Devil-Slayer", "the Second", "Angel", "Destroyer", "Rose", "Hammer", "Roberts", "Minaj", "Bomb", "The Stallion", "for President", "Queen", "the wise", "the slow"
  };
}

class Character {
  String name;
  float xPos;
  float yPos;
  int powerup = 0;
  int trait1;
  int trait2;
  int characterWidth;
  int characterHeight;
  int colour;
  float velocity;
  boolean hat;
  boolean colourblind;
  boolean fat;
  boolean techSavy;


  Character() { // constructor
    alive = true;
    flipped = false;
    this.techSavy = false;
    this.powerup = (int) randomInt(0, 3);
    this.trait1 = (int) randomInt(0, 6); // uses random number generator I wrote
    this.trait2 = -1;
    while (this.trait1 == trait2 || this.trait2  == -1) { // so that the two traits are not the same
      this.trait2 = (int) randomInt(0, 6);
    }
    this.name = makeRandomName(); // runs random name function
    this.xPos = width/2;
    this.yPos = height-height/8;
    this.characterWidth = 50;
    this.characterHeight = 60;
    this.velocity = -13;
    this.colour = (int) randomInt(0, 5);
    this.runTrait(); // run traits once so the starting platforms will be drawn broken if the player is fat
  }

  public void runTrait() {
    if (this.trait1 == 0 || this.trait2 == 0) {// hat
      this.hat = true;
    } 
    if (this.trait1 == 1 || this.trait2 == 1) { //Fly
      if ((second() == 12 || second() == 24 ||second() == 36 ||second() == 48 ||second() == 59) &&( totalHeight/150 > 7)) { // on one of these seconds and only if higher than 7 meteres
        fill(0, 0, 0);
        rect(0, 0, width, height/2-height/8);
        rect(0, height/2+height/8, width, height);
        noFill();
        blinkProtection = true;//enables the full blink to appear
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
    if (this.trait1 == 3 || this.trait2 == 3) { // sets colourblind mode to true
      this.colourblind = true;
    }
    if (this.trait1 == 4 || this.trait2 == 4) { // fat
      this.fat = true;
    }
    if (this.trait1 == 5 || this.trait2 == 5) { // techSavy
      this.techSavy = true;
    }
  }

  public int getColour() {  // returns characters colpour
    return this.colour;
  }

  public void displayPowerup() { // draws powerup
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
    rect(0, 1, 100, 100); // border of the powerup box
  }

  public void checkHeight() {
    if (this.yPos <= height/2 -height/5) {
      /**IF ABOVE THE HEIGHT LIMIT**/
      this.yPos = height/2 -height/5;
      moveBackground(); // move background down
      for (int i = 0; i < platformsArray.size(); i++) { // decrease all the platforms shown on the screen
        platformsArray.get(i).decreaseHeight();
      }
    }
    if (this.yPos >= height) { // if fallen off the bottom player is dead
      rightHeldOnDeath = rightKey;
    
      alive = false;
    }
  }

  public void usePowerup() {
    if (this.powerup == 0) { // Jetpack
      this.powerup = -1;
      this.velocity = -30; // give 30 units of upwards velocity
    }
    if (this.powerup == 1) { // Dash
      if (leftKey) {
        this.xPos -= 15; // dash to the left
      } else if (rightKey) {
        //dash to the right
        this.xPos += 15;
      }
    }
    if (this.powerup == 2) { // Platform Spawner
      this.powerup = -1; // remove powerup
      platformsArray.add(new Platform(true)); // generate a super platform at the players feet
    }
  }

  public String powerUpName() {
    if (this.powerup == 0) { // Jetpack
      return "Jetpack";
    }
    if (this.powerup == 1) { //Dash 
      return "Dash";
    }
    if (this.powerup == 2) { // Platform Spawner
      return "Lifesaver";
    } else {
      return "ERROR";
    }
  }

  public void drawCharacterSheet() {// draws the characters profile
    textSize(47);
    fill(currentCharacterColour); // text colour
    text(this.name, 44, height/1.7); //character name

    text("Special: "+this.powerUpName(), 32, height/1.7+120); // powerup
    
    
    //traits
    text("Trait One:" +this.getTrait(this.trait1), 32, height/1.7+200);
    text("Trait Two:" +this.getTrait(this.trait2), 32, height/1.7+260);
    textSize(10); // reset for next screen
  }

  public void drawCharacter() {
    fill(currentCharacterColour); 
    textSize(20);
    text(this.name, this.xPos-(this.name.length()* 3), this.yPos -30); //draw name above the character
    textSize(10);
    if (facingRight) { // draw right facing
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
    } else { // draw left facing
      switch(player.getColour()) { // draw its colour
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


    image(characterImage, this.xPos, this.yPos); // draw the actual image
    if (this.hat) {
      image(topHat, this.xPos, this.yPos-20); // if they have a hat draw with a tophat
    }
    //move display and activate the traits
    player.moveCharacter();
    player.displayPowerup();
    player.runTrait();
  }

  public void moveCharacter() {
    totalHeight -= this.velocity; // apply velocity to their character
    if (leftKey) { // left
      this.xPos -= 10;
      wrapAround(); // wraparound the screen
    } else if (rightKey) { // right
      this.xPos += 10;
      wrapAround();
    }
    this.yPos += this.velocity;   
    this.velocity += 0.4;
    if (keyCode == 136) { // numpad 8 for hacks
      this.velocity = -100;
    }
  }

  public void wrapAround() { 
    if (this.xPos + this.characterWidth < 0) { // if off left side
      this.xPos = width; // teleport to the right
    } else if (this.xPos > width) { // otherwise must of been called on right side so teleport to the left
      this.xPos = 0;
    }
  }


  public void hitPlatform() { // if bounced off
    this.velocity = -15; // give upwards velocity
  }

  public boolean checkVelocity() { // returns true if velocity is positive
    if (this.velocity > 0) {
      return true;
    }
    return false;
  }

//returns:
  public float getFeetPos() {
    return this.yPos+this.characterHeight;
  }

  public float getVelocity() {
    return this.velocity;
  }
  public float getCenter() { // center of character
    return this.xPos + (this.characterWidth/2);
  }

  public String getTrait(int trait) { // returns name of the trait (Int - String conversion  (Probably could have used a switch here))
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
    }
    if (trait == 5) {
      return " Tech Savy";
    } 
    else {
      return "ERROR";
    }
  }
  
  //generates a random name

  public String makeRandomName() {
    String name1 = names1[(int) randomInt( 0, names1.length)];
    String name2 = names2[(int) randomInt(0, names2.length)];
    return name = name1+" "+name2;
  }

  private String[] names1 =
    {"Duke", "Rambo", "Sir", "Raven", "King", "Lord", "Captain", "Mr", 
    "Dagger", "Boris", "Ace", "Rocket", "Buster", "Jax", "Diesel", "Neo", "Bob", "Charlie", "Emilia", "Jasmine", 
    "Rachel", "Elliott", "Maggie", "JagBir", "Tim", "Amazir", "Nadya", "Todd","Kevin","Harrison"

  };

  private String[] names2 =
    {"Blazington", "Devil-Slayer", "the Second", "Angel", "Destroyer", "Rose", "Hammer", "Roberts", "Minaj", "Bomb", "The Stallion", "for President", "Queen", "the wise", "the slow"
  };
}

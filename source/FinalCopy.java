import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class FinalCopy extends PApplet {

/***LEVEL_INDEX***/
int level = -1;

/***IMAGES***/
PImage jetpackImage;
PImage homescreen;
PImage backArrow;
PImage backgroundImage1; 
PImage star1Image;
PImage star2Image;
PImage characterSelectionImage;
PImage characterImage;
PImage spawnerImage;
PImage dashImage;
PImage platformSmall;
PImage platformMedium;
PImage platformLarge;
PImage platformSuper;
PImage platformSmallBreakable;
PImage platformMediumBreakable;
PImage platformLargeBreakable;
PImage portal;
PImage topHat;
PImage tutorialScreen;
/***KEYS***/
boolean rightKey = false;
boolean leftKey = false;
boolean spamPrevention = true;



/***BUTTONS***/
Button normalModeButton;
Button chaosModeButton;
Button quitButton;
Button tutorialModeButton;

boolean overButton = false;
boolean chaosMode;
boolean chaosModeUnlocked = false;

/***CHARACTER***/
Character player;
boolean alive = true;
boolean facingRight = true;
int currentCharacterColour;

/***PLATFORMS***/
ArrayList <Platform> platformsArray = new ArrayList <Platform>();
int count = 1;
int platformCount = 5;
int portalYPos = - 300;
final int MAXPLATFORMSPEED = 7;

/***GUI****/
float totalHeight = 0;
boolean blinkProtection = false;
float backgroundYpos = -2000;
float star1YPos = -1000;
float star2YPos = -2000;
boolean flipped = false;
int highScore;

/***LEVEL_INDEX***
 Menu = -1;
 Tutorial = 0;
 Character Creater = 1;
 Normal = 2;
 Chaos = 3;
 ****************/



/********************************/
/**          SETUP             **/
/********************************/


public void setup() {
  highScore = 0;
  chaosModeUnlocked = false;
  
  PFont myFont = loadFont("LinuxLibertineGI-48.vlw");
  textFont(myFont, 48);

  homescreen = loadImage("homescreen.png");
  backArrow = loadImage("backArrow.png");

  tutorialScreen = loadImage("tutorialhomescreen.png");
  backgroundImage1 = loadImage("background.png");
  backgroundImage1.resize(510, 3000);
  star1Image = loadImage("star1.png");
  star2Image = loadImage("star2.png");


  jetpackImage = loadImage("jetpack.png");
  spawnerImage = loadImage("switch.png");
  dashImage = loadImage("dash.png");

  platformSmall = loadImage ("platform8520.png");
  platformMedium = loadImage ("platform10520.png");
  platformLarge = loadImage ("platform12520.png");
  platformSuper = loadImage ("platform50020.png");

  platformSmallBreakable = loadImage ("platformcracked85.png");
  platformMediumBreakable = loadImage ("platformcracked105.png");
  platformLargeBreakable = loadImage ("platformcracked125.png");

  tutorialModeButton = new  Button(width/4, height- 680, width/2, height /10, color(255, 255, 255));
  normalModeButton   = new  Button(width/4, height - 550, width/2, height /10, color(255, 255, 255));
  chaosModeButton    = new  Button(width/4, height-415, width/2, height /10, color(255, 255, 255));

  portal = loadImage("portal.png");

  topHat = loadImage("tophat.png");

  quitButton         = new  Button(0, height-height /10, width/5, height /10, color(0, 0, 0));
}

/********************************/
/**           DRAW             **/
/********************************/


public void draw() {
  if (alive == false) {
    player = new Character();
    resetVariables(false);
    level = 1;
  }


  switch(level) { // Switch takes an int, then runs a differnt "case" depending on the value
  case -1: // case start
    drawMenu();
    break; // case end
  case 0: 
    displayTutorial();
    break;
  case 1:
    characterSelect();
    break;
  case 2:
    runNormalGame();
    break;
  case 3:
    runChaosGame();
    break;
  }
}


/********************************/
/**       SOFT RESET           **/
/********************************/


public void resetVariables(boolean resetLevel) {
  platformsArray = new ArrayList <Platform>();
  blinkProtection = false;
  totalHeight = 0;
  count = 1;
  portalYPos = - 300;
  platformCount = 5;
  backgroundYpos = -2000;
  star1YPos = -1000;
  star2YPos = -2000;
  flipped = false;
  if (resetLevel) {
    level = -1;
  }
}



/********************************/
/**   RANDOM NUMBER GEN        **/
/********************************/

public double randomInt(double min, double max) {
  min = Math.ceil(min);
  max = Math.floor(max);
  return Math.floor(Math.random() * (max - min) + min); //The maximum is exclusive and the minimum is inclusive
}


/********************************/
/**      KEYS PRESSED          **/
/********************************/

public void keyReleased() {
  if (keyCode == RIGHT) {
    rightKey = false;
  }                  
  if (keyCode == LEFT) {
    leftKey  = false; 
    spamPrevention = true;
  }
}

public void keyPressed() {
  if (keyCode == RIGHT) {
    facingRight = true;
    rightKey = true;
  }
  if (keyCode == LEFT) {
    leftKey  = true;
    facingRight = false;
  }
}



/********************************/
/**     MOUSE INTERACTION      **/
/********************************/
public void mousePressed() {
  if (quitButton.returnHover()) {
    resetVariables(true);
  }
  if (level == -1) {
    if (normalModeButton.returnHover()) {
      player = new Character();
      level = 1;
      chaosMode = false;
    }
    if (chaosModeButton.returnHover() ) {
      if ( chaosModeUnlocked) {
        player = new Character();
        level = 1;
        chaosMode = true;
      }
    }
    if (tutorialModeButton.returnHover()) {
      level = 0;
    }
  }
}
class Button {
  float buttonWidth ;   
  float buttonHeight;
  float buttonX ;
  float buttonY ;
  boolean mouseOverButton;
  
  int currentButtonColor;
  int buttonDefaultColor;
  int buttonHighlight;

  Button(float xPos, float yPos, float buttonWidth, float buttonHeight,int buttonDefaultColor) { // constructor
    this.buttonX = xPos;
    this.buttonY = yPos;
    this.buttonWidth  = buttonWidth;
    this.buttonHeight = buttonHeight;
    this.currentButtonColor = buttonDefaultColor;
    this.buttonDefaultColor = buttonDefaultColor;
  }

  public void drawButton() {
    noFill();
    stroke(this.currentButtonColor);
    rect(this.buttonX, this.buttonY, this.buttonWidth, this.buttonHeight,7); // 7 for curvey

    this.returnHover();
  }

  public boolean returnHover() {
    if (mouseX >= this.buttonX && mouseX <= this.buttonX + this.buttonWidth && mouseY >= this.buttonY && mouseY <= this.buttonY + this.buttonHeight) {
      this.currentButtonColor = buttonHighlight;
      return true;
    } 
    else {
      this.currentButtonColor = this.buttonDefaultColor;
      return false;
    }
  }
}
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
    text(this.name, 44, height/1.7f);

    text("Special: "+this.powerUpName(), 32, height/1.7f+120);
    text("Trait One:" +this.getTrait(this.trait1), 32, height/1.7f+200);
    text("Trait Two:" +this.getTrait(this.trait2), 32, height/1.7f+260);
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
    this.velocity += 0.4f;
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
public void characterSelect() {
  background(255, 255, 255);


  switch(player.getColour()) {   
    case(0):
    currentCharacterColour = color(0, 0, 255);
    characterSelectionImage = loadImage("BlueBackgroundFinal.png");
    break;

    case(1):
    currentCharacterColour = color(255, 0, 0);
    characterSelectionImage = loadImage("RedBackgroundFinal.png");
    break;

    case(2):
    currentCharacterColour = color(255,0,255);
    characterSelectionImage = loadImage("PurpleBackgroundFinal.png");
    break;
    
    case(3):
    currentCharacterColour = color(0,255,0);
    characterSelectionImage = loadImage("GreenBackgroundFinal.png");
    break;
    
    case(4):
    currentCharacterColour = color(255, 195, 11);
    characterSelectionImage = loadImage("YellowBackgroundFinal.png");
    break;
  }


  image(characterSelectionImage, 0, 0);


  player.drawCharacterSheet();
  if (rightKey) {
    if (!chaosMode) {
      level = 2;
    } else {
      level = 3;
    }
  }
  if (leftKey && spamPrevention) {
    player = new Character();     
    spamPrevention = false;
  }

  quitButton.returnHover();
  image(backArrow, -15, height-100);
}
public void drawMenu() {
  image(homescreen, 0, 0);    
  strokeWeight(2);
  normalModeButton.drawButton();
  chaosModeButton.drawButton();
  tutorialModeButton.drawButton();
     if (!chaosModeUnlocked) {
        stroke(255,0,0);
        strokeWeight(12);
        line(width/4, height-415, (width/4) + (width/2), (height-415) + (height /10)); // showing chaos mode not unlocked
        line(width/4,(height-415) + (height /10), (width/4) + (width/2), height-415); // showing chaos mode not unlocked
     } 
  strokeWeight(5);
  fill(255,0,255);
  textSize(35);
  text("CHAOS MODE HIGHSCORE: " + highScore,20,height-50); // purple border
  text("(METERS)",width/3,height-20); // ("METERES")
  strokeWeight(1);
  fill(255,255,255);
  text("CHAOS MODE HIGHSCORE: " + highScore,20,height-50); // inside text
  text("(METERS)",width/3,height-20); // ("METERES")
  
  
}
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




public void runNormalGame() {
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

  if (Math.ceil(totalHeight/150) >= 50) {
    image(portal, width/2-150, portalYPos);
    portalYPos++;
    if (dist(player.xPos + (player.characterWidth/2), player.yPos, width/2, portalYPos+150) < 100) {
      player.xPos = width/2;
      player.yPos = portalYPos + 150;
      player.drawCharacter();
      chaosModeUnlocked = true;
      delay(500);
      player = new Character();
      resetVariables(false);
      level = -1;
    }
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
  if(player.colourblind){
      filter(GRAY);
  }
}
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
public void displayTutorial() {
  image(tutorialScreen, 0, 0);

  fill(255, 0, 255);
  textSize(35);
  text("How To Play:\nMove: Left and Right Arrow Keys\nPowerup: Spacebar\nEach Character Has Traits!\nFat - Platforms Insta Break\nColourblind - GrayScale\nFly in Eye - Randomly Blink!\nHat - Cool Hat\nFlipped! - Game runs upside down\n\n\nTo Unlock Chaos Mode\nReach 50 Meters!",20,270); // purple fill
  strokeWeight(1);
  fill(255, 192, 203);
  text("How To Play:\nMove: Left and Right Arrow Keys\nPowerup: Spacebar\nEach Character Has Traits!\nFat - Platforms Insta Break\nColourblind - GrayScale\nFly in Eye - Randomly Blink!\nHat - Cool Hat\nFlipped! - Game runs upside down\n\n\nTo Unlock Chaos Mode\nReach 50 Meters!",20,270); // purple fill












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
  public void settings() {  size(500, 1000, P2D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "FinalCopy" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}

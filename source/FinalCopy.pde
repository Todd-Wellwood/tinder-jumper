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
color currentCharacterColour;

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
  size(500, 1000, P2D);
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

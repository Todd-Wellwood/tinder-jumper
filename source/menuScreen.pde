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

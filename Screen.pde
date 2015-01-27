class Screen
{
 char up;
  char down;
  char left;
  char right;
  char start;
  char button1;
  char button2;
  
  float halfHeight = height / 2;
  float halfWidth = width / 2;
  
  Screen(char up, char down, char left, char right, char start, char button1, char button2)
  {
    this.up = up;
    this.down = down;
    this.left = left;
    this.right = right;
    this.start = start;
    this.button1 = button1;
    this.button2 = button2;
  }
  
  Screen(XML xml)
  {
    this( buttonNameToKey(xml, "up")
        , buttonNameToKey(xml, "down")
        , buttonNameToKey(xml, "left")
        , buttonNameToKey(xml, "right")
        , buttonNameToKey(xml, "start")
        , buttonNameToKey(xml, "button1")
        , buttonNameToKey(xml, "button2")
        );
  }
  
  void splash()
  {
    textAlign(CENTER, CENTER);
    imageMode(CENTER);
    
    textSize(60*x_spd_mod);
    fill(255);
    text("CURIOUSITY",halfWidth,halfHeight-cellSize*6);
    
    textSize(30*x_spd_mod);
    fill(0,255,0);
    text("PRESS START",halfWidth,halfHeight-cellSize*2);
    
    image(controls,halfWidth,halfHeight+cellSize*6,(777/3)*x_spd_mod,(536/3)*y_spd_mod);
    imageMode(CORNER);
    
    if(checkKey(start))
    {
      gameState=3;
    }
  }
  
  void scoreBoard()
  {
    
  }
  
  void gameOver()
  {
    background(0);
    textAlign(CENTER, CENTER);
    
    textSize(70*x_spd_mod);
    fill(255,0,0);
    text("GAME OVER.",halfWidth,halfHeight-cellSize*4);
    
    textSize(50*x_spd_mod);
    fill(255);
    text("Time: "+(int)stopTime/1000+" secs",halfWidth,halfHeight+cellSize*3);
    text("Distance: "+(int)distanceCovered/cellSize+" m",halfWidth,halfHeight+cellSize*6);
    
    if(checkKey(start))
    {
      players.clear();
      setup();
      gameState=1;
    }
  }
  
  void highScore()
  {
    background(0);
    textAlign(CENTER, CENTER);
    
    textSize(70*x_spd_mod);
    fill(0,255,0);
    text("HIGH SCORE!",halfWidth,halfHeight-cellSize*4);
    
    textSize(50*x_spd_mod);
    fill(255);
    text("Time: "+(int)stopTime/1000+" secs",halfWidth,halfHeight+cellSize*3);
    text("Distance: "+(int)distanceCovered/cellSize+" m",halfWidth,halfHeight+cellSize*6);
  }
}

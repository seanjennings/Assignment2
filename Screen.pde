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
    createStars();
    createObstacles();
    
    textAlign(CENTER, CENTER);
    imageMode(CENTER);
    
    textSize(60*x_spd_mod);
    fill(255);
    text("CURIOUSITY",halfWidth,halfHeight-cellSize*6);
    
    textSize(30*x_spd_mod);
    fill(0,255,0);
    text("PRESS Q TO START",halfWidth,halfHeight-cellSize*3);
    textSize(20*x_spd_mod);
    fill(255,215,0);
    text("PRESS E FOR SCOREBOARD",halfWidth,halfHeight-cellSize);
    
    textSize(15*x_spd_mod);
    fill(255,0,0);
    text("AVOID ASTEROIDS",halfWidth,halfHeight+cellSize*2);
    fill(255);
    text("COLLECT STARS",halfWidth,halfHeight+cellSize*3);
    
    
    image(controls,halfWidth,halfHeight+cellSize*8,(777/3)*x_spd_mod,(536/3)*y_spd_mod);
    imageMode(CORNER);
    
    if(checkKey(start))
    {
      obstacles.clear();
      stars.clear();
      setUpPlayerControllers();
      startTime = millis();
      gameState=3;
    }
    if(checkKey(button1))
    {
      obstacles.clear();
      stars.clear();
      gameState=2;
    }
  }
  
  void scoreBoard()
  {
    background(0);
    createStars();
    createObstacles();
    
    int display[] = new int[5];
    
    display = scoreboard.getScores();
    
    textAlign(CENTER, CENTER);
    
    textSize(20*x_spd_mod);
    fill(0,255,0);
    text("PRESS R TO RETURN",halfWidth, cellSize);
    
    textSize(100*x_spd_mod);
    fill(255);
    text("TOP SCORES",halfWidth, cellSize*4);
    
    for (int i=0;i<5;i++)
    {
      fill(255,215-30*i,0);
      textSize((70-5*i)*x_spd_mod);
      text(""+display[i],halfWidth,cellSize*8+cellSize*3*i);
    }
    
    if(checkKey(button2))
    {
      obstacles.clear();
      stars.clear();
      gameState=1;
    }
  }
  
  void gameOver()
  {
    players.clear();
    blocks.clear();
    
    background(0);
    createStars();
    createObstacles();
    textAlign(CENTER, CENTER);
    
    textSize(70*x_spd_mod);
    fill(255,0,0);
    text("GAME OVER.",halfWidth,halfHeight-cellSize*4);
    textSize(30*x_spd_mod);
    text("PRESS Q TO RESTART",halfWidth,halfHeight-cellSize);
    
    textSize(50*x_spd_mod);
    fill(255);
    text("Time: "+(int)stopTime/1000+" secs",halfWidth,halfHeight+cellSize*3);
    text("Distance: "+(int)distanceCovered/cellSize+" m",halfWidth,halfHeight+cellSize*6);
    
    if(checkKey(start))
    {
      players.clear();
      obstacles.clear();
      stars.clear();
      setup();
      gameState=1;
    }
  }
  
  void highScore()
  {
    players.clear();
    blocks.clear();
    
    background(0);
    createStars();
    createObstacles();
    textAlign(CENTER, CENTER);
    
    textSize(70*x_spd_mod);
    fill(0,255,0);
    text("HIGH SCORE!",halfWidth,halfHeight-cellSize*4);
    textSize(30*x_spd_mod);
    text("PRESS Q TO RESTART",halfWidth,halfHeight-cellSize);
    
    textSize(50*x_spd_mod);
    fill(255);
    text("Time: "+(int)stopTime/1000+" secs",halfWidth,halfHeight+cellSize*3);
    text("Distance: "+(int)distanceCovered/cellSize+" m",halfWidth,halfHeight+cellSize*6);
    
    if(checkKey(start))
    {
      obstacles.clear();
      stars.clear();
      setup();
      gameState=1;
    }
  }
}

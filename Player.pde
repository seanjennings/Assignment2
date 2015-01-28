class Player
{
  char up;
  char down;
  char left;
  char right;
  char start;
  char button1;
  char button2;
  
  float x;
  float xSpeed;
  
  float y;
  float ySpeed;
  boolean dead;
  
  Player(float xpos, char up, char down, char left, char right, char start, char button1, char button2)
  {
    x = xpos;
    this.up = up;
    this.down = down;
    this.left = left;
    this.right = right;
    this.start = start;
    this.button1 = button1;
    this.button2 = button2;
    y = 0;
    dead = false;
  }
  
  Player(float xpos, XML xml)
  {
    this(xpos
        , buttonNameToKey(xml, "up")
        , buttonNameToKey(xml, "down")
        , buttonNameToKey(xml, "left")
        , buttonNameToKey(xml, "right")
        , buttonNameToKey(xml, "start")
        , buttonNameToKey(xml, "button1")
        , buttonNameToKey(xml, "button2")
        );
  }
  
  void update()
  {
    if (checkKey(right) && !checkKey(left))
    {
      if (players.get(0).dead == false)
      {
        players.get(0).forward();    
      }
    }
    if(checkKey(up))
    {
      if(ySpeed == 0)
      {
        jump.rewind();
        jump.play();
      }
      players.get(0).jump();
    }
    
    if (players.get(0).dead == false)
    {
      now = millis() - startTime;
      print((int)now/1000+"\n");
    } 
    
    stepSize = players.get(0).doplayer();
    distanceCovered += stepSize;
  }
  
  void forward()
  {
    if (dead) return;
    xSpeed += 0.2;
    if (xSpeed > 4.2) xSpeed = 4.2;
    return;
  }
  
  void jump()
  {
    if (dead) return;
    if (y == board.findFloor(x,playerSize))
    {
      ySpeed = -8;
    }
  }
  
  float doplayer()
  {
    float startx=x;
    float thefloor = board.findFloor(x,playerSize);
    
    //Gravity  
    if (y < thefloor) ySpeed += .2;
    
    //Horizontal resistence
    if (xSpeed*xScalar > 0)
    {
      xSpeed -= .1;
      if (xSpeed < 0) xSpeed = 0;
    }
    
    y += ySpeed*yScalar;
    
    if (y > thefloor)
    {
      if (ySpeed > 0) ySpeed = 0;
      y=thefloor;
    }
    
    //Test for wall
    if (xSpeed*xScalar > 0)
    {
      if (y > board.findFloor(int(x+xSpeed*xScalar),playerSize))
      {
        xSpeed = 0;
      }
    }
    
    //Check Player life status
    if (dead == false)
    {
      if (y >= height || health <= 0)
      {
        dead = true;
      }
    }
    else
    {
      xSpeed = 0;
      ySpeed = -12;
      stopTime = millis();
      //High Score Achieved
      //Add High Score to table
      if(scoreboard.checkTop((int)distanceCovered/cellSize))
      {
        scoreboard.tableAdd((int)distanceCovered/cellSize);
        gameState = 5;//Set game mode to high score screen
      }
      //No High Score
      else
      {
        gameState=4;//Set game mode to game over screen
      }
    }
    
    return xSpeed*xScalar;
  }
  
  //Player Drawing
  void drawplayer()
  {
    buffer.image(rover,x,y-playerSize,playerSize,playerSize);
    pl.x = x;
    pl.y = y-playerSize;
  }
  
}

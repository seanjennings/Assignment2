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
  float x_speed;
  
  float y;
  float y_speed;
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
      sound();
      if(y_speed == 0)
      {
        jump.rewind();
        jump.play();
      }
      players.get(0).jump();
    }
    stepSize = players.get(0).doplayer();
    distanceCovered += stepSize;
  }
  
  void forward()
  {
    if (dead) return;
    x_speed += 0.2;
    if (x_speed > 4.2) x_speed = 4.2;
    return;
  }
  
  void jump()
  {
    if (dead) return;
    if (y == board.find_floor(x,cellSize))
    {
      y_speed = -8;
    }
  }
  
  float doplayer()
  {
    float startx=x;
    float thefloor = board.find_floor(x,cellSize);
    
    //see if we need to do some gravity  
    if (y < thefloor) y_speed += .2;
    
    //slow down due to friction and air resistance
    if (x_speed*x_spd_mod > 0) {
      x_speed -= .1; //0.05 (it's like ice)
      if (x_speed < 0) x_speed = 0;
    }
    
    //x += x_speed*x_spd_mod;
    y += y_speed*height/600;
    
    if (y > thefloor) {
      //println(&quot;Below the floor!&quot;);
      if (y_speed > 0) y_speed = 0;
      y=thefloor;
    }
    
    //Make sure we're not going to run into a wall
    if (x_speed*x_spd_mod > 0) {
      if (y > board.find_floor(int(x+x_speed*x_spd_mod),cellSize)) {
        //key_forward = false;
        x_speed = 0;
      }
    }
    //println(y);
    if (dead == false) {
      if (y >= height) {
        dead = true;
        x_speed = 0;
        y_speed = -12;
        stopTime = millis();
      }
    }
    
    //y = min(thefloor,y);
    //println(&quot;doplayer, x_speed*x_spd_mod: &quot; + x_speed*x_spd_mod);
    return x_speed*x_spd_mod;
  }
  
  void sound()
  {
    
  }
  
  void drawplayer()
  {
    buffer.stroke(240,0,0);
    buffer.fill(240,0,0);
    buffer.rect(x,y-cellSize,cellSize,cellSize);
    pl.x = x;
    pl.y = y-cellSize;
  }
  
}

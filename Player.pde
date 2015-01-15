class Player
{
  PVector pos;
  char up;
  char down;
  char left;
  char right;
  char start;
  char button1;
  char button2;
  int index;
  color colour;
  float xSpeed,ySpeed;
  float accel,deccel;
  float maxXspd,maxYspd;
  float xSave,ySave;
  int xRep,yRep;
  float gravity;
    
  Player()
  {
    pos = new PVector(width / 2, height / 2);
    xSpeed = 0;
    ySpeed = 0;
    accel = 0.5;
    deccel = 0.5;
    maxXspd = 2;
    maxYspd = 14;
    xSave = 0;
    ySave = 0;
    xRep = 0;
    yRep = 0;
    gravity = 0.15;
  }
  
  Player(int index, color colour, char up, char down, char left, char right, char start, char button1, char button2)
  {
    this();
    this.index = index;
    this.colour = colour;
    this.up = up;
    this.down = down;
    this.left = left;
    this.right = right;
    this.start = start;
    this.button1 = button1;
    this.button2 = button2;
  }
  
  Player(int index, color colour, XML xml)
  {
    this(index
        , colour
        , buttonNameToKey(xml, "up")
        , buttonNameToKey(xml, "down")
        , buttonNameToKey(xml, "left")
        , buttonNameToKey(xml, "right")
        , buttonNameToKey(xml, "start")
        , buttonNameToKey(xml, "button1")
        , buttonNameToKey(xml, "button2")
        );
  }
  
  void update() {
    if ( checkKey(right) ) {
      xSpeed += accel;
      if ( xSpeed > maxXspd ) {
        xSpeed = maxXspd;
      }
    }
    else if ( checkKey(left) ) {
      xSpeed -= accel;
      if ( xSpeed < -maxXspd ) {
        xSpeed = -maxXspd;
      }
    }
    else { //neither right or left pressed, decelerate
      if ( xSpeed > 0 ) {
        xSpeed -= deccel;
        if ( xSpeed < 0 ) {
          xSpeed = 0;
        }
      }
      else if ( xSpeed < 0 ) {
        xSpeed += deccel;
        if ( xSpeed > 0 ) {
          xSpeed = 0;
        }
      }
    }
    
    if ( checkKey(up) ) {
      if ( !place_free(int(pos.x),int(pos.y+16)) || !place_free(int(pos.x+15),int(pos.y+16)) ) {
        ySpeed = -5.3;
        jump.trigger();
      }
    }
    
    ySpeed += gravity;
    
    /*
    // The technique used for movement involves taking the integer (without the decimal)
    // part of the player's xSpeed and ySpeed for the number of pixels to try to move,
    // respectively.  The decimal part is accumulated in xSave and ySave so that once
    // they reach a value of 1, the player should try to move 1 more pixel.  This jump
    // is not normally visible if it is moving fast enough.  This method is used because
    // is guarantees that movement is pixel perfect because the player's position will
    // always be at a whole number.  Whole number positions prevents problems when adding
    // new elements like jump through blocks or slopes.
    */
    xRep = 0; //should be zero because the for loops count it down but just as a safety
    yRep = 0;
    xRep += floor(abs(xSpeed));
    yRep += floor(abs(ySpeed));
    xSave += abs(xSpeed)-floor(abs(xSpeed));
    ySave += abs(ySpeed)-floor(abs(ySpeed));
    int signX = (xSpeed<0) ? -1 : 1;
    int signY = (ySpeed<0) ? -1 : 1;
    //when the player is moving a direction collision is tested for only in that direction
    //the offset variables are used for this in the for loops below
    int offsetX = (xSpeed<0) ? 0 : 15;
    int offsetY = (ySpeed<0) ? 0 : 15;
    
    if ( xSave >= 1 ) {
      xSave -= 1;
      xRep++;
    }
    if ( ySave >= 1 ) {
      ySave -= 1;
      yRep++;
    }
    
    for ( ; yRep > 0; yRep-- ) {
      if ( place_free(int(pos.x),int(pos.y+offsetY+signY)) && place_free(int(pos.x+15),int(pos.y+offsetY+signY)) ) {
        pos.y += signY;
      }
      else {
        ySpeed = 0;
      }
    }
    for ( ; xRep > 0; xRep-- ) {
      if ( place_free(int(pos.x+offsetX+signX),int(pos.y)) && place_free( int(pos.x+offsetX+signX),int(pos.y+15) ) ) {
        pos.x += signX;
      }
      else {
        xSpeed = 0;
      }
    }
    
    if(pos.x >= height-16)
    {
      setUpLevel();
      pos.x = 0;
      pos.y = 224;
    }
    
  }
  
  void display()
  {    
    stroke(colour);
    fill(colour);    
    rect(pos.x, pos.y, 15, 15);
  }  
}

class Screen
{
 char up;
  char down;
  char left;
  char right;
  char start;
  char button1;
  char button2;
  
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
    text("PRESS START.",0,cellSize);
    if(checkKey(up))
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
    text("GAME OVER.",0,cellSize);
    text("Time: "+(int)stopTime/1000+"secs",0,cellSize*2);
    text("Distance:"+(int)distanceCovered/cellSize+"m",0,cellSize*3);
  }
  
  void highScore()
  {
    
  }
}

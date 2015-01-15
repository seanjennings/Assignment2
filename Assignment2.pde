/*
    DIT OOP Assignment 2 Starter Code
    =================================
    
    Loads player properties from an xml file
    See: https://github.com/skooter500/DT228-OOP 
*/

ArrayList<Player> players = new ArrayList<Player>();
boolean[] keys = new boolean[526];
final int WIDTH = 30;
final int HEIGHT = 30;
int[][] level = new int[HEIGHT][WIDTH];

import ddf.minim.*;
Minim minim = new Minim(this);
AudioSample jump;

void setup()
{
  size(16*HEIGHT, 16*WIDTH);
  
  jump = minim.loadSample("jump.wav");
  
  setUpPlayerControllers();
  setUpLevel();setUpLevel();
}

void draw()
{
  background(0);
  
  for(Player player:players)
  {
    player.update();
    player.display();
  }
  
  drawLevel();
}

void keyPressed()
{
  keys[keyCode] = true;
}

void keyReleased()
{
  keys[keyCode] = false;
}

boolean checkKey(char theKey)
{
  return keys[Character.toUpperCase(theKey)];
}

char buttonNameToKey(XML xml, String buttonName)
{
  String value =  xml.getChild(buttonName).getContent();
  if ("LEFT".equalsIgnoreCase(value))
  {
    return LEFT;
  }
  if ("RIGHT".equalsIgnoreCase(value))
  {
    return RIGHT;
  }
  if ("UP".equalsIgnoreCase(value))
  {
    return UP;
  }
  if ("DOWN".equalsIgnoreCase(value))
  {
    return DOWN;
  }
  //.. Others to follow
  return value.charAt(0);  
}

void setUpPlayerControllers()
{
  XML xml = loadXML("arcade.xml");
  XML[] children = xml.getChildren("player");
  int gap = width / (children.length/* + 1*/);
  
  for(int i = 0 ; i < children.length ; i ++)  
  {
    XML playerXML = children[i];
    Player p = new Player(i, color(random(0, 255), random(0, 255), random(0, 255)), playerXML);
    //int x = (i + 1) * gap;
    p.pos.x = 0;
    p.pos.y = 224;
    players.add(p);         
  }
}

void setUpLevel()
{
  boolean col;
  int rand;
  int previous=15;
  
  for ( int ix = 0; ix < WIDTH; ix++ ) {
    for ( int iy = 0 ; iy < HEIGHT; iy++ ) {
      level[iy][ix]=0;
    }
  }
  
  for ( int ix = 0; ix < WIDTH; ix++ ) {
    col=false;
    rand=int(previous + random(0,10));
    for ( int iy = 0 ; iy < HEIGHT; iy++ ) {
      if(iy == rand)
      {
        col=!col;
      }
      if(col)
      {
        level[iy][ix] ^= 1;
      }
    }
    for ( int iy = 0 ; iy < HEIGHT-15; iy++ ) {
      int obs=int(random(0,15));
      if(level[iy][ix] != 1 && obs == 0)
      {
        level[iy][ix] ^= 2;
      }
    }
  }
}

void drawLevel() {
  //fill(150);
  noStroke();
  for ( int ix = 0; ix < WIDTH; ix++ ) {
    for ( int iy = 0; iy < HEIGHT; iy++ ) {
      switch(level[iy][ix]) {
        case 1: fill(int(random(100,150)));
                rect(ix*16,iy*16,16,16); //ellipse(ix*16+8,iy*16+8,16,16);
                break;
        case 2: fill(255,0,0);
                rect(ix*16,iy*16,16,16); //ellipse(ix*16+8,iy*16+8,16,16);
      }
    }
  }
}

boolean place_free(int xx, int yy){
//checks if a given point (xx,yy) is free (no block at that point) or not
  yy = int(floor(yy/16.0));
  xx = int(floor(xx/16.0));
  if ( xx > -1 && xx < level[0].length && yy > -1 && yy < level.length ) {
    if ( level[yy][xx] == 0) {
      return true;
    }
  }
  return false;
}

void mousePressed() {
//Left click creates/destroys a block
  if ( mouseButton == LEFT ) {
    level[int(floor(mouseY/16.0))][int(floor(mouseX/16.0))] ^= 1;
  }
}

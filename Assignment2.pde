/*
    DIT OOP Assignment 2 Starter Code
    =================================
    
    Loads player properties from an xml file
    See: https://github.com/skooter500/DT228-OOP 
*/

ArrayList<Player> players = new ArrayList<Player>();
ArrayList<Star> stars = new ArrayList<Star>();
ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>();
ArrayList<Surface> surfaces = new ArrayList<Surface>();
boolean[] keys = new boolean[526];
final int WIDTH = 30;
final int HEIGHT = 30;
int[][] level = new int[HEIGHT][WIDTH];
float life;

import ddf.minim.*;
Minim minim = new Minim(this);
AudioSample jump;

void setup()
{
  size(16*HEIGHT, 16*WIDTH);
  life = 100.0f;
  
  jump = minim.loadSample("jump.wav");
  
  setUpPlayerControllers();
  setUpLevel();
}

void draw()
{
  background(0);
  
  for(Surface surface:surfaces) {
    surface.update();
    surface.display();
  }
  
  for(Player player:players) {
    player.update();
    player.display();
  }
  
  for(Star star:stars) {
   star.display();
  }
  
  for(Obstacle obstacle:obstacles) {
   obstacle.display();
  }
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
  if ("LEFT".equalsIgnoreCase(value)) {
    return LEFT;
  }
  if ("RIGHT".equalsIgnoreCase(value)) {
    return RIGHT;
  }
  if ("UP".equalsIgnoreCase(value)) {
    return UP;
  }
  if ("DOWN".equalsIgnoreCase(value)) {
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
  
  for(int i = 0 ; i < children.length ; i ++) {
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
  
  //Clear previous stage
  for ( int ix = 0; ix < WIDTH; ix++ ) {
    for ( int iy = 0 ; iy < HEIGHT; iy++ ) {
      level[iy][ix]=0;
    }
  }
  surfaces.clear();
  stars.clear();
  obstacles.clear();
  
  /* Set stage variables and create objects */
  
  //Planet Surface Setup
  for ( int ix = 0; ix < WIDTH; ix++ ) {
    col=false;
    rand=int(previous + random(0,10));
    for ( int iy = 0 ; iy < HEIGHT; iy++ ) {
      if(iy == rand) {
        col=!col;
      }
      
      if(col) {
        level[iy][ix] ^= 1;
        PVector pos = new PVector();
        color colour;
        pos.x = iy;
        pos.y = ix;
        colour = color(80,0,0);
        Surface s = new Surface(pos, colour);
        surfaces.add(s);
      }
    }
    
    //Star Setup
    for ( int iy = 0 ; iy < HEIGHT-15; iy++ ) {
      int obs=int(random(0,15));
      
      if(level[iy][ix] == 0 && obs == 0) {
        level[iy][ix] ^= 2;
        PVector pos = new PVector();
        color colour;
        pos.x = iy;
        pos.y = ix;
        //colour = color(80,0,0);
        colour = int(random(200,255));
        Star s = new Star(pos, colour);
        stars.add(s);
      }
    }
    
    //Obstacle Setup
    for ( int iy = 0 ; iy < HEIGHT-15; iy++ ) {
      int obs=int(random(0,15));
      if(level[iy][ix] == 0 && obs == 0) {
        level[iy][ix] ^= 3;
        PVector pos = new PVector();
        color colour;
        pos.x = iy;
        pos.y = ix;
        //colour = int(random(200,255));
        colour = color(80,0,0);
        Obstacle o = new Obstacle(pos, colour);
        obstacles.add(o);
      }
    }
  }
}

//Collision Detection
boolean place_free(int xx, int yy){
//checks if a given point (xx,yy) is free (no block at that point) or not
  yy = int(floor(yy/16.0));
  xx = int(floor(xx/16.0));
  if ( xx > -1 && xx < level[0].length && yy > -1 && yy < level.length ) {
    /*switch(level[yy][xx]) {
      case 1:  return false;
      case 2:  life += 0.1f;
               return false;
      case 3:  return false;
    }*/
    if ( level[yy][xx] == 0) {
      return true;
    }
  }
  
  //Block Interaction Operations depending on block type
  switch(level[yy][xx]) {
    case 1:  break;
    case 2:  life += 0.1f;
             break;
    case 3:  break;
  }
  
  return false;
}

void displayData()
{
  fill(0,255,0);
  text(life, 10, 30);
}

//Debugging Level Editor
void mousePressed() {
//Left click creates/destroys a block
  if ( mouseButton == LEFT ) {
    level[int(floor(mouseY/16.0))][int(floor(mouseX/16.0))] ^= 1;
  }
}

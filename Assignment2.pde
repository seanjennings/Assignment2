int offset;
float stepSize;
float position;
PFont font;

float floorY;
float playerX;
PVector pl = new PVector();

VisibleBoard board;
Screen screen;
ArrayList<Player> players = new ArrayList<Player>();
ArrayList<Block> blocks = new ArrayList<Block>();
ArrayList<Star> stars = new ArrayList<Star>();
ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>();

boolean[] keys = new boolean[526];
PGraphics buffer;
PImage img;

float startTime;
float stopTime;
float now;
float distanceCovered;
int health;
int cellSize;
int x_spd_mod;
int y_spd_mod;

int gameState;

import ddf.minim.*;
Minim minim = new Minim(this);
AudioSnippet jump;
AudioSnippet hit;
AudioSnippet healthup;


void setup()
{
  //size(1280,1024);
  size(600,400);
  cellSize = (int)width/30;
  x_spd_mod = width/600;
  y_spd_mod = height/400;

  stroke(255);
  background(0);
  setUpPlayerControllers();
  
  jump = minim.loadSnippet("jump.wav");
  hit = minim.loadSnippet("hit.wav");
  healthup = minim.loadSnippet("healthup.wav");
  
  board = new VisibleBoard();  
  offset = 0;
  font = createFont("verdana",14);
  textFont(font);
  
  buffer = createGraphics(width, height);
  startTime = millis();
  
  setUpScreen();
  health=100;
  gameState=1;
  frameRate(60);
}

void draw()
{
  /*
  //Block Object Counter
  print("s: "+stars.size()+"\n");
  print("o: "+obstacles.size()+"\n");
  print("p: "+players.size()+"\n");
  print("b: "+blocks.size()+"\n");*/
  switch(gameState)
  {
    //Splash
    case 1:
    screen.splash();
      break;
    //Scoreboard
    case 2:
      break;
    //Running
    case 3:
      runGame();
      break;
    //Game Over
    case 4:
      break;
    //High Score
    case 5:
      break;
  }
  
}

void runGame()
{
  players.get(0).update();
  board.drawBoard();
  
  createStars();
  createObstacles();
  
  for(Star s:stars)
  {
    s.update();
    s.display();
  }
  for(Obstacle o:obstacles)
  {
    o.update();
    o.display();
  }
  
  displayData();
}

void displayData()
{
  fill(255);
  text("Time: "+(int)now/1000+"secs",cellSize,cellSize);
  text("Distance: "+(int)distanceCovered/cellSize+"m",cellSize,50);
  fill(0,255,0);
  text("Health: "+health+"%",cellSize,80);
}

void createStars()
{
  if((int)random(0,520) == 0)
  {
    PVector p=new PVector();
    p.x=(int)random(width*.33,width-cellSize);
    p.y=0-cellSize;
    color c = color(255);
    stars.add(new Star(p,c));
  }
  
  for(int i=0;i<stars.size();i++)
  {
    if(stars.get(i).collision() || stars.get(i).pos.y > height)
    {
      stars.remove(i);
    }
  }
}

void createObstacles()
{
  if((int)random(0,120) == 0)
  {
    PVector p=new PVector();
    p.x=(int)random(width*.33,width-cellSize);
    p.y=0-cellSize;
    color c = color(80,0,0);
    obstacles.add(new Obstacle(p,c));
  }
  
  for(int i=0;i<obstacles.size();i++)
  {
    if(obstacles.get(i).collision() || obstacles.get(i).pos.y > height)
    {
      obstacles.remove(i);
    }
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
  
  for(int i = 0 ; i < children.length ; i ++) {
    XML playerXML = children[i];
    players.add(new Player(width*.33, playerXML));
    playerX = width*.33;        
  }
}

void setUpScreen()
{
  XML xml = loadXML("arcade.xml");
  XML[] children = xml.getChildren("player");
  
  for(int i = 0 ; i < children.length ; i ++) {
    XML playerXML = children[i];
    screen = new Screen(playerXML);        
  }
}

//Objects & Array lists
VisibleBoard board;
Screen screen;
Score scoreboard;
ArrayList<Player> players = new ArrayList<Player>();
ArrayList<Block> blocks = new ArrayList<Block>();
ArrayList<Star> stars = new ArrayList<Star>();
ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>();

boolean[] keys = new boolean[526];

//Graphics
PGraphics buffer;
PImage img, rover, controls;
PFont mars;

//Audio
import ddf.minim.*;
Minim minim = new Minim(this);
AudioSnippet jump;
AudioSnippet hit;
AudioSnippet healthup;

int offset;
float stepSize;
float position;
float floorY;
float startTime;
float stopTime;
float now;
float distanceCovered;
int health;
int cellSize;
int playerSize;
int xScalar;
int yScalar;
int obstacleChance;
int gameState;
PVector pl = new PVector();

void setup()
{
  //Screen Sizes
  //size(1280,1024);
  size(800,600);
  
  //Scaling variables setup
  cellSize = (int)width/30;
  playerSize = cellSize*4;
  xScalar = width/600;
  yScalar = height/400;
  
  //Font setup
  mars = createFont("marspolice_i.ttf",20);
  textFont(mars);
  
  board = new VisibleBoard();
  scoreboard = new Score();  
  
  //Audio Loading
  jump = minim.loadSnippet("jump.wav");
  hit = minim.loadSnippet("hit.wav");
  healthup = minim.loadSnippet("healthup.wav");
  //Image Loading
  buffer = createGraphics(width, height);
  rover = loadImage("rover.png");
  controls = loadImage("controls.png");
  
  //Initialisation
  offset = 0;
  setUpScreen();
  obstacleChance = 120;
  distanceCovered=0;
  health=100;
  gameState=1;
  
  background(0);
  frameRate(60);
}

void draw()
{
  /*
  //Bug Testing
  //Block Object Counter
  print("s: "+stars.size()+"\n");
  print("o: "+obstacles.size()+"\n");
  print("p: "+players.size()+"\n");
  print("b: "+blocks.size()+"\n");
  */
  
  /* Switch Statement for game states */
  switch(gameState)
  {
    //Splash
    case 1:
      board.drawBoard();
      screen.splash();
      break;
      
    //Scoreboard
    case 2:
      screen.scoreBoard();
      break;
      
    //Running
    case 3:
      runGame();
      break;
      
    //Game Over
    case 4:
      screen.gameOver();
      break;
      
    //High Score
    case 5:
      screen.highScore();
      break;
  }
  
}

void runGame()
{
  players.get(0).update();
  
  board.drawBoard();
  
  if((int)now/1000 > 2)
  {
    createStars();
    createObstacles();
  }

  displayData();
}

void displayData()
{
  //Styling
  textAlign(LEFT);
  textSize(20); 
  fill(255);
  
  //Display
  text("Time: "+(int)now/1000+" secs",cellSize,cellSize);
  text("Distance: "+(int)distanceCovered/cellSize+" m",cellSize,cellSize*2);
  
  //Slide Health colour from green to red
  color colour;
  float red;
  float green;
  if(health > 50)
  {
    red = (1.0f-(float(health)/100.0f)) * 255.0f * 2.0f;
    colour = color(red,255,0);
    //print("RED: "+red);
  }
  else
  {
    green = ((float(health)/100.0f)) * 255.0f * 2.0f;
    colour = color(255,green,0);
    //print("GREEN: "+green);
  }
  
  fill(colour);
  text("Health: "+health,cellSize,cellSize*3);
}

void createStars()
{
  //Random Star Generator
  if((int)random(0,520) == 0)
  {
    PVector p=new PVector();
    p.x=(int)random(0,width-cellSize);
    p.y=0-cellSize;
    color c = color(255);
    stars.add(new Star(p,c));
  }
  
  //Despawning management
  for(int i=0;i<stars.size();i++)
  {
    float thefloor = board.findFloor(stars.get(i).pos.x,cellSize);
    if(stars.get(i).collision() || stars.get(i).pos.y > thefloor || stars.get(i).pos.y > height)
    {
      stars.remove(i);
    }
  }
  
  //Object Functions
  for(Star s:stars)
  {
    s.update();
    s.display();
  }
}

void createObstacles()
{
  int time = (int)now/1000;
  
  //Increase obstacle spawn rate by narrowing rand choices - based on time blocks
  if(time%10 == 0 && obstacleChance > 20 && players.size() > 0)
  {
    obstacleChance--;
  }
  
  //Random Star Generator
  if((int)random(0,obstacleChance) == 0)
  {
    PVector p=new PVector();
    p.x=(int)random(0,width);
    p.y=0-cellSize;
    color c = color(80,0,0);
    obstacles.add(new Obstacle(p,c));
  }
  
  //Despawning management
  for(int i=0;i<obstacles.size();i++)
  {
    float thefloor = board.findFloor(obstacles.get(i).pos.x,cellSize);
    if(obstacles.get(i).collision() || obstacles.get(i).pos.y > thefloor || obstacles.get(i).pos.y > height)
    {
      obstacles.remove(i);
    }
  }
  
  //Object Functions
  for(Obstacle o:obstacles)
  {
    o.update();
    o.display();
  }
}

/* Control Setup */
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
    players.add(new Player(width*.33, playerXML));       
  }
}

void setUpScreen()
{
  XML xml = loadXML("arcade.xml");
  XML[] children = xml.getChildren("player");
  
  for(int i = 0 ; i < children.length ; i ++)
  {
    XML playerXML = children[i];
    screen = new Screen(playerXML);        
  }
}

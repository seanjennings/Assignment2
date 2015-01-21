int offset;
float stepSize;
float position;
PFont font;

float floorY;
float playerX;

VisibleBoard board;
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


void setup()
{
  size(600,400);

  stroke(255);
  background(0);
  setUpPlayerControllers();
  
  board = new VisibleBoard();  
  offset = 0;
  font = createFont("verdana",14);
  textFont(font);
  
  buffer = createGraphics(width, height);
  startTime = millis();
  //frameRate(30);
}

void draw()
{
  //Block Object Counter
  //print(stars.size()+"\n");
  
  players.get(0).update();
  board.drawBoard();
  
  if((int)random(0,520) == 0)
  {
    PVector p=new PVector();
    p.x=(int)random(width*.33,width-20);
    p.y=0-20;
    color c = color(255);
    stars.add(new Star(p,c));
  }
  
  if((int)random(0,120) == 0)
  {
    PVector p=new PVector();
    p.x=(int)random(width*.33,width-20);
    p.y=0-20;
    color c = color(80,0,0);
    obstacles.add(new Obstacle(p,c));
  }
  
  for(int i=0;i<obstacles.size();i++)
  {
    obstacles.get(i).update();
    obstacles.get(i).display();
    if(obstacles.get(i).collision())
    {
      obstacles.remove(i);
    }
  }
  for(Star s:stars)
  {
    s.update();
    s.display();
  }
  
  displayData();
}

void displayData()
{
  text("Time: "+(int)now/1000+"secs",20,20);
  text("Distance: "+(int)distanceCovered/20+"m",20,50);
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

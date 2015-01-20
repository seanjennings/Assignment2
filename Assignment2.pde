VisibleBoard board;
int offset;
int cycles_running;
float step_size;
float position;
PFont font;

boolean key_forward;
boolean key_back;
float floor_y;
float player_x;
ArrayList<Player> players = new ArrayList<Player>();
boolean[] keys = new boolean[526];
PGraphics buffer;
PImage img;
float running_time;
float start_time;
float stop_time;
float now;
float distance_covered;

void setup() {
  size(600,400);

  stroke(255);
  background(0);
  setUpPlayerControllers();
  
  board = new VisibleBoard();  
  offset = 0;
  font = createFont("verdana",14);
  textFont(font);
  
  buffer = createGraphics(width, height);
  start_time = millis();
  //frameRate(30);
}/*
void keyPressed() {
  if (keyCode==RIGHT) {
    key_forward = true;
    //println("RIGHT");
  } else if (keyCode == UP) {
    key_back = true;
  } else if (key == ' ') {
    players.get(0).jump();
  }
}
void keyReleased() {
  if (keyCode==RIGHT) {
    key_forward = false;
    step_size = 0;
    cycles_running = 0;
  } else if (keyCode == LEFT) {
    key_back = false;
  }
}*/

void draw() {
  print(blocks.size()+"\n");
  players.get(0).update();
  
  step_size = players.get(0).doplayer();
  distance_covered += step_size;
  
  offset = int(offset - step_size);
    
  if (offset <= -1 * board.widthoflastblock()) {
    offset = offset + board.stepforward();
  }
  buffer.beginDraw();
  buffer.background(0);
  board.displayboard(position,offset+100);
  players.get(0).drawplayer();
  if (players.get(0).dead == false) {
    now = millis() - start_time;
  } else if (millis() - stop_time > 3000) {
    start_time = millis();
    distance_covered = 0;
    players.clear();
    setUpPlayerControllers();
  }
  buffer.text("Time: "+(int)now/1000+"secs",20,20);
  buffer.text("Distance: "+(int)distance_covered/20+"m",20,50);
  
  buffer.endDraw();
  
  img = buffer.get(0, 0, buffer.width, buffer.height);
  image(img, 0, 0);
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
    players.add(new Player(width*.33, playerXML));
    player_x = width*.33;        
  }
}

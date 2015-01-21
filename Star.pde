class Star
{
  PVector pos;
  color colour;
  
  Star(PVector pos, color colour)
  {
    this.pos=pos;
    this.colour=colour;
  }
  
  void update()
  {
    pos.x -= players.get(0).x_speed;
    pos.y++;
  }
  
  void display()
  {
    noStroke();
    fill(colour);
    rect(pos.x,pos.y,cellSize,cellSize);
  }
}

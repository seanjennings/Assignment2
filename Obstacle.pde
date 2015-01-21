class Obstacle
{
  PVector pos;
  color colour;
  
  Obstacle(PVector pos, color colour)
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
  
  boolean collision()
  {
    if((pl.x > pos.x && pl.x < pos.x+cellSize  &&  pl.y+cellSize > pos.y && pl.y+cellSize < pos.y+cellSize) || (pl.x > pos.x && pl.x < pos.x+cellSize  &&  pl.y > pos.y && pl.y < pos.y+cellSize) || (pl.x+cellSize > pos.x && pl.x+cellSize < pos.x+cellSize  &&  pl.y > pos.y && pl.y+cellSize < pos.y+cellSize) || (pl.x+cellSize > pos.x && pl.x+cellSize < pos.x+cellSize  &&  pl.y+cellSize > pos.y && pl.y+cellSize < pos.y+cellSize))
    {
        print("hit\n");
        health-=(int)random(4,10);
        return true;
    }
    return false;
  }
}

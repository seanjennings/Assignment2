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

    pos.y+=1*(y_spd_mod);
  }
  
  void display()
  {
    noStroke();
    fill(colour);
    rect(pos.x,pos.y,cellSize,cellSize);
  }
  
  boolean collision()
  {
    // Its easier to check if they DONT colide
    if (pl.x + cellSize < pos.x)
    {
      return false;
    }
    if (pl.x > pos.x + cellSize)
    {
      return false;
    } 
    
    if (pl.y > pos.y + cellSize)
    {
      return false;
    }
    
    if (pl.y + cellSize < pos.y)
    {
      return false;
    }
    // If none of the above then there is a collision
    health-=(int)random(0,20);
    return true;
  }
}

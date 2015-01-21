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
    rect(pos.x,pos.y,20,20);
  }
  
  boolean collision()
  {
    if((pl.x > pos.x && pl.x < pos.x+20  &&  pl.y+20 > pos.y && pl.y+20 < pos.y+20) || (pl.x > pos.x && pl.x < pos.x+20  &&  pl.y > pos.y && pl.y < pos.y+20) || (pl.x+20 > pos.x && pl.x+20 < pos.x+20  &&  pl.y > pos.y && pl.y+20 < pos.y+20) || (pl.x+20 > pos.x && pl.x+20 < pos.x+20  &&  pl.y+20 > pos.y && pl.y+20 < pos.y+20))
    {
        print("hit\n");
        return true;
    }
    return false;
  }
}

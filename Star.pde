class Star extends FallingObject
{
  int points=(int)random(5,10);
  float radius=random(15,20)*xScalar;
  
  Star(PVector pos, color colour)
  {
    this.pos=pos;
    this.colour=colour;
    this.theta=0;
  }
  
  void update()
  {
    //Modify by minus the players speed, if they exist
     if(players.size() > 0)
     {
       pos.x -= players.get(0).xSpeed;
     }
    
    //Speed application and rotation angle increase
    pos.y+=3*(yScalar);
    theta+=0.01f;
  }
  
  void display()
  {
    stroke(colour);
    
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(theta);
    
    float px, py;
    float lastx = 0, lasty = -radius;
    float theta1 = 0;
    float thetaInc = TWO_PI / (points * 2);
    
    //Loop for star vertices
    for(int i = 0 ; i < (points * 2) ; i ++)
    {
      theta1 += thetaInc;
      if (i % 2 == 1)
      {
        px = sin(theta1) * radius;
        py = -cos(theta1) * radius;
      }
      else
      {
        px = sin(theta1) * (radius * 0.5f);
        py = -cos(theta1) * (radius * 0.5f);
      }
      line(lastx, lasty, px, py);
      lastx = px;
      lasty = py;
      
    }
    
    popMatrix();
  }
  
  boolean collision()
  {
    // Its easier to check if they DONT colide
    if (pl.x + playerSize < pos.x)
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
    
    if (pl.y + playerSize < pos.y)
    {
      return false;
    }
    // If none of the above then there is a collision
    if(players.size() > 0)
    {
      if(health<100)
      {
        health+=points;
      }
      sound();
      return true;
    }
    return false; //Screen backdrop case with no players spawned
  }
  
  void sound()
  {
    healthup.rewind();
    healthup.play();
  }
}

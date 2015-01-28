class Obstacle extends FallingObject
{
  float[] vertX = new float[16];
  float[] vertY = new float[16];
  
  Obstacle(PVector pos, color colour)
  {
    this.pos=pos;
    this.colour=colour;
    
    for (int i = 0; i < 16; i++)
    {
      // Radial vertices
      // Each vertice is PI/8 radians rotated from the previous one and generated with a new random distance from the center
      vertX[i] = sin(i*PI/8)*(cellSize + random(-cellSize/4, cellSize/4));
      vertY[i] = cos(i*PI/8)*(cellSize + random(-cellSize/4, cellSize/4));
    }
  }
  
  void update()
  {
    //Modify by minus the players speed, if they exist
    if(players.size() > 0)
    {
      pos.x -= players.get(0).xSpeed;
    }
    
    //Speed application
    pos.y+=1.5*(yScalar);
  }
  
  void display()
  {
    noStroke();
    fill(colour);
    
    translate(pos.x, pos.y);
    
    //Draw obstacle polygon using the randomly genertaed vertices
    beginShape();
    for (int i = 0; i < 16; i++)
    {
      vertex(vertX[i], vertY[i]);
    }
    vertex(vertX[0], vertY[0]);
    endShape();
    
    translate(-pos.x, -pos.y);
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
      health-=(int)random(0,20);
      sound();
      return true;
    }
    return false; //Screen backdrop case with no players spawned
  }
  
  void sound()
  {
    hit.rewind();
    hit.play();
  }
}

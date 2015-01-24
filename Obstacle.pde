class Obstacle
{
  PVector pos;
  color colour;
  float[] vertx = new float[16];
  float[] verty = new float[16];
  
  Obstacle(PVector pos, color colour)
  {
    this.pos=pos;
    this.colour=colour;
    
    for (int i = 0; i < 16; i++) {
      // The vertices are generated radially
      // A vertice is generated at an angle of 0 with a random distance from the center of the asteroid
      // Then the next vertice is PI/8 radians rotated from the previous one and generated with a new random distance from the center
      vertx[i] = sin(i*PI/8)*(cellSize + random(-cellSize/4, cellSize/4));
      verty[i] = cos(i*PI/8)*(cellSize + random(-cellSize/4, cellSize/4));
    }
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
    
    translate(pos.x, pos.y);
    
    beginShape();
    for (int i = 0; i < 16; i++) {
      vertex(vertx[i], verty[i]);
    }
    vertex(vertx[0], verty[0]);
    endShape();
    
    translate(-pos.x, -pos.y);
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
    sound();
    return true;
  }
  
  void sound()
  {
    hit.rewind();
    hit.play();
  }
}

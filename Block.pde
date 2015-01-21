class Block 
{
  int h;
  int w;
  int top_y;
  int block_x;
  int[] blocks;
  int last_x;
  color colour;
  
  Block(int h, int w)
  {
    this.h = h;
    this.w = w;
    blocks = new int[cellSize];
    
    for (int i=0;i<cellSize;i++)
    {
      if (i<=h) 
      {
        blocks[i] = 1;
      } 
      else 
      {
        blocks[i] = 0;
      }
    }
    
    colour = color((int)random(75,85),0,0);
    top_y = int(height-(height*h)/cellSize);
  }
  
  int displayblock(int x)
  {  
    int i;
    block_x = x;
    
    for (i=19;i>=0;i--)
    {
      if (blocks[i] == 1)
      {
        int y = int(height-(height*i)/cellSize);
        int blockheight = int(height/cellSize);
        
        buffer.stroke(colour);
        buffer.fill(colour);
        buffer.rect(x,y,w,blockheight);
      }
    }
    
    if ((x+w > playerX) && (x < playerX + cellSize))
    {
      floorY = top_y;
    }
    
    return x+w;
  }
}

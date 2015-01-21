class Block 
{
  int h;
  int w;
  int top_y;
  int block_x;
  int[] blocks;
  int last_x;
  
  Block(int h, int w)
  {
    this.h = h;
    this.w = w;
    blocks = new int[20];
    
    for (int i=0;i<20;i++)
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
    
    top_y = int(height-(height*h)/20);
  }
  
  int displayblock(int x)
  {  
    int i;
    block_x = x;
    
    for (i=19;i>=0;i--)
    {
      if (blocks[i] == 1)
      {
        int y = int(height-(height*i)/20);
        int blockheight = int(height/20);
        
        buffer.stroke(128,0,0);
        buffer.fill(128,0,0);
        buffer.rect(x,y,w,blockheight);
      }
    }
    
    if ((x+w > playerX) && (x < playerX + 20))
    {
      floorY = top_y;
    }
    
    return x+w;
  }
}

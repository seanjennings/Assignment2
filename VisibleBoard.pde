class VisibleBoard
{
  VisibleBoard()
  {
    int blockheight = 8;
    
    for (int i=0;i<50;i++)
    {
      blocks.add(new Block(blockheight,cellSize));
      
      if (random(1) < .10)
      {
        if (random(1) < .5)
        {
          if (blockheight > 0) 
          {
            blockheight--;
          }
        } 
        else if (blockheight < 15) blockheight++;
      }
    }
  }
  
  int stepforward()
  {
    //Block Cleanup
    for(int i=0;i<blocks.size();i++)
    {
      if(blocks.get(i).blockX < 0-(blocks.get(i).w)*4)
      {
        blocks.remove(i);
      }
    }
    
    int blockheight;
    blockheight = ((Block)blocks.get(blocks.size()-1)).h;
    
    if (random(1) < .5)
    {
      if (random(1) < .5) 
      {
        if (blockheight > 1) blockheight--;
      } 
      else 
      {
        if (blockheight < 15) blockheight++;
      }
      
      blocks.add(new Block(blockheight,cellSize));
      blocks.remove(0); 
      return ((Block)blocks.get(blocks.size()-1)).w;
    }
    
    //Gaps in Course, 6 - 12 cells wide
    else if (random(1) < .1) 
    {
      int i;
      for(i=0;i<(int)random(6,12);i++)
      {
        blocks.add(new Block(0,cellSize));
      }
      blocks.add(new Block(blockheight,cellSize));
      blocks.remove(0);
      return (cellSize*i)+cellSize;
    }
    else 
    {
      blocks.add(new Block(blockheight,cellSize));
      blocks.remove(0);
      return ((Block)blocks.get(blocks.size()-1)).w;
    }
  }
  
  void displayboard(float position,int offset)
  {
    Block block;
    int x=width+offset;
    
    for (int i=(blocks.size()-1);i>1;i--)
    {
      block = (Block)blocks.get(i);
      block.displayblock(x);
      block = (Block)blocks.get(i-1);
      x = x-block.w;
    }
  }
  
  int widthoflastblock()
  {
    return ((Block)blocks.get(0)).w;
  }
  
  float findFloor(float x1, float w)
  {  
    //Find the highest point
    //between x and x+w (base of player)
    x1 -= 100;
    float x2 = x1+w;
    float theFloor = height*2;
    
    Block block;
    int x=width+offset;
    
    for (int i=(blocks.size()-1);i>1;i--)
    {
      block = (Block)blocks.get(i);
      
      if (((x >= x1-block.w) && (x <= x2)))
      {
        if (block.topY < theFloor)
        {
          theFloor = block.topY;
        }
      }
      x = x-block.w;
    }
    return theFloor; //return curret floor, relative to the player
  }
  
  void drawBoard()
  {
    offset = int(offset - stepSize);
    
    if (offset <= -1 * board.widthoflastblock())
    {
      offset = offset + board.stepforward();
    }
    
    buffer.beginDraw();
    
    buffer.background(0);
    board.displayboard(position,offset+100);
    
    if(players.size() > 0)
    {
      players.get(0).drawplayer();
    }
    
    buffer.endDraw();
    
    img = buffer.get(0, 0, buffer.width, buffer.height);
    image(img, 0, 0);
  }
}


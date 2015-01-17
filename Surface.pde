class Surface{
  PVector pos;
  color colour;
  
  Surface(PVector pos, color colour){
    this.pos=pos;
    this.colour=colour;
  }
  
  void display(){
    noStroke();
    fill(colour);
    rect(pos.y*16,pos.x*16,16,16);
  }
  
  void update(){
    colour = color(int(random(128,188)),0,0);
  }
}

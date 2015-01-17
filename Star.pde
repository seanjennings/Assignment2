class Star{
  PVector pos;
  color colour;
  
  Star(PVector pos, color colour){
    this.pos=pos;
    this.colour=colour;
  }
  
  void display(){
    fill(colour);
    stroke(colour);
    rect(pos.y*16,pos.x*16,16,16);
  }
}

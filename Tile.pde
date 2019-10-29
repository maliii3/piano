class Tile {

  int x,y, w, h, clr;
  
  Tile(int _x,int _y,int _width,int _height,int _color) {

    
    this.x = _x;
    this.y = _y;
    this.w = _width;
    this.h = _height;
    this.clr = _color;

  }


  void show(boolean cond) {

    strokeWeight(1);

    if (!cond)
      fill(this.clr);
    else
      fill(color(66, 206, 244));

    rect(this.x, this.y, this.w, this.h);
  }


}

class DrawnShape {

  String shapeType;

  
  PVector shapeStartPoint, shapeEndPoint;

  public boolean isSelected = false;
  
  PImage theImage;
  
  public DrawnShape(String shapeType, PImage image) {
    this.shapeType  = shapeType;
    theImage = image;
  }

  
  public void startMouseDrawing(PVector startPoint) {
    this.shapeStartPoint = startPoint;
    this.shapeEndPoint = startPoint;
  }



  public void duringMouseDrawing(PVector dragPoint) {
    this.shapeEndPoint = dragPoint;
  }


  public void endMouseDrawing(PVector endPoint) {
    this.shapeEndPoint = endPoint;
  }


  public boolean tryToggleSelect(PVector p) {
    
    SimpleUIRect boundingBox = new SimpleUIRect(shapeStartPoint.x, shapeStartPoint.y, shapeEndPoint.x, shapeEndPoint.y);
   
    if ( boundingBox.isPointInside(p)) {
      this.isSelected = !this.isSelected;
      return true;
    }
    return false;
  }



  public void drawMe() {

    float x1 = this.shapeStartPoint.x;
    float y1 = this.shapeStartPoint.y;
    float x2 = this.shapeEndPoint.x;
    float y2 = this.shapeEndPoint.y;
    float w = x2-x1;
    float h = y2-y1;
    
    // you need to set the shapes drawing style here
    if ( shapeType.equals("Rectangle")){
      fill(83, 83, 83);
      rect(x1, y1, w, h);
    }
    if ( shapeType.equals("Ellipse")) ellipse(x1+ w/2, y1 + h/2, w, h);
    if ( shapeType.equals("Line")) line(x1, y1, x2, y2);
    if ( shapeType.equals("Image") && theImage != null) image(theImage, x1, y1, w,h);
    
    // simplified "select" indication
    if(isSelected) {
        pushStyle();
        noFill();
        strokeWeight(4);
        stroke(255,0,0);
        rect(x1, y1, w, h);
        popStyle();
      }

  }

 
  
}     // end DrawnShape

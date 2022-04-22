class DrawingList {

  ArrayList<DrawnShape> shapeList = new ArrayList<DrawnShape>();


  public DrawnShape currentlyDrawnShape = null;

  public DrawingList() {
  }
  
  public void drawMe() {
    for (DrawnShape s : shapeList) {
      s.drawMe();
    }
  }


  public void handleMouseDrawEvent(String shapeType, String mouseEventType, PVector mouseLoc, PImage image) {

    if ( mouseEventType.equals("mousePressed")) {
      DrawnShape newShape = new DrawnShape(shapeType, image);
      newShape.startMouseDrawing(mouseLoc);
      shapeList.add(newShape);
      currentlyDrawnShape = newShape;
    }

    if ( mouseEventType.equals("mouseDragged")) {
      currentlyDrawnShape.duringMouseDrawing(mouseLoc);
    }

    if ( mouseEventType.equals("mouseReleased")) {
      currentlyDrawnShape.endMouseDrawing(mouseLoc);
    }
  }


  

  public void trySelect(String mouseEventType, PVector mouseLoc) {
    if( mouseEventType.equals("mousePressed")){
      
      for (DrawnShape s : shapeList) {
        boolean selectedShape = s.tryToggleSelect(mouseLoc);
        if(selectedShape) {
          s.isSelected = !s.isSelected;
          continue;
        }
        if (s.isSelected) s.isSelected = false;
      }
      
      for (DrawnShape s : shapeList) {    
        boolean selectionFound = s.tryToggleSelect(mouseLoc);
        
        if (selectionFound) break;
      }
      
      for (DrawnShape s : shapeList) {
        if (s.isSelected) {
          print("A shape is selected");
        }
      }
    }
    
  }
  
  
  void deleteSelected(){
    ArrayList<DrawnShape> tempShapeList = new ArrayList<DrawnShape>();
    for (DrawnShape s : shapeList) {
     
        if (s.isSelected == false) tempShapeList.add(s);
      }
    shapeList = tempShapeList;
  }
  
  
  
}

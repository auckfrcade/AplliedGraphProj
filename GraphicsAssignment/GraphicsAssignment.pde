SimpleUI myUI;
DrawingList drawingList;

PImage originalImage;
PImage rgbImage;
PImage editedImage;
PImage shapeImage;

boolean shapeImageLoading = false;

String toolMode = "";

int rgbHeight = 35;
int drawShapeHeight = 180;

float brightness = 1;

RadioButton originalColorButton;
RadioButton greenColorButton;
Slider brightnessSlider;

void setup() {
  size(1380,820);
  
  myUI = new SimpleUI();
  drawingList = new DrawingList();
  
  
  
  //TOOL: Select
  myUI.addSimpleButton("SELECT", 2, height - 50);
  
  
  
  
  //LABEL: RGB Manp
  
  myUI.addSimpleLabel("RGB Manipulation", 2, rgbHeight +390, "RGB Manipulation");
  
  
  
  //RGB Manipulation
  
  originalColorButton = myUI.addRadioButton("Original", 2, rgbHeight + 410,"RGB");
  originalColorButton.setSelected(true);
  greenColorButton = myUI.addRadioButton("Green Scale", 2, rgbHeight + 432,"RGB");
  
  
  
  //LABEL: Brightness 
  
  myUI.addSimpleLabel("Brightness", 2, rgbHeight + 137, "Brightness");
  brightnessSlider = myUI.addSlider("Brightness", 2, rgbHeight + 162);
  brightnessSlider.setSliderValue(1);
  myUI.addSimpleButton("Reset",2 , rgbHeight + 195);
  
  //LABEL: Draw Shape
  
  myUI.addSimpleLabel("Draw Shape", 2, drawShapeHeight +123, "Draw Shape");
  
  //LOAD: Shape image
  
  myUI.addSimpleButton("Load Shape Image", 2, drawShapeHeight + 147);
  
  //MENU: Draw shape
  
  String[] shapeMenuItems = { "Rectangle", "Ellipse", "Line", "Image" };
  Menu shapeMenu = myUI.addMenu("Draw Shape",2, drawShapeHeight + 170, 110, 20, shapeMenuItems);
  toolMode = shapeMenu.UILabel;
  
  //MENU: File
  
  String[] fileMenuItems = { "Load File", "Save File" };
  myUI.addMenu("File", 3, 7, 110, 20, fileMenuItems);
  
  //CANVAS
  
  myUI.addCanvas(180,85,1150,675);
  
}

void draw() {
 background(255);
 
 if(editedImage != null){
   image(editedImage,110,10);
   //image(rgbImage, 110, 350);
   //image(originalImage,610,10);
 }
 
 drawingList.drawMe();
 
  myUI.update();
}


void handleUIEvent(UIEventData eventData){
  
  //LOAD: Image
  
  if(eventData.menuItem == "Load File"){
    myUI.openFileLoadDialog("Load an Image");
    return;
  }
  
  if(eventData.eventIsFromWidget("fileLoadDialog") && shapeImageLoading == false){
    originalImage = loadImage(eventData.fileSelection);
    rgbImage = originalImage.copy();
    editedImage = originalImage.copy();
    originalColorButton.setSelected(true);
    greenColorButton.setSelected(false);
    return;
  }
  
  //SAVE: Image
  
  if(eventData.menuItem == "Save File" && editedImage != null){
    myUI.openFileSaveDialog("Save an Image");
    return;
  }
  
  if(eventData.eventIsFromWidget("fileSaveDialog")){
    if(editedImage != null){
      editedImage.save(eventData.fileSelection);
      return;
    }
  }
  
  //RGB: Manupulation
  
  if(originalImage != null){
    if(eventData.eventIsFromWidget("Original")){
      println("Original");
      for (int y = 0; y < editedImage.height; y++){
        for (int x = 0; x < editedImage.width; x++){
          color originalPix = originalImage.get(x,y);
          
          float r = red(originalPix);
          float g = green(originalPix);
          float b = blue(originalPix);
          
          color originalColour = color(r,g,b);
          rgbImage.set(x,y,originalColour);
        }
      }
      
      for (int y = 0; y < editedImage.height; y++){
        for (int x = 0; x < editedImage.width; x++){
          color thisPix = rgbImage.get(x,y);
          
          float r = red(thisPix) * brightness;
          float g = green(thisPix) * brightness;
          float b = blue(thisPix) * brightness;
          
          color newBrightness = color(r,g,b);
          editedImage.set(x,y,newBrightness);
        }
      }
      return;
    }
    
    if(eventData.eventIsFromWidget("Green Scale")){
      println("Green Scale");
      for (int y = 0; y < editedImage.height; y++){
        for (int x = 0; x < editedImage.width; x++){
          color thisPix = originalImage.get(x,y);
          
          float r = red(thisPix);
          float g = green(thisPix);
          float b = blue(thisPix);
          
          color swappedColour = color(g,r,b);
          rgbImage.set(x, y, swappedColour);
        }
      }
      for (int y = 0; y < editedImage.height; y++){
        for (int x = 0; x < editedImage.width; x++){
          color thisPix = rgbImage.get(x,y);
          
          float r = red(thisPix) * brightness;
          float g = green(thisPix) * brightness;
          float b = blue(thisPix) * brightness;
          
          color newBrightness = color(r,g,b);
          editedImage.set(x,y,newBrightness);
        }
      }
      return;
    }
    if(eventData.eventIsFromWidget("Brightness")){
      brightness = brightnessSlider.getSliderValue();
      for (int y = 0; y < editedImage.height; y++){
        for (int x = 0; x < editedImage.width; x++){
          color thisPix = rgbImage.get(x,y);
          
          float r = red(thisPix) * brightness;
          float g = green(thisPix) * brightness;
          float b = blue(thisPix) * brightness;
          
          color newBrightness = color(r,g,b);
          editedImage.set(x,y,newBrightness);
        }
      }
      return;
    }
    if(eventData.eventIsFromWidget("Reset")){
      brightnessSlider.setSliderValue(1);
      brightness = brightnessSlider.getSliderValue();
      
      for (int y = 0; y < editedImage.height; y++){
        for (int x = 0; x < editedImage.width; x++){
          color thisPix = rgbImage.get(x,y);
          
          float r = red(thisPix) * brightness;
          float g = green(thisPix) * brightness;
          float b = blue(thisPix) * brightness;
          
          color newBrightness = color(r,g,b);
          editedImage.set(x,y,newBrightness);
        }
      }
    }
  }
  
  //LOAD: Shape Image
  
  if(eventData.eventIsFromWidget("Load Shape Image")){
    shapeImageLoading = true;
    myUI.openFileLoadDialog("Load a Shape Image");
  }
  if(eventData.eventIsFromWidget("fileLoadDialog") && shapeImageLoading == true){
    shapeImage = loadImage(eventData.fileSelection);
  }
 
  
  if(eventData.eventIsFromWidget("Draw Shape")){
    toolMode = eventData.menuItem;
    return;
  }
  if(eventData.eventIsFromWidget("Select")){
    toolMode = "Select";
    return;
  }

  
  if(eventData.eventIsFromWidget("canvas")==false) return;
  PVector p =  new PVector(eventData.mousex, eventData.mousey);
  
  
  if( toolMode.equals("Rectangle") || 
      toolMode.equals("Ellipse") || 
      toolMode.equals("Line") ||
      toolMode.equals("Image")){    
     drawingList.handleMouseDrawEvent(toolMode,eventData.mouseEventType, p, shapeImage);
     return;
  }
   

  if( toolMode.equals("Select") ) {    
      drawingList.trySelect(eventData.mouseEventType, p);
    }
}

void keyPressed(){
  if(key == BACKSPACE){
    drawingList.deleteSelected();
  }
}

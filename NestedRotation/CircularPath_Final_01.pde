import controlP5.*;

//EDITABLE VALUES for playing around
float sideLength = 15;       //The spacing between each ring, in pixels
float rotationSpeed = .05;
float size = 300;             //The total size of the whole thing
float screenChangeRate = 30; //This variable acts inversely
float minSectorAngle = 90;   //Default to 90
float maxSectorAngle = 360;  //Default to 360
int delay = 21;              //Minimum amount of time before new
                                 //shape can be drawn

//DON'T CHANGE THESE
FloatList xList;
FloatList yList;
FloatList angles;
Dot dot = new Dot();
float rotation = 0;
int timeCount = 0;

//BUTTONS
// 1) Pause 
// 2) Make new shape
//SLIDERS
// 1) Total size
// 2) Rotation speed
// 3) Side Length
// 4) min Sector Angle
// 5) max Sector Angle

ControlP5 cp5;

int buttonWidth = 200;
int buttonHeight = 50;
int buttonVerticalOffset = 56;

Button pauseButton;
Button createButton;


int sliderWidth = 200;
int sliderHeight = 32;
int sliderVerticalOffset = 38;


ArrayList<Slider> sliders;
Slider sizeSlider;
Slider rotationSpeedSlider;
Slider sideLenghtSlider;
Slider minSectorAngleSlider;
Slider maxSectorAngleSlider;

boolean isPaused;

void setup()
{
  size(1000, 900);
  background(255);
  
  isPaused = false;
  
  cp5 = new ControlP5(this);
  
  angles = new FloatList();
  xList = new FloatList();
  yList = new FloatList();
  
  //Add to sliders array
  sliders = new ArrayList<Slider>();
  sliders.add(sizeSlider);
  sliders.add(rotationSpeedSlider);
  sliders.add(sideLenghtSlider);
  sliders.add(minSectorAngleSlider);
  sliders.add(maxSectorAngleSlider);
  
  // Create UI Elements
  pauseButton = createButton("PAUSE", width - buttonWidth - 10, 0, buttonWidth, buttonHeight);
  createButton = createButton("CREATE_NEW", width - buttonWidth - 10, 
                buttonVerticalOffset, buttonWidth, buttonHeight);
  
  sizeSlider = createSlider("SIZE", 10, 10, sliderWidth, sliderHeight, 10, 800, 300);
  rotationSpeedSlider = createSlider("ROTATION", 10, 10 + sliderVerticalOffset * 1, 
        sliderWidth, sliderHeight, .01, .25, .02);
  sideLenghtSlider = createSlider("SIDE_LENGTH", 10, 10 + sliderVerticalOffset * 2, 
        sliderWidth, sliderHeight, 5, 20, 10);
  minSectorAngleSlider = createSlider("MIN_ANGLE", 10, 10 + sliderVerticalOffset * 3, 
        sliderWidth, sliderHeight, 45, 180, 90);
  maxSectorAngleSlider = createSlider("MAX_ANGLE", 10, 10 + sliderVerticalOffset * 4, 
        sliderWidth, sliderHeight, 180, 360, 270);
  
  
  //Construct the image
  MakeDistanceList();
  CreateNewImage();
  
  //Draw the image
  pushMatrix();
  translate(width / 2, height / 2);
  DrawShape();
  popMatrix();
  
  //writeSliderText(sliders);
}


void draw()
{
  if (!isPaused)
  {
    pushMatrix();
    
    background(255);
    translate(width / 2, height / 2);
    rotate(rotation);
    rotation += rotationSpeed;
    timeCount++;
    
    /*if(mousePressed && timeCount > delay) 
    {
      timeCount = 0;
      CreateNewImage();
    }*/
    DrawShape();
    
    popMatrix();
  }
}


public void controlEvent(ControlEvent theEvent) 
{
  Controller object = theEvent.getController();
  
  if (object == pauseButton)
  {
    isPaused = !isPaused;
  }
  else if (object == createButton)
  {
    timeCount = 0;
    CreateNewImage();
  }
  else if (object == sizeSlider)
  {
    size = sizeSlider.getValue();
  }
  else if (object == rotationSpeedSlider)
  {
    rotationSpeed = rotationSpeedSlider.getValue();
  }
  else if (object == sideLenghtSlider)
  {
    sideLength = sideLenghtSlider.getValue();
  }
  else if (object == minSectorAngleSlider)
  {
    minSectorAngle = minSectorAngleSlider.getValue();
  }
  else if (object == maxSectorAngleSlider)
  {
    maxSectorAngle = maxSectorAngleSlider.getValue();
  }
}



void CreateNewImage()
{ 
  MakeDistanceList();
  xList.clear();
  yList.clear();
  
  
  for(int i = 0; i < angles.size(); i++)
  {
    dot.MoveLine();
    dot.MoveCircle(i);
  }
  
  dot.currentX = 0;
  dot.currentY = 0;
  
}


void DrawShape()
{
  beginShape();
  for(int i = 350; i < xList.size(); i++)
  {
    vertex(xList.get(i), yList.get(i));
  }
  endShape();
}


void MakeDistanceList()
{
  angles.clear();
  
  angles.set(0, 360);
  
  for(int i = 1; i < size; i += sideLength)
  {
    angles.append(random(minSectorAngle, maxSectorAngle));  
  }
}


Button createButton(String name, int x, int y, int myWidth, int myHeight)
{
  Button button = cp5.addButton(name);
  button.setValue(0).setPosition(x, y).setSize(myWidth, myHeight);
  button.getCaptionLabel().setSize(myWidth / 10);
  return button;
}

Slider createSlider(String name, int x, int y, int myWidth, int myHeight, float min, float max, float value)
{
  textSize(16);
  fill(255);
  text(name, x, y);
  
  Slider slider = cp5.addSlider(name)
    .setCaptionLabel(name)
    .setPosition(x, y)
    .setColorCaptionLabel(color(0,0,0))
    .setSize(myWidth, myHeight)
    .setRange(min, max)
    .setValue(value)
    .setDecimalPrecision(2);
    
  slider.getCaptionLabel().setSize(20);
    
  return slider;
}

/*void writeSliderText(ArrayList<Slider> sliders)
{
  for (int i = 0; i < sliders.size(); i++)
  {
    Slider slider = sliders.get(i);
    //float[] position = slider.getPosition();
    
    text(slider.getName(), 0, 0);
  }
}*/
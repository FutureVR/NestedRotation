class Dot
{
  float stepSize = .1;
  float diameter = 2;
  public float currentX;
  public float currentY;
  float currentAngle = 0;
  float lastX;
  float lastY;
  float angle;
  boolean moveClockwise = true;
  
  Dot()
  {
    currentX = 0;
    currentY = 0;
    currentAngle = 0;
    lastX = 0;
    lastY = 0;
  }
  
  void MoveLine()
  {
    lastX = currentX;
    lastY = currentY;
    angle = atan2(currentY, currentX);
    
    while(dist(currentX, currentY, lastX, lastY) < sideLength)
    {
      PlotVertex();
      
      currentX = currentX + cos(angle) * stepSize;
      currentY = currentY + sin(angle) * stepSize;
    }
  }
  
  void MoveCircle(int i)
  {
    float radius = (i + 1) * sideLength;
   
    if(moveClockwise)
    {
      for(float trackAngle = currentAngle; trackAngle < currentAngle + angles.get(i); trackAngle++)
      {
        currentX = radius * cos(radians(trackAngle));
        currentY = radius * sin(radians(trackAngle));
        PlotVertex();
      }
     
      currentAngle = currentAngle + angles.get(i);
    }
    else
    {
      for(float trackAngle = currentAngle; trackAngle > currentAngle - angles.get(i); trackAngle--)
      {
        currentX = radius * cos(radians(trackAngle));
        currentY = radius * sin(radians(trackAngle));
        PlotVertex();
      }
      
      currentAngle = currentAngle - angles.get(i);  
    }
    
    moveClockwise = !moveClockwise;
  }
  
  void PlotVertex()
  {
    xList.append(currentX);
    yList.append(currentY);
  }
}
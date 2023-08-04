public class ScrollBar{
  public int circleRadius = 5;
  public int circleXPos = width/6;
  public int yPos = height-70;
  public float hueColor = 0;
  
  private int rectHeight = 20;
  private int minLoc = width/6;
  private int maxLoc = boxSize+width/6;

  public ScrollBar(){
    rectMode(CENTER);
    fill(255,255,255,0);
    rect(width/2,yPos,boxSize,rectHeight);
    
    showHueRange();
    
    push();
    stroke(240);
    strokeWeight(3);
    circle(circleXPos,yPos,circleRadius);
    pop();
    
    this.hueColor = get(circleXPos,yPos);
  }
  
  private void showHueRange(){
    push();
    colorMode(HSB, 100); //range from 0 to 100%
    
    for(int x = minLoc; x <=maxLoc; x+=3){
      for(int y = yPos-rectHeight/2; y<= yPos+rectHeight/2;y+=3){
        float hue = map(x, minLoc, maxLoc, 0, 100);
        stroke(hue,100,100);
        strokeWeight(6);
        square(x,y,2);
      }
    }
    pop();
  }

  private void reDraw(){
      //clear
    noStroke();
    fill(backgroundColor);
    rect(width/2,yPos,boxSize+2,rectHeight+2);
    circle(circleXPos,yPos,circleRadius+5);
      
      //redraw
    stroke(0);
    rect(width/2,yPos,boxSize,rectHeight);
    showHueRange();
    
    fill(0,0,0,0);
    
    push();
    stroke(240);
    strokeWeight(3);
    
    if (mouseX >=minLoc && mouseX <= maxLoc) {
      this.circleXPos = mouseX;
      circle(circleXPos,yPos,circleRadius);
    }
    
    else if(mouseX < minLoc){
      this.circleXPos = minLoc;
      circle(circleXPos,yPos,circleRadius);
    }
    
    else if(mouseX > minLoc){
      this.circleXPos = maxLoc;
      circle(circleXPos,yPos,circleRadius);
    }
    pop();
    
    getHue();
  }
  
  private void getHue(){
    push();
    colorMode(HSB,100);
    color aColor = get(circleXPos,yPos);
    this.hueColor = hue(aColor);
    pop();
     
  }
}

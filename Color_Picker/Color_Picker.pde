public static int boxSize = 400;
public int textPos = 60;
public Boolean allowColorViewChange = false;
public Boolean allowMovePicker = false;

public float saturation,brightness;
public float hueColor;

//picker
public int pickerX = boxSize-width/2;
public int pickerY = boxSize-height/2;
public int pickerSize = 5;
public Boolean allowPickerMove = false;

//scrollbar
ScrollBar scrollBar;
public Boolean allowScrollBarMove = false;
public static int backgroundColor = 100;

void setup(){
  size(600,600);
  background(backgroundColor);
  pixelDensity(2);
  
  rectMode(CENTER);
  noStroke();
  square(width/2,height/2,boxSize);
  
  stroke(0);
  
  textSize(15);
  fill(0);
  text("RGB: ", 100, textPos);
  text("HEX-CODE: ", 100, textPos+20);
  
  scrollBar = new ScrollBar();
  
  changeColorView();
  
  circle(pickerX,pickerY,pickerSize);
}

void changeColorView(){
  displayText();
  
  push();
  fill(backgroundColor);
  noStroke();
  square(width/2,height/2,boxSize+25);
  pop();
  
   push();
   hueColor = scrollBar.hueColor;
   //println(hueColor);
   colorMode(HSB, 100); //range from 0 to 100%
   strokeWeight(6);
   
   for(int x = boxSize-width/2; x <=(boxSize/2)+width/2; x+=4){
     saturation = map(x,boxSize-width/2,(boxSize/2)+width/2,0,100);
     
     for(int y = boxSize-height/2; y<= boxSize/2+height/2;y+=4){
      brightness = map(y,boxSize-height/2,(boxSize/2)+height/2,100,0);
      stroke(hueColor,saturation,brightness);
      square(x,y,2);
      }
    }
   pop();
   
   push();
   
       strokeWeight(2);
       stroke(255/2);
       fill(0,0,0,0);
       circle(pickerX,pickerY,pickerSize);
    
   pop();
   
  displayText();
}

void displayText(){
  
   push();
   color c = get(pickerX,pickerY);
   int r = int(red(c));
   int g = int(green(c));
   int b = int(blue(c));
   
   push();
   rectMode(RADIUS);
   fill(backgroundColor);
   noStroke();
   rect(120,textPos,100,10);
   pop();
   
   String result = String.format("RGB: %d, %d, %d",r,g,b);  
   text(result, 100, textPos);
   pop();
}

void draw(){
  if (allowScrollBarMove == true) {
    scrollBar.reDraw();
  }
  
  if (allowColorViewChange == true){
    changeColorView();
  }
  
  if (allowMovePicker == true) {
    if (mouseX >= boxSize-(width/2)
      && mouseX <=(width/6)+(boxSize)
      && mouseY >= boxSize-(height/2)
      &&  mouseY < (height/6)+(boxSize)){
      pickerX = mouseX;
      pickerY = mouseY;
    }
    changeColorView();
  }
    
}

void mouseDragged(){
  //condition to activate scrollbar
  if (mouseX > scrollBar.circleXPos - scrollBar.circleRadius 
        && mouseX < scrollBar.circleXPos + scrollBar.circleRadius 
        && mouseY > scrollBar.yPos - scrollBar.circleRadius
        && mouseY < scrollBar.yPos + scrollBar.circleRadius){
        allowScrollBarMove = true;
        allowColorViewChange = true;
  }
  
  if (mouseX >= boxSize-(width/2)
      && mouseX <=(width/6)+(boxSize)
      && mouseY >= boxSize-(height/2)
      &&  mouseY < (height/6)+(boxSize)){
      allowMovePicker = true;
  }
  
}

void mouseReleased() {
  allowScrollBarMove = false;
  allowColorViewChange = false;
  allowMovePicker = false;
}

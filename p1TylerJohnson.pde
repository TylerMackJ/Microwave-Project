import controlP5.*;

ControlP5 cp5;

boolean doorOpen = true;
Button[] presets = new Button[6];
boolean presetMode = true;
int timeM = 0;
int timeS = 0;

void setup() {
  size(1000, 500);
  cp5 = new ControlP5(this);
  
  cp5.addButton("open").setValue(0).setPosition(760, 410).setSize(137, 60).setCaptionLabel("Open");
  cp5.addButton("start").setValue(0).setPosition(906, 410).setSize(63, 60).setCaptionLabel("Start");
  
  cp5.addButton("thirty").setValue(0).setPosition(760, 360).setSize(63, 40).setCaptionLabel("Add 0:30");
  cp5.addButton("zero").setValue(0).setPosition(833, 360).setSize(63, 40).setCaptionLabel("0");
  cp5.addButton("clear").setValue(0).setPosition(906, 360).setSize(63, 40).setCaptionLabel("Clear");
  
  cp5.addButton("seven").setValue(7).setPosition(760, 310).setSize(63, 40).setCaptionLabel("7");
  cp5.addButton("eight").setValue(8).setPosition(833, 310).setSize(63, 40).setCaptionLabel("8");
  cp5.addButton("nine").setValue(9).setPosition(906, 310).setSize(63, 40).setCaptionLabel("9");
  
  presets[3] = cp5.addButton("four").setValue(4).setPosition(760, 260).setSize(63, 40).setCaptionLabel("4");
  presets[4] = cp5.addButton("five").setValue(5).setPosition(833, 260).setSize(63, 40).setCaptionLabel("5");
  presets[5] = cp5.addButton("six").setValue(6).setPosition(906, 260).setSize(63, 40).setCaptionLabel("6");
  
  presets[0] = cp5.addButton("one").setValue(1).setPosition(760, 210).setSize(63, 40).setCaptionLabel("1");
  presets[1] = cp5.addButton("two").setValue(2).setPosition(833, 210).setSize(63, 40).setCaptionLabel("2");
  presets[2] = cp5.addButton("three").setValue(3).setPosition(906, 210).setSize(63, 40).setCaptionLabel("3");
  
  cp5.addButton("preset").setValue(0).setPosition(760, 150).setSize(137, 50).setCaptionLabel("Preset/Reheat");
  cp5.addButton("timecook").setValue(0).setPosition(906, 150).setSize(63, 50).setCaptionLabel("Time Cook"); 
  
}

void draw() {
  background(50, 50, 50);
  strokeWeight(2);
  
  // Window
  fill(150, 150, 150);
  rect(30, 30, 690, 440, 10);
  
  // Interior or Door outline (draw over window to hide window)
  if(doorOpen) {
    fill(200, 200, 200);
  } else {
    fill(0, 0, 0, 0);
  }
  strokeWeight(4);
  rect(20, 20, 710, 460);
  strokeWeight(2);
  
  // Touch Screen
  fill(200, 200, 200);
  rect(750, 20, 230, 460);
  
  // Time
  textSize(40);
  fill(0, 0, 0);
  String timeText = str(timeM) + ":" + str(timeS);
  text(timeText, 810, 100); 
}

public void open() {
  doorOpen = !doorOpen;  
}

public void zero() {
  numberPressed(0);
}
public void one() {
  numberPressed(1);
}
public void two() {
  numberPressed(2);
}
public void three() {
  numberPressed(3);
}
public void four() {
  numberPressed(4);
}
public void five() {
  numberPressed(5);
}
public void six() {
  numberPressed(6);
}
public void seven() {
  numberPressed(7);
}
public void eight() {
  numberPressed(8);
}
public void nine() {
  numberPressed(9);
}

public void numberPressed(int value) {
  println(value);
}

public void preset() {
  presetMode = !presetMode;
  String[] presetText = {"Popcorn", "Potatoe", "Pizza", "Frozen Food", "Beef", "Chicken"};
  String[] numberText = {"1", "2", "3", "4", "5", "6"};
  
  for (int i = 0; i < 6; i++) {
    if(presetMode) {
      presets[i].setCaptionLabel(presetText[i]);
    } else {
      presets[i].setCaptionLabel(numberText[i]);
    }  
  }
}

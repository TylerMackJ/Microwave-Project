import controlP5.*;

ControlP5 cp5;

boolean doorOpen = true;
Button[] presets = new Button[6];
int powerLevel = 10;
boolean presetMode = false;
int timeM = 0;
int timeS = 0;
boolean running = false;
int frame = 0;
int fps = 30;
boolean tcMode = false;
boolean setupComplete = false;

void setup() {
  size(1000, 500);
  cp5 = new ControlP5(this);
  frameRate(fps);
  
  cp5.addButton("open").setValue(0).setPosition(760, 410).setSize(137, 60).setCaptionLabel("Open");
  cp5.addButton("start").setValue(0).setPosition(906, 410).setSize(63, 60).setCaptionLabel("Start\n Stop");
  
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
  
  cp5.addButton("levelDown").setValue(0).setPosition(760, 100).setSize(50, 40).setCaptionLabel("Power -");
  cp5.addButton("levelUp").setValue(0).setPosition(820, 100).setSize(50, 40).setCaptionLabel("Power +");
  
  setupComplete = true;
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
  String timeText = String.format("%02d:%02d", timeM, timeS);
  text(timeText, 810, 75); 
  
  // Info
  textSize(12);
  String infoText = String.format("   %s\n  %s\n    Power %s", running ? "Running" : "", tcMode ? "Time Cook" : "", presetMode ? "Auto" : str(powerLevel));
  text(infoText, 880, 100);
  
  // Microwave is counting down
  if(running) {
    frame++;
    // One second has passed
    if (frame == fps) {
      frame = 0;
      timeS--;
      
      if (timeS < 0) {
        timeM--;
        if(timeM < 0) {
          timeM = 0;
          timeS = 0;
          running = false;
        } else {
          timeS = 59;
        }
      }
      
    }
  }
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
public void thirty() {
  if(setupComplete) {
    timeS += 30;
    if(int(timeS / 60) != 0) {
      timeM += + int(timeS / 60);
    }
    timeS %= 60;
    timeM %= 100;
  }
}
public void timecook() {
  if(setupComplete) {
    tcMode = !tcMode;
  }
}
public void start() {
  if(setupComplete) {
    running = !running;
    frame = 0;
  }
}
public void levelDown() {
  powerLevel--;
  if(powerLevel < 0) {
    powerLevel = 0;
  }
}
public void levelUp() {
  powerLevel++;
  if(powerLevel > 10) {
    powerLevel = 10;
  }
}

public void clear() {
  timeS = 0;
  timeM = 0;
}

public void numberPressed(int value) {
  if(setupComplete && !running) {  
    boolean presetUsed = false;
    if (presetMode && value >= 1 && value <= 6) {
      presetUsed = true;
      timeM = 3;
      timeS = 0;
      running = true;
    }
    
    
    if(!presetUsed) {
      if(tcMode) {
        timeS = timeS * 10 + value;
        timeM = timeM * 10 + int(timeS / 100);
        timeS %= 100;
        timeM %= 100;
      } else {
        timeM += value;
        running = true;
      }
    }
  }
}

public void preset() {
  if (setupComplete) {
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
}

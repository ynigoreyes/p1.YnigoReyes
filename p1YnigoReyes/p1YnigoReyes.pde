import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import processing.serial.*;

private boolean isOn = false;
private int timeLeft = 0;

private final int SCREEN_HEIGHT = 1000;
private final int SCREEN_WIDTH = 500;

private final int SIZE_OF_WINDOWS = SCREEN_WIDTH - 100;

private final int buttonHeight = 75;
private final int startOfButtons = 350;

public String timeToShow = "00:00";
private DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm:ss");

private String selectedPreset = null;

private int fiveMinButton = startOfButtons + 0;
private int threeMinButton = startOfButtons + (buttonHeight * 1) + 10;
private int oneMinButton = startOfButtons + (buttonHeight * 2) + 20;
private int thirtySecButton = startOfButtons + (buttonHeight * 3) + 30;
private int fifteenSecButton = startOfButtons + (buttonHeight * 4) + 40;
private int leftButtonWidth = 150;
private int leftButtonMargin = 20;
private int rightButtonMargin = 175;
private int rightButtonWidth = 300;
private int startOfButtonText = startOfButtons + 30;

private float stopButtonStart = SCREEN_HEIGHT * 0.8;
private float stopButtonMargin = 150;
private float stopButtonWidth = SCREEN_WIDTH * 0.4;
private float stopButtonHeight = 100;

public void setup()
{
  frameRate(120);
  size(500, 1000);
  textAlign(CENTER, CENTER);
}

public void draw()
{
  clear();
  background(133, 120, 133);
 
  //createMouseTracker();
  if (isOn) {
    background(211, 239, 189);
    createTimer();
  } else {
    background(224, 226, 219);
    createClock();
  }

  if(selectedPreset != null && !selectedPreset.trim().isEmpty())
  {
    createPresetWindow();
  }
  createTimeButtons();
  createPresetButtons();
  createStopButton();
  checkTime();
}

void checkTime()
{
  if (timeLeft > 0)
  {
    timeLeft--;
    delay(1000);
  } else {
    isOn = false;
  }
}

void mousePressed()
{
  if (
    (mouseX > leftButtonMargin && mouseX < leftButtonWidth + leftButtonMargin) &&
    (mouseY > startOfButtons && mouseY < startOfButtons + (buttonHeight * 1) + 10)
  ) {
    timeLeft = timeLeft + (60 * 5);
    selectedPreset = null;
    isOn = true;
  }
  else if (
    (mouseX > leftButtonMargin && mouseX < leftButtonWidth + leftButtonMargin) &&
    (mouseY > startOfButtons && mouseY < startOfButtons + (buttonHeight * 2) + 20)
  ) {
    timeLeft = timeLeft + (60 * 3);
    selectedPreset = null;
    isOn = true;
  }
  else if (
    (mouseX > leftButtonMargin && mouseX < leftButtonWidth + leftButtonMargin) &&
    (mouseY > startOfButtons && mouseY < startOfButtons + (buttonHeight * 3) + 30)
  ) {
    timeLeft = timeLeft + 60;
    selectedPreset = null;
    isOn = true;
  }
  else if (
    (mouseX > leftButtonMargin && mouseX < leftButtonWidth + leftButtonMargin) &&
    (mouseY > startOfButtons && mouseY < startOfButtons + (buttonHeight * 4) + 40)
  ) {
    timeLeft = timeLeft + 30;
    selectedPreset = null;
    isOn = true;
  }
  else if (
    (mouseX > leftButtonMargin && mouseX < leftButtonWidth + leftButtonMargin) &&
    (mouseY > startOfButtons && mouseY < startOfButtons + (buttonHeight * 5) + 50)
  ) {
    timeLeft = timeLeft + 15;
    isOn = true;
  }
  else if (
    (mouseX > rightButtonMargin && mouseX < rightButtonWidth + rightButtonMargin) &&
    (mouseY > startOfButtons && mouseY < startOfButtons + (buttonHeight * 2) + 20)
  ) {
    timeLeft = 45;
    selectedPreset = "Pizza";
    isOn = true;
  }
  else if (
    (mouseX > rightButtonMargin && mouseX < rightButtonWidth + rightButtonMargin) &&
    (mouseY > startOfButtons && mouseY < startOfButtons + (buttonHeight * 3) + 30)
  ) {
    timeLeft = (60 * 1) + 30;
    selectedPreset = "Reheat";
    isOn = true;
  }
  else if (
    (mouseX > rightButtonMargin && mouseX < rightButtonWidth + rightButtonMargin) &&
    (mouseY > startOfButtons && mouseY < startOfButtons + (buttonHeight * 4) + 40)
  ) {
    timeLeft = (60 * 8);
    selectedPreset = "Defrost";
    isOn = true;
  }
  else if (
    (mouseX > rightButtonMargin && mouseX < rightButtonWidth + rightButtonMargin) &&
    (mouseY > startOfButtons && mouseY < startOfButtons + (buttonHeight * 5) + 50)
  ) {
    timeLeft = (60 * 2) + 10;
    selectedPreset = "Popcorn";
    isOn = true;
  } else if (
    (mouseX > stopButtonMargin && mouseX < stopButtonWidth + stopButtonMargin) &&
    (mouseY > stopButtonStart && mouseY < stopButtonStart + stopButtonHeight)
  ) {
    timeLeft = 0;
    selectedPreset = null;
    isOn = false;
  }
}
public void createPresetWindow()
{
  fillDarkGreen();
  textSize(24);
  text("Selected Preset", SCREEN_WIDTH /2 , 180);

  fillDarkGreen();
  textSize(60);
  text(selectedPreset, SCREEN_WIDTH /2 , 240);
}

public void createMouseTracker()
{
  stroke(0);
  fill(128);
  circle(mouseX, mouseY, 30);
}

public void createClock()
{
  fillDarkGreen();
  rect((SCREEN_WIDTH - SIZE_OF_WINDOWS) / 2, 25, SIZE_OF_WINDOWS, 100, 10);
  
  fillLightTan();
  textSize(72);
  String time = formatter.format(LocalDateTime.now());
  timeToShow = time;
  text(timeToShow, SCREEN_WIDTH /2 , 75);
}

public void createTimer()
{
  fillDarkGreen();
  rect((SCREEN_WIDTH - SIZE_OF_WINDOWS) / 2, 25, SIZE_OF_WINDOWS, 100, 10);
  
  fillLightTan();
  textSize(60);
  int minutesLeft = timeLeft / 60;
  int secondsLeft = timeLeft % 60;
  text(String.format("%d min %d sec", minutesLeft, secondsLeft), SCREEN_WIDTH /2 , 75);
}

public void createTimeButtons()
{
  fillDarkGreen();
  rect(leftButtonMargin, fiveMinButton, leftButtonWidth, buttonHeight, 10);
  
  fillDarkGreen();
  rect(leftButtonMargin, threeMinButton, leftButtonWidth, buttonHeight, 10);
  
  fillDarkGreen();
  rect(leftButtonMargin, oneMinButton, leftButtonWidth, buttonHeight, 10);
  
  fillDarkGreen();
  rect(leftButtonMargin, thirtySecButton, leftButtonWidth, buttonHeight, 10);
  
  fillDarkGreen();
  rect(leftButtonMargin, fifteenSecButton, leftButtonWidth, buttonHeight, 10);
  
  fillTan();
  textSize(32);
  text("+5 min",90, startOfButtonText + 0);
  
  fillTan();
  textSize(32);
  text("+3 min",90 , startOfButtonText + (buttonHeight * 1) + 10);
  
  fillTan();
  textSize(32);
  text("+1 min",90 , startOfButtonText + (buttonHeight * 2) + 20);
  
  fillTan();
  textSize(32);
  text("+30 sec",90 , startOfButtonText + (buttonHeight * 3) + 30);
  
  fillTan();
  textSize(32);
  text("+15 sec",90 , startOfButtonText + (buttonHeight * 4) + 40);
}

public void createPresetButtons()
{
  fillDarkGreen();
  rect(rightButtonMargin, startOfButtons + (buttonHeight * 1) + 10, rightButtonWidth, buttonHeight, 10);
  
  fillDarkGreen();
  rect(rightButtonMargin, startOfButtons + (buttonHeight * 2) + 20, rightButtonWidth, buttonHeight, 10);
  
  fillDarkGreen();
  rect(rightButtonMargin, startOfButtons + (buttonHeight * 3) + 30, rightButtonWidth, buttonHeight, 10);
  
  fillDarkGreen();
  rect(rightButtonMargin, startOfButtons + (buttonHeight * 4) + 40, rightButtonWidth, buttonHeight, 10);
  
  fillTan();
  textSize(32);
  text("Pizza",325 , startOfButtonText + (buttonHeight * 1) + 10);
  
  fillTan();
  textSize(32);
  text("Reheat",325 , startOfButtonText + (buttonHeight * 2) + 20);
  
  fillTan();
  textSize(32);
  text("Defrost",325 , startOfButtonText + (buttonHeight * 3) + 30);
  
  fillTan();
  textSize(32);
  text("Popcorn",325 , startOfButtonText + (buttonHeight * 4) + 40);
}

public void createStopButton()
{
  fillRed();
  rect(stopButtonMargin, stopButtonStart, stopButtonWidth, stopButtonHeight, 10);

  fillLightTan();
  textSize(48);
  text("STOP", SCREEN_WIDTH / 2, SCREEN_HEIGHT * 0.85);
}

public void fillDarkGreen()
{
  fill(46, 53, 50);
}

public void fillLightGreen()
{
  fill(211, 239, 189);
}

public void fillRed()
{
  fill(175, 62, 77);
}

public void fillTan()
{
  fill(210, 212, 200);
}

public void fillLightTan()
{
  fill(224, 226, 219);
}
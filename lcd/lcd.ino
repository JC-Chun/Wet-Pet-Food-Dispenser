#include <TouchScreen.h>
#include <Adafruit_SPITFT.h>
#include <Adafruit_SPITFT_Macros.h>
#include <gfxfont.h>
#include <Adafruit_GFX.h>         // Core graphics library
#include <Adafruit_ILI9341.h>     // Hardware-specific library
#include <SdFat.h>                // SD card & FAT filesystem library
#include <Adafruit_SPIFlash.h>    // SPI / QSPI flash library
#include <Adafruit_ImageReader.h> // Image-reading functions

//Setting digital input pins on Arduino DUE
//make sure that each pushbutton has a 1k - 10k pullup resistor
int pb1 = 22;
int pb2 = 23;
int pb3 = 24;
int pb4 = 25;
int pb5 = 26;
//variables for reading pushbutton status
int v1 = 0;  
int v2 = 0;
int v3 = 0;
int v4 = 0;
int v5 = 0;
int pbStatus[5];

//used in measure_screen_cup()
int portionSize = 1;  //start with 1 cup
bool measure_screen_cup_bool = true;
int current_cup_size;

bool return_tray = true;

char month_array[12] = {'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', December'};
bool set_month_bool = true;
int set_month = 0;
int current_month;

bool set_day_bool = true;
int set_day = 1;
int current_day = 1;

bool set_year_bool = true;
int set_year = 1;
int current_year = 2020;

bool set_hour_bool = true;
int set_hour = 0;
int current_hour;

bool set_min_bool = true;
int set_min = 1;
int current_min;

bool food_scheduled_bool = true;

bool water_sensor_bool = false;
bool bowl_sensor_bool = false;
bool food_sensor_bool = false;
bool need_food = true;
bool need_water = true;
bool bowl_sensor = false;

void setup() 
{
  //declare pushbuttons as inputs
  pinMode(pb1, INPUT);
  pinMode(pb2, INPUT);
  pinMode(pb3, INPUT);
  pinMode(pb4, INPUT);
  pinMode(pb5, INPUT);

  Serial.begin(9600);
}

//read input from pushbuttons
int* readPB()
{
  v1 = digitalRead(pb1);
  v2 = digitalRead(pb2);
  v3 = digitalRead(pb3);
  v4 = digitalRead(pb4);
  v5 = digitalRead(pb5);

  //array of pushbutton statuses
  int* pbStatus = new int[5];
  pbStatus[0] = v1;
  pbStatus[1] = v2;
  pbStatus[2] = v3;
  pbStatus[3] = v4;
  pbStatus[4] = v5;

  return pbStatus;
}

//Home Screen Page -- has 2 options (for Wi-Fi connection: Feed Now, Clean Bowl)
void homescreen1()
{
  //wait for input
  int* pb = readPB();

  //only observe pushbuttons 2, 3, 4
  //pb[1] = pb2, pb[2] = pb3, pb[3] = pb4;
  
  if (pb[1] == LOW)
  {
    // feed now
    feedNow();
  }
  else if (pb[3] == LOW)
  {
    // clean tray
    cleanBowl();
  }
}

//Home Screen Page -- has 3 options (for Wi-Fi connection: Feed Now, Feed Later, Clean Bowl)
void homescreen2()
{
  //wait for input
  int* pb = readPB();

  //only observe pushbuttons 2, 3, 4
  //pb[1] = pb2, pb[2] = pb3, pb[3] = pb4;
  
  if (pb[1] == LOW)
  {
    // feed now
    feedNow();
  }
  else if (pb[2] == LOW)
  {
    // feed later
    feedLater();
  }
  else if (pb[3] == LOW)
  {
    // clean tray
    cleanBowl();
  }
}

void feedNow()
{
  current_cup_size = measure_screen_cup(portionSize);
  portionSize = current_cup_size;
  measure_screen_cup_bool = true;

  while (need_food)
  {
    display_food_warning_low();   //LCD display
    need_food = check_sensor_food();
  }
  
  while (need_water)
  {
    dispaly_water_warning_low();   //LCD display
    need_water = check_sensor_water();
  }

  //show that food is dispensed
}

int measure_screen_cup(portionSize)
{
  while (measure_screen_cup_bool)
  {
    int* pb = readPB();
  
    //only observe pushbuttons 1, 2, 4, 5
    
    if (pb[0] == LOW)
    {
      measure_screen_cup_bool = false;
      homescreen();
    }
    else if (pb[1] == LOW)
    {
      // decrease measurement by 1/2;
      portionSize -= 0.5;
    }
    else if (pb[3] == LOW)
    {
      portionSize += 1;
    }
    else if (pb[4] == LOW)
    {
      measure_screen_cup_bool = false;
      //continue to next screen -- jump to check sensor function
    }
  }
  return portionSize;
}

void feedLater()
{
  selectDate();
}

void selectDate();
  // display select date screen
  // (month, date and year should be initially BLANK)
  
  int* pb = readPB();
  
  //only observe pushbuttons 1, 2, 3, 4, 5
    
  if (pb[0] == LOW)
  {
    homescreen();
  }
  else if (pb[1] == LOW)
  {
    //jump to Select Month
    current_month = selectMonth(set_month);
    set_month = current_month;
    set_month_bool = true;
  }
  else if (pb[2] == LOW)
  {
    //jump to Select Day
    current_day = selectDay(set_day);
    set_day = current_day;
    set_day_bool = true;
  }
  else if (pb[3] == LOW)
  {
    //jump to Select Year
    current_year = selectYear();
    set_year = current_year;
    set_year_bool = true;
  }
  else if (pb[4] == LOW)
  {
    //jump to Set Time
    selectTime();
  }
}

int selectMonth()
{
  while (set_month_bool)
  {
    int* pb = readPB();
  
    //only observe pushbuttons 1, 2, 4, 5
    
    if (pb[0] == LOW)
    {
      set_month_bool = false;
      setDate();
    }
    else if (pb[1] == LOW)
    {
      // decrease Month;
      if (set_month > 0 && set_month <= 12)
      {
        set_month -= 1;
      }
    }
    else if (pb[3] == LOW)
    {
      // increase Month;
      if (set_month != 12 && set_month >= 0)
      {
        set_month += 1;
      }
    }
    else if (pb[4] == LOW)
    {
      set_month_bool = false;
      //continue to next screen -- jump to select date screen, displaying set_month
    }
  }
  return set_month;
}

int selectDay()
{
  while (set_day_bool)
  {
    int* pb = readPB();
  
    //only observe pushbuttons 1, 2, 4, 5
    
    if (pb[0] == LOW)
    {
      set_month_bool = false;
      selectDate();
    }
    else if (pb[1] == LOW)
    {
      // decrease day
      if (set_day != 1 && set_day <= 31)
      {
        set_day -= 1;
      }
    }
    else if (pb[3] == LOW)
    {
      // increase day;
      if (set_day != 31 && set_day >= 0)
      {
        set_day += 1;
      }
    }
    else if (pb[4] == LOW)
    {
      set_day_bool = false;
      //continue to next screen -- jump to select date screen, displaying set_day
    }
  }
  return set_day;
}

int selectYear()
{
  while (set_year_bool)
  {
    int* pb = readPB();
  
    //only observe pushbuttons 1, 2, 4, 5
    
    if (pb[0] == LOW)
    {
      set_year_bool = false;
      selectDate();
    }
    else if (pb[1] == LOW)
    {
      // decrease year
      if (set_year >= 2020)
      {
        set_day -= 1;
      }
    }
    else if (pb[3] == LOW)
    {
      // increase year
      set_year += 1;
    }
    else if (pb[4] == LOW)
    {
      set_year_bool = false;
      //continue to next screen -- jump to select date screen, displaying set_year
    }
  }
  return set_year;
}

void selectTime()
{
  // display setTime screen
  
  int* pb = readPB();
  
  //only observe pushbuttons 1, 2, 4, 5
    
  if (pb[0] == LOW)
  {
    //go back to Select Date Display
    selectDate();
  }
  else if (pb[1] == LOW)
  {
    //jump to Select hour
    current_hour = selectHour(set_hour);
    set_hour = current_hour;
    set_hour_bool = true;
  }
  else if (pb[3] == LOW)
  {
    //jump to Select Minute
    current_min = selectMinute(set_min);
    set_min = current_min;
    set_min_bool = true;
  }
  else if (pb[4] == LOW)
  {
    //jump to measure food
    current_cup_size = measure_screen_cup(portionSize);
    portionSize = current_cup_size;
    measure_screen_cup_bool = true;
    display_food_scheduled();
  }
}

int selectHour()
{
  while (set_hour_bool)
  {
    int* pb = readPB();
  
    //only observe pushbuttons 1, 2, 4, 5
    
    if (pb[0] == LOW)
    {
      set_hour_bool = false;
      selectTime();
    }
    else if (pb[1] == LOW)
    {
      // decrease hour
      if (set_hour > 0 && set_hour <= 24)
      {
        set_hour -= 1;
      }
    }
    else if (pb[3] == LOW)
    {
      // increase hour
      if (set_hour >= 0 && set_hour < 24)
      {
        set_hour += 1;
      }
    }
    else if (pb[4] == LOW)
    {
      set_hour_bool = false;
      //continue to next screen -- jump to select time screen, displaying set_hour
    }
  }
  return set_hour;
}

int selectMinute()
{
  while (set_min_bool)
  {
    int* pb = readPB();
  
    //only observe pushbuttons 1, 2, 4, 5
    
    if (pb[0] == LOW)
    {
      set_min_bool = false;
      selectTime();
    }
    else if (pb[1] == LOW)
    {
      // decrease minute
      if (set_min > 0 && set_min <= 60)
      {
        set_min -= 1;
      }
    }
    else if (pb[3] == LOW)
    {
      // increase minute
      if (set_min >= 0 && set_min < 60)
      {
        set_min += 1;
      }
    }
    else if (pb[4] == LOW)
    {
      set_min_bool = false;
      //continue to next screen -- jump to select time screen, displaying set_min
    }
  }
  return set_min;
}

void cleanBowl()
{
  //warning, tray is extracted...
  //swing open tray using motor or servo
  //also uses weight sensor to ensure that the bowl is there
  
  int* pb = readPB();
  
  //only observe pushbuttons 1 and 5
  
  if (pb[0] == LOW)
  {
    homescreen();
  }
  else if (pb[4] == LOW)
  {
    //continue -- jump to "return tray" page
    returnTray();
  }
}

void returnTray()
{
  while(return_tray)
  {
    int* pb = readPB();
    bowl_sensor = check_bowl_sensor();
    if (pb[2] == LOW && bowl_sensor == true)
    {
      return_tray = false;
      //retract tray -- reverse motor direction to close tray
      homescreen();
    }
  }
}

void display_food_scheduled()
{
  while (food_scheduled_bool)
  {
    int* pb = readPB();
  
    if (pb[2] == LOW)
    {
      food_scheduled_bool = false;
      homescreen();
    }
  }
}

bool check_water_sensor()
{
  //use weight sensor
  if weight < water_weight
  {
    water_sensor_bool = true;
  }
  return water_sensor_bool;
}

bool check_bowl_sensor()
{
  //use weight sensor
  if weight < bowl_weight
  {
    bowl_sensor_bool = true;
  }
  return bowl_sensor_bool;
}

bool check_food_sensor()
{
  //use ultrasonic distance sensor 
  if distance < storage_distance
  {
    food_sensor_bool = true;
  }
  return food_sensor_bool;
}

void loop()
{
  int* pb = readPB();
  for (int i = 0; i < 5; i++)
  {
    Serial.println();
    Serial.println(pb[i]);
  }
  delay(5000);
}

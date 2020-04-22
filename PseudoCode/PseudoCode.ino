#include "lcd"
// Initial Boot - ON

// main loop
int main()
{
  checkWifi = checkWifi();
  if checkWifi == TRUE
    // (LCD) Display homescreen with 2 options (Feed Now, Clean Bowl)
    // **User should only be allowed to schedule/change feedings from the phone
    // **make sure that pushbutton 3 is an invalid input (since Feed Later is not an option)
    homescreen1();
    if (Feed Now)
      feedNow();
      // start feeding mechanism! 
    if (Clean Bowl)
      cleanBowl();
  if checkWifi == FALSE
    // (LCD) Display homescreen with 3 options (Feed Now, Feed Later, Clean Bowl)
    homescreen2();    
    if (Feed Now)
      feedNow();
      // Start feeding mechanism! 
    else if (Feed Later)
      feedLater();
    else if (cleanBowl)
      cleanBowl();  
}

//Check Wi-Fi
bool checkWifi()
{
  // Use ESP to see if a connection is established on the device
  // if NO Wi-Fi
    // return FALSE
  // else
    // return TRUE
}

void feedNow()
{
  // Select Portion Size
  // (LCD) Display "Please select portion size" 
  // cups_nuggets = ...
  
  // Check Sensors for Food and Water Storage
  while (check_food_storage)
  {
    check_food_storage = check_food_sensor();
    if (check_food_storage == true)
    {
      // not enough grounded nuggets are available for dispensing
      // (LCD) Display "Warning! Food Level Low" 
      // continuously check food storage sensor
    }
  }
  // check_food_storage == false
  // wait for user to hit pushbutton 5 (continue) 

  while (check_water)
  {
    check_water = check_water_sensor();
    if (check_water == true)
    {
      // not enough water in water storage unit
      // (LCD) Display "Warning! Water Level Low"
    }
  }
  // check_food_storage == false
  // wait for user to hit pushbutton 5 (continue) 

  // Check lock for loading food to activate grinding
  while (lock)
  {
    lock = checkLock();
    if (lock == true)
    {
      // sensor does not detect a lock
      // continuously check sensor
    }
  }
  // else sensor detects lock
  // READY TO GRIND
  grindNuggets(); //Grinder will stop once it checks sensors and sees that there are no more nuggets going through the grinder

  if (set_time == RTC_time)
  {
    dispenseMeasure(cups_nuggets);
    // wait to soak --> depends on ratio of nuggets dispensed
    // (LCD) display "Food Dispensed" 
    releaseBowl();
  }

  // loop back to home screen 
}

void feedLater()
{
  // **Check to see if user has a set schedule
  if (THERE IS A SET SCHEDULE)
    // **Allow the user to change the schedule
    // (LCD) Display list of feeding schedule
    // Select one of the feedings --> Follow LCD Flow for Select Date (see lcd code)
  else if (THERE IS NO SET SCHEDULE)
    // **Allow the user to create a schedule
    // (LCD) Display screen with 'Select Date'
    // **Follow LCD Flow for Select Date (see lcd code)
}

void cleanBowl()
{
  // (LCD) Display screen that says "Warning! Tray is Extracted..."
  // **Follow LCD Flow for cleanBowl (see lcd code)
  // release bowl tray
  releaseBowl();
  // call checkWifi to return to homescreen
  checkWifi();
}

bool check_food_sensor()
{
  // use HR-SC04 distance sensor (2, on bottom) to check if minimum amount of nuggets are available for dispensing
  // write an algorithm to check whether a nugget is in front of the sensor or not. 
  // suggestion: set up a range for the sensor within the storage unit, (i.e., check within dimensions of storage) 
  if (distance < min_storage || distance > max_storages)
  {
    food_sensor_bool = true;
  }
  return food_sensor_bool;
}

bool check_water_sensor()
{
  // use weight sensor
  if weight < water_weight
  {
    water_sensor_bool = true;
  }
  return water_sensor_bool;
}

bool check_grinder_sensor()
{
  // use HR-SC04 distance sensor (1, on top) to check if nuggets are still going through the grinder
  // write an algorithm to check whether a nugget is in front of the sensor or not. 
  // suggestion: set up a range for the sensor within the storage unit, (i.e., check within dimensions of storage) 
  if (distance < min_storage || distance > max_storages)
  {
    food_sensor_bool = true;
  }
  return food_sensor_bool;
}

bool check_bowl_sensor()
{
  // use weight sensor to detect whether the bowl is present or if there is still food in the bowl
  // WRITE CODE to read data from weight sensors
  weight = //
  if weight < bowl_weight || weight > bowl_weight 
  {
    bowl_sensor_bool = true;
  }
  return bowl_sensor_bool;
}

bool checkLock()
{
  // select a sensor to install under lock of loading bin lid
  // return a boolean to check if the sensor detects a lock or not
}

void grindNuggets()
{
  // Turn on DC motors to grind 
  // use HR-SC04 distance sensor (1, on top) to check if nuggets are still going through the grinder
  while (nuggetGrind == true)
  {
    // if while (nuggetGrind == false)
    // turn off grinders -- hop out of while loop 
  } 
}

void dispenseMeasure()
{
  // activate stepper motor 1 to dispense nuggets
  // wait for a couple of seconds
  // dispense water with water pump
}

void releaseBowl()
{
  // activate stepper motor 2 
  // wait
  // call check_bowl_sensor() to detect bowl presence in tray
  while (check_bowl)
  {
    check_bowl = check_bowl_sensor();
    if (check_bowl == true)
    {
      // the bowl is not present OR the pet is still eating
      // do nothing, keep the tray out
      // wait()
      // continuously check_bowl_sensor()
    }
    else 
    {
      // the bowl is IN the tray
      // MAKE SURE THE (LCD) "Press Okay to Return Tray" is ON THE SCREEN
      // user will press pushbutton 3 (OKAY)
      // activate stepper motor 2 to retract tray
    }
  }
}




  

#include <TouchScreen.h>
#include <Adafruit_SPITFT.h>
#include <Adafruit_SPITFT_Macros.h>
#include <gfxfont.h>
#include <Adafruit_GFX.h>         // Core graphics library
#include <Adafruit_ILI9341.h>     // Hardware-specific library
#include <SdFat.h>                // SD card & FAT filesystem library
#include <Adafruit_SPIFlash.h>    // SPI / QSPI flash library
#include <Adafruit_ImageReader.h> // Image-reading functions


home_screen function
  wait for input
  If push_button_1 //blank
    do nothing 
  If push_button_2 //feed now
    display measure_screen_1cup
    measure_screen function
      wait for input
      if pushbutton_1 //back
        display home_image
        go to home_function //home screen
      if pushbutton_2 //minus
        display to measure_screen_halfcup
        wait for input
        if pushbutton_1 //back
          return to home_function
        if pushbutton_2 or pushbutton_3 //minus and blank buttons
          do nothing //cant go lower than 1/2 cup right now
        if pushbuton_4 //plus
          display measure_screen_1cup
          loop back to measure_screen function
        if pushbutton_5//continue
          jump out to check sensor function
      if pushbutton_3 //blank
        do nothing
      if pushbutton_4 //plus
        display measure_screen_2cups
        wait for input
        if pushbutton_1 //back
          display home_image
          return to home_screen function //homescreen
        if pushbutton_2 //minus
          display measure_screen_1cup
          loop back to measure_screen function
        if pushbutton_3 or pushbuton_4 //blank and plus
          do nothing //for right now dont cant do more than 2 cups
        if pushbutton_5
          jump out to check weight sensor function
      if pushbutton_5 //feed
        go to weight sensor function
        if display message is low water or low food
          wait for input
          if pushbuttom 5 //continue
            return to check sensor
          if push button 1 //back
            display measure_screen_1cup
            return to measure_screen function
        else
          display image_dispensed_food
          dispense and measure
          wait for pushbutton_3 
          display home_image
          go to home_screen function
   
      
        
  If push_button_3 //feed later
    display select_date_image
    if pushbutton_1 //back
      display home_image
      go to home_screen function
    if pushbutton_2 //month
      display selct_month_screen
      go to select_month function
    if pushbutton_3 //day
      display selct_day_screen
      go to select_day function
    if pushbutton_4 //year
      display selct_year_screen
      go to select_year function
    if pushbutton_5 //contiune
      display select_time_image
      go to select_time fuction
      display measure_screen_1cup
      go to measure_screen function
      **need help figuring out how to write the food scheduled screen at the end instead
      should I make an if statement at the end of Measure_screen function?**
    
  If push_button_4
    display open_tray image
    extract bowl function
    wait for input
      if pushbutton_1
        check weight sensor function
        if "bowl in"
          retract bowl
          display home_image
        if "bowl missing"
          display open_tray image
          loop back to extract bowl function
      if pushbutton_5
        display press_okay_to_return image
        wait for push button 3
          retract bowl
        display home_image
        go to home_screen image
      else
        do nothing
  If push_button_5
    do nothing


weight sensor{
check water sensor
  if weight << ____
    display image_low_water
  end
check food sensor
  if ??? << ____
    display image_low_food
  end
}




weight bowl sensor{
check bowl sensor
  if weight << bowl_weight
    display warning_image
    return "bowl missing"
  if weight >= bowl_weight
    return "bowl in"
}

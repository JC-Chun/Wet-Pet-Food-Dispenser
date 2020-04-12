// Date and time functions using a PCF8523 RTC connected via I2C and Wire lib
#include <Stepper.h>
#include "RTClib.h"

RTC_PCF8523 rtc;

char daysOfTheWeek[7][12] = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"};

int led = 13; //digital pin for LED

// STEPPER SET UP -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

// Define step constants
#define FULLSTEP 4
#define HALFSTEP 8
#define STEPS 100

// Number of steps per internal motor revolution 
const float STEPS_PER_REV = 100; 
//  Amount of Gear Reduction
const float GEAR_RED = 64;
// Number of steps per geared output rotation
const float STEPS_PER_OUT_REV = STEPS_PER_REV * GEAR_RED;
// Number of Steps Required
int StepsRequired;
//-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

void setup () {
  pinMode(led, OUTPUT);  //declare the LED as an output
  
  while (!Serial) {
    delay(1);  // for Leonardo/Micro/Zero
  }

  Serial.begin(57600);
  if (! rtc.begin()) {
    Serial.println("Couldn't find RTC");
    while (1);
  }

// Set's the clock to the computer's time
// ONLY need to set it ONCE
  if (! rtc.initialized()) {
    Serial.println("RTC is NOT running!");
    // following line sets the RTC to the date & time this sketch was compiled: 
    // rtc.adjust(DateTime(F(__DATE__), F(__TIME__)));
  }
}

void loop () {
    DateTime now = rtc.now();
    Serial.print(now.year(), DEC);
    Serial.print('/');
    Serial.print(now.month(), DEC);
    Serial.print('/');
    Serial.print(now.day(), DEC);
    Serial.print(" (");
    Serial.print(daysOfTheWeek[now.dayOfTheWeek()]);
    Serial.print(") ");
    Serial.print(now.dayOfTheWeek(), DEC);
    Serial.print(") ");
    Serial.print(now.hour(), DEC);
    Serial.print(':');
    Serial.print(now.minute(), DEC);
    Serial.print(':');
    Serial.print(now.second(), DEC);
    Serial.println();

    if (now.hour() == 16 && now.minute() > 30 && now.second() > 0 && now.second() < 30)
    {
      digitalWrite(led, HIGH); // Turn the LED on
    }
    
    else 
    {
      digitalWrite(led, LOW);
    }

    Serial.println();
    delay(3000);
}

#include Stepper.h
#include "RTClib.h"

// STEPPER MOTOR SET UP

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

// Create Instance of Stepper Class
// Specify Pins used for motor coils
// Connected to ULN2003 Motor Driver In1, In2, In3, In4 
// Pins entered in sequence 1-3-2-4 for proper step sequencing
Stepper stepper1(STEPS_PER_REV, 4, 6, 5, 7);    //IN1, IN3, IN2, IN4
Stepper stepper2(STEPS_PER_REV, 2, 11, 3, 12);  //IN1, IN3, IN2, IN4

//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

// CLOCK INTITIALIZATION
RTC_PCF8523 rtc;

//initialize LEDs to Digital Pins
int RedLed1 = 13;

void setup() 
{
  //declare LEDs as an output
  pinMode(RedLed1, OUTPUT)
  
  //set speed (in rpm)
  stepper1.setSpeed(100);  
  stepper2.setSpeed(100);  
  delay(2000);
}

int checkSensors(void)
{
  while (1)
  {
    digitalWrite(RedLed1, HIGH) 
  }
  return distance;
}

void runGrinder(void)
{  
  while (1)
  {
    stepper1.step(STEPS_PER_REV);
    stepper2.step(STEPS_PER_REV);
  }
  
  int nugget = checkSensors();

  if (nugget <= rangeLoad)
  {
    //stop grinder
  }
}

void loop() {
  // put your main code here, to run repeatedly:

}

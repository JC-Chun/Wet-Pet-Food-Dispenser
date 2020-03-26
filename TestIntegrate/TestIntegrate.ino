#include Stepper.h

//initialize LEDs to Digital Pins
int RedLed1 = 13;
int GreenLed2 = 14;
int RedLed3 = 15;
int GreenLed4 = 16;

void setup() 
{
  //declare LEDs as an output
  pinMode(RedLed1, OUTPUT)
  pinMode(GreenLed2, OUTPUT)
  pinMode(RedLed3, OUTPUT)
  pinMode(GreenLed4, OUTPUT)
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
  int nugget = checkSensors();
  while (1)
  {
    //turn on Green LED 2
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

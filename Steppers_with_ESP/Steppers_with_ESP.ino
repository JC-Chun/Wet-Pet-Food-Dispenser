#include <Stepper.h>
#include <AccelStepper.h>
#include <SoftwareSerial.h>

SoftwareSerial mySerial(2,3); // RX, TX

// Define step constants
#define FULLSTEP 4
#define HALFSTEP 8
 
// Number of steps per internal motor revolution 
const float STEPS_PER_REV = 32; 
//  Amount of Gear Reduction
const float GEAR_RED = 64;
// Number of steps per geared output rotation
const float STEPS_PER_OUT_REV = STEPS_PER_REV * GEAR_RED;
// Number of Steps Required
int StepsRequired;
 
// Create Instance of Stepper Class
// Specify Pins used for motor coils
// The pins used are 2,3,4,5 for stepper1
// Connected to ULN2003 Motor Driver In1, In2, In3, In4 
// Pins entered in sequence 1-3-2-4 for proper step sequencing
Stepper stepper1(STEPS_PER_REV, 4, 6, 5, 7);
Stepper stepper2(STEPS_PER_REV, 9, 11, 10, 12);
 
void setup()
{
  Serial.begin(9600);
  mySerial.begin(9600);
  delay(2000);
  
  // Nothing is needed for steppers (Stepper Library sets pins as outputs)
}

void loop()
{
  
  String incomingTurn = "";
  bool incomingData = false;

  while (mySerial.available()){
    incomingTurn = mySerial.readString();
    incomingData = true;
  }
  
  if (incomingData) { 
    //String portion = Serial.read(); // 1 portion = 1/4 turn = 1/8 cup 
    Serial.println("Portion: " + incomingTurn);


    StepsRequired  =  - STEPS_PER_OUT_REV / 4;  
    for (int i = 0; i <= incomingTurn.toInt(); i++){
      // Rotate CCW 1/4 turn 
      stepper1.setSpeed(400);  
      stepper1.step(StepsRequired);

      stepper2.setSpeed(1000);  
      stepper2.step(StepsRequired*4);
      delay(5000);
    }
//    stepper1.setSpeed(0);
  }else{
    Serial.println("No data");
  }
  

  //Stepper2 Changes direction at the limits

}

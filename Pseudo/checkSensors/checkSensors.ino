#include "HCSR04.h"

//uses HC-SR04 - https://github.com/Martinsos/arduino-lib-hc-sr04

// Initialize sensor that uses digital pins 52 and 53.
int triggerPin = 52;
int echoPin = 53;
UltraSonicDistanceSensor distanceSensor(triggerPin, echoPin);

void setup () {
  Serial.begin(9600);  // We initialize serial connection so that we could print values from sensor.
}

void loop () {
  // Every 500 miliseconds, do a measurement using the sensor and print the distance in centimeters.
  double distance = distanceSensor.measureDistanceCm();
  Serial.println(distance);
  Serial.println("hello");
  delay(500);
}

//Check Sensor
  //If sensor detects food
    //return 1
  //else
    //return 0

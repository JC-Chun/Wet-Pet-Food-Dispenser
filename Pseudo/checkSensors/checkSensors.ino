//#include "HCSR04.h"
//
////uses HC-SR04 - https://github.com/Martinsos/arduino-lib-hc-sr04
//
//// Initialize sensor that uses digital pins 52 and 53.
//int tP = 52;
//int eP = 53;
//UltraSonicDistanceSensor distanceSensor(tP, eP);
//
//void setup () {
//  Serial.begin(9600);  // We initialize serial connection so that we could print values from sensor.
//}
//
//void loop () {
//  // Every 500 miliseconds, do a measurement using the sensor and print the distance in centimeters.
//  double distance = distanceSensor.measureDistanceCm();
//  Serial.println(distance);
//  //Serial.println("hello");
//  //delay(500);
//}

//Check Sensor
  //If sensor detects food
    //return 1
  //else
    //return 0

const int trigPin = 52;
const int echoPin = 53;

float duration, distance;

void setup() {
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
  Serial.begin(9600);
}

void loop() {
  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);

  duration = pulseIn(echoPin, HIGH);
  distance = (duration*.0343)/2;
  Serial.print("Distance: ");
  Serial.println(distance);
  delay(100);
}

//This program checks to make sure that the HC-SR04 ultrasonic distance sensor is able to measure objects properly. 
//Range: 2cm - 400cm
//Operates at 5V DC
//Operates at a current of 15mA
//Code returns a value in centimeters. 

const int trigPin = 9;
const int echoPin = 10;

float duration, distance;

void setup() {
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
  Serial.begin(9600);       // initialize serial connection so that we could print values from sensor.
}

void loop() {
  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);

  duration = pulseIn(echoPin, HIGH);
  distance = (duration*.0343)/2;    //converts to distance in cm
  Serial.print("Distance: ");
  Serial.println(distance);
  delay(1000);      //Every 1 second, do a measurement using the sensor and print the distance in centimeters.
}

//Check Sensor
  //If sensor detects food
    //return 1
  //else
    //return 0

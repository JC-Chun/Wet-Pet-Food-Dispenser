void setup() {
  // put your setup code here, to run once:

}

void loop() {
  // put your main code here, to run repeatedly:

}

////Initial Boot - ON

//Check Wi-Fi
//If NO Wi-Fi AND NO set schedule
  //create a schedule (LCD)

//else if NO Wi-Fi and SET Schedule
  //change schedule

//else
  //follow schedule
    //check sensors...

//Cleaning Bowl
  //release bowl
  
//If user wants to FEED NOW
  //Check Sensors for food storage
    //call sensor function to read food storage sensor
      //if sensor returns a 1
        //go to dispense and measure

      //else
        //tell user to put more food in (on LCD)

//Display message to Load
//Check lock
  //if locked
    //grind
    //break;
  //else
    //display message to lock
    //loop until user closes lid

//grind
  //turn motors on
  //check for more nuggets
    //if nuggets are loading
      //continue grinding
    //else
      //stop grinding (stop motors)
      //go to wait for input

//Dispense and Measure
  //if input
    //turn motors and dispense water indicated
    //wait to soak
  //else
    //check for input

//Wait to soak 
  //delay (depending on amount of food)

  //release bowl

//release bowl
  //motor turns bowl out

  //wait(2 min)         //future: indicate how long it takes for dog to eat food to 
  //check weight of bowl

//check weight of bowl
  //if weight < bowl OR weight > bowl
    //wait
    //check again

  //else
    //retract

  

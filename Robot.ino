#include <DynamixelSerial1.h> 
#define FREQ 1000000

int Temperature, Voltage, Position;  

const byte numChars = 32; 
char receivedChars[numChars]; 
char tempChars[numChars];        // temporary array for use when parsing 


// variables to hold the parsed data 
int theta1 = 0; 
int theta2 = 0; 
int theta3 = 0; 
int th1 = 0; 
int th2 = 0; 
int th3 = 0; 

boolean newData = false; 

//============ 
void setup() { 
    Serial.begin(9600); 
    Serial.println("This program expects 3 integers."); 
    Serial.println("Enter data in this style <100, 200, 300> for <theta1, theta2, theta3>"); 
    Serial.println(); 
    pinMode(LED_BUILTIN, OUTPUT); //To make the arduino led blink 

    Dynamixel.begin(FREQ,2);
    Dynamixel.ledStatus(1,ON);
    Dynamixel.ledStatus(2,ON);
    Dynamixel.ledStatus(3,ON);
} 

//============ 
void loop() { 
    recvWithStartEndMarkers(); 
    if (newData == true) { 
        strcpy(tempChars, receivedChars); 
            // this temporary copy is necessary to protect the original data 
            //   because strtok() used in parseData() replaces the commas with \0 
        parseData(); 
        showParsedData(); 
        newData = false;

        // Get anfles and map to 0 to 1023
        th1 = int(map(theta1,0,300,0,1023));
        th2 = int(map(theta2,0,300,0,1023));
        th3 = int(map(theta3,0,300,0,1023));

        Dynamixel.move(1,th3);
        Dynamixel.move(2,th2);
        Dynamixel.move(3,th1);
    }
}
//============ 
void recvWithStartEndMarkers() { 
    static boolean recvInProgress = false; 
    static byte ndx = 0; 
    char startMarker = '<'; 
    char endMarker = '>'; 
    char rc; 

    while (Serial.available() > 0 && newData == false) { 
        rc = Serial.read(); 
        if (recvInProgress == true) { 
            if (rc != endMarker) { 
                receivedChars[ndx] = rc; 
                ndx++; 
                if (ndx >= numChars) { 
                    ndx = numChars - 1; 
                } 
            }
            else { 
                receivedChars[ndx] = '\0'; // terminate the string 
                recvInProgress = false; 
                ndx = 0; 
                newData = true; 
            } 
        } 
        else if (rc == startMarker) { 
            recvInProgress = true; 
        } 
    }
} 

//============ 
void parseData() {      // split the data into its parts 
    char * strtokIndx; // this is used by strtok() as an index 
    strtokIndx = strtok(tempChars,",");      // get the first part - theta1 as integer 
    theta1 = atoi(strtokIndx);  // copy it to the theta1 variable 
    strtokIndx = strtok(NULL, ","); // this continues where the previous call left off 
    theta2 = atoi(strtokIndx);     // convert this part to theta2 intege
    strtokIndx = strtok(NULL, ","); 
    theta3 = atoi(strtokIndx);     // convert this part to theta3
} 

//============ 
void showParsedData() { 
    Serial.print("theta1: "); 
    Serial.println(theta1); 
    Serial.print("theta2: "); 
    Serial.println(theta2); 
    Serial.print("theta3: "); 
    Serial.println(theta3); 
} 

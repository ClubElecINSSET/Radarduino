// Copyright (C) 2022 Club Électronique INSSET
// Copyright (C) 2022, 2019 Gaëtan LE HEURT-FINOT
// This file is part of Radarduino <https://github.com/ClubElecINSSET/Radarduino>.
// 
// Radarduino is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// Radarduino is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
// 
// You should have received a copy of the GNU General Public License
// along with Radarduino.  If not, see <http://www.gnu.org/licenses/>.

#include <SRF05.h>
#include <Servo.h>

int trig = 7;
int echo = 6;
int servo = 9;

int pos = 0;
int moveset = 2;
int keysend = 0;
int key = 0;
int lastPos = 0;

SRF05 SRF(trig, echo);
Servo myservo;

void setup() {
  Serial.begin(9600);
  myservo.attach(9);
}

void loop() {
    for (pos = 0; pos <= 180; pos += 1) {
      sendDataSerial();
      myservo.write(pos);
      delay(25);
    }
    for (pos = 180; pos >= 0; pos -= 1) {          
      sendDataSerial();
      myservo.write(pos);
      delay(25);      
    }
}

void sendDataSerial() {
  int distance = SRF.getCentimeter();
  if (distance == 0 || distance > 400) {
    distance = lastPos;
  } else {
    lastPos = distance;
  }
  String text = "-";
  String serialsend = distance + text + pos;
  Serial.println(serialsend);
}

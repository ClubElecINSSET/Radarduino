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

import processing.serial.*;
Serial fromserial;

void settings() {
    size(1600, 800);
}

void setup() {
    background(0);
    fromserial = new Serial(this, "/dev/ttyUSB0", 9600);
}

void draw() {
    fromserial.bufferUntil('\n');
    String serialdata = fromserial.readStringUntil('\n');
    serialdata = trim(serialdata);
    if (serialdata != null) {
        int serial[] = int(split(serialdata, '-'));
        if (serial.length == 2) {
            int pos = serial[1];
            float angle = radians(pos);
            int distance = parseInt(serial[0]);
            if (pos == 0 || pos == 180) {
                background(0);
            }
            rect(0, 0, 240, 31);
            fill(0);
            textSize(25);
            text(" Distance: " + distance + " cm", 4, 22);
            int R = 255 - distance;
            int G = 0 + distance;
            int B = 0;
            strokeWeight(3);
            fill(R, G, B);
            distance = distance * 2;
            float X = 800 + distance * cos(angle);
            float Y = 800 - distance * sin(angle);
            line(800, 800, X, Y);
            stroke(R, G, B);
        }
    }
}

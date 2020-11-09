#include <ArduinoRS485.h>
#include <ArduinoModbus.h>

const byte slaveId = 1;
const byte coilIdOffset = 0x00;
const byte coilCount = 8;
const byte relayPins[coilCount] = {A0, A1, A2, A3, A4, A5, 10, 11};
const int txPin = 1;
const int dePin = -1;
const int rePin = -1;
const unsigned long baudrate = 9600;
const byte relayOffLevel = HIGH;
const byte relayOnLevel = LOW;

void setup() {
  Serial.begin(baudrate);
  Serial.println("Modbus RTU Server");

  /* Set Modbus pins: */
  RS485.setPins(txPin, dePin, rePin);

  /* Start Modbus server: */
  if (!ModbusRTUServer.begin(slaveId, baudrate)) {
    Serial.println("Failed to start Modbus RTU Server!");
    while (1);
  }

  /* Configure relay pins (inverted!): */
  for (byte i=0; i < coilCount; i++) {
    pinMode(relayPins[i], OUTPUT);
    digitalWrite(relayPins[i], relayOffLevel);
  }

  /* Configure coils: */
  ModbusRTUServer.configureCoils(coilIdOffset, coilCount);
}

void loop() {
  /* Poll for Modbus RTU requests: */
  ModbusRTUServer.poll();

  for (byte i=0; i < coilCount; i++) {
    /* Read the current value of the coil: */
    int coilValue = ModbusRTUServer.coilRead(coilIdOffset + i);

    /* Set relay accordingly (inverted!): */
    if (coilValue) {
      digitalWrite(relayPins[i], relayOnLevel);
    } else {
      digitalWrite(relayPins[i], relayOffLevel);
    }
  }

  /* TODO: Drive status LEDs. */
  /* TODO: Add pushbuttons? */
}

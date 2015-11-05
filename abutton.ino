#include <Arduino.h>

#include <ESP8266WiFi.h>
#include <WiFiClient.h>
#include <ESP8266WebServer.h>

const char *ssid = "AButton";

ESP8266WebServer server(80);

void setup() {
  Serial.begin(115200);

  initWiFi();
}

void loop() {
  server.handleClient();
}

void initWiFi() {
  Serial.println();
  Serial.println();
  Serial.println("Startup");


  WiFi.mode(WIFI_AP);
  WiFi.softAP(ssid);
  WiFi.begin(ssid); // not sure if need but works
  Serial.print("Access point started with name ");
  Serial.println(ssid);

  server.on("/", handleConfig);
}

void handleConfig() {
}


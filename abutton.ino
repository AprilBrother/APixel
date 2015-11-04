#include <ESP8266WiFi.h>
#include <WiFiClient.h>
#include <ESP8266WebServer.h>

const char *ssid = "AButton";

void setup() {
  Serial.begin(115200);

  initWiFi();
}

void loop() {
  // put your main code here, to run repeatedly:

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
  //launchWeb(2);
}

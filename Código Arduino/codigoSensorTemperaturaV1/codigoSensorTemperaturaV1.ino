// Começo do bloco de declaração de variávies
const int PINO_SENSOR_TEMPERATURA = A0;
float temperaturaCelsius;
float temperatura;
// Término do bloco

// Começo do bloco de configuração de transmissão de dados entre computador e arduino.
void setup() {
Serial.begin(9600);
}
// Término do bloco


// Começo do bloco de execução de captura dos dados e execução de cálculos 
void loop() {
int valorLeitura = analogRead(PINO_SENSOR_TEMPERATURA);

temperatura = (valorLeitura * 0.00488);
temperatura = temperatura * 100;
temperatura = temperatura + 10;

Serial.print("TempMaxima:");
Serial.print(36);
Serial.print(" ");
Serial.print("Temperatura:");
Serial.print(temperatura);
Serial.print(" ");
Serial.print("TempMinima:");
Serial.println(31);

delay(2000);
}
// Término do bloco
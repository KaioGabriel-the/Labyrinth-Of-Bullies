/*
  Esplora Rainbow Effect

  Creates a rainbow effect with highlights on all primary colors and switches to white with increasing slider value.

  Created on 07 June 2024
  By OpenAI Assistant
*/
#include <Esplora.h>

unsigned long previousMillis = 0;
const long interval = 100;  // Intervalo de tempo em milissegundos para alterar a cor

void setup() {
  // Inicialize a comunicação serial:
  Serial.begin(9600);
}

void loop() {
  // Lê os sensores nas variáveis:
  int slider = Esplora.readSlider();

  unsigned long currentMillis = millis();  // Obtém o tempo atual em milissegundos

  // Calcula as intensidades das cores do arco-íris
  static byte red = 0;
  static byte green = 0;
  static byte blue = 0;

  // Verifica se é hora de mudar a cor
  if (currentMillis - previousMillis >= interval) {
    previousMillis = currentMillis;  // Atualiza o tempo de referência

    // Atualiza as cores do arco-íris
    static int rainbowColor = 0;
    rainbowColor += 10;  // Velocidade de mudança da cor

    // Calcula as intensidades das cores do arco-íris
    if (rainbowColor < 256) {
      // Vermelho a Amarelo
      red = 255;
      green = rainbowColor;
      blue = 0;
    } else if (rainbowColor < 512) {
      // Amarelo a Verde
      red = 255 - (rainbowColor - 256);
      green = 255;
      blue = 0;
    } else {
      // Verde a Azul
      red = 0;
      green = 255;
      blue = rainbowColor - 512;
    }
  }

  // Altera para branco quando o slider aumenta
  if (slider >= 512) {
    red = 255;
    green = 255;
    blue = 255;
  }

  // Define a cor no LED
  Esplora.writeRGB(red / 5, green / 5, blue / 5);

  // Impressão serial do valor do slider
  int mappedSlider = map(slider, 0, 1023, 0, 100);
  mappedSlider = 100 - mappedSlider;
  Serial.print("sv");
  Serial.print(":");
  Serial.print(mappedSlider);
  Serial.print("#");

  // Lê o eixo do joystick
  int xAxisInt = Esplora.readJoystickX();
  float xAxis = (map(xAxisInt, -512, 512, -100, 100) / 100.0) * -1;
  int yAxisInt = Esplora.readJoystickY();
  float yAxis = (map(yAxisInt, -512, 512, -100, 100) / 100.0);

  float deadzone = 0.10;
  if (abs(xAxis) < deadzone) {
    xAxis = 0.0;
  }
  if (abs(yAxis) < deadzone) {
    yAxis = 0.0;
  }

  Serial.print("ax");
  Serial.print(":");
  Serial.print(xAxis);
  Serial.print("#");
  Serial.print("ay");
  Serial.print(":");
  Serial.print(yAxis);
  Serial.print("#");
  

  int buttonDown = Esplora.readButton(SWITCH_1);
  int buttonLeft = Esplora.readButton(SWITCH_2);

  Serial.print("bd");
  Serial.print(":");
  Serial.print(buttonDown);
  Serial.print("bl");
  Serial.print(":");
  Serial.print(buttonLeft);
  
  // Caractere de quebra de linha
  Serial.print("]");

  // Adiciona um atraso para evitar que o LED pisque:
  delay(10);
}

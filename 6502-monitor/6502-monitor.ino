const char ADDR[] = {22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 52};
const char DATA[] = {39, 41, 43, 45, 47, 49, 51, 53};
#define CLOCK 2
#define READ_WRITE 3

bool print = false;
volatile unsigned long pulses = 0;
unsigned long lastTime = 0;
unsigned long clockSpeed = 0;

void setup() {
  for (int n = 0; n < 16; n += 1) {
    pinMode(ADDR[n], INPUT);
  }
  for (int n = 0; n < 8; n += 1) {
    pinMode(DATA[n], INPUT);
  }
  pinMode(CLOCK, INPUT);
  pinMode(READ_WRITE, INPUT);

  attachInterrupt(digitalPinToInterrupt(CLOCK), onClock, RISING);
  
  Serial.begin(57600);
}

void onClock() {
  print = true;
  pulses++;  
}

void loop() {

  char output[64];
  unsigned long deltaTime = micros() - lastTime;

  char addr_bin[20];
  char data_bin[20];

  memset(&addr_bin, 0, sizeof(addr_bin));
  memset(&data_bin, 0, sizeof(data_bin));
  
  if (print) {

    unsigned int address = 0;
    for (int n = 0; n < 16; n += 1) {
      int bit = digitalRead(ADDR[n]) ? 1 : 0;
      addr_bin[n] = bit + '0';
      address = (address << 1) + bit;
    }
  
    unsigned int data = 0;
    for (int n = 0; n < 8; n += 1) {
      int bit = digitalRead(DATA[n]) ? 1 : 0;
      data_bin[n] = bit + '0';
      data = (data << 1) + bit;
    }

    char* op = digitalRead(READ_WRITE) ? "r" : "W";
    char* dir = digitalRead(READ_WRITE) ? "<-" : "->";
    
    sprintf(output, "%s %s 0x%02X %s %s 0x%04X @ %lu Hz", op, data_bin, data, dir, addr_bin, address, clockSpeed);
    Serial.println(output);
    print = false;
  }

  if (deltaTime > 1000000) {
    clockSpeed = pulses;
    lastTime = micros();
    pulses = 0;
  }

    
  
}

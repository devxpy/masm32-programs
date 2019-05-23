#include <LPC214X.H>
#include <stdlib.h>
#include <string.h>
#define EN (1 << 10) // enable  set to pin 10
#define RW (1 << 12) // RW  set to pin 11
#define RS (1 << 13) // RS  set to pin 13
#define DATA (0xff << 15)        // Data pin selection from P0.15 to P0.22
#define port EN | RW | RS | DATA // define all to port

// Command mode RS=0, RW=0, En=1 then EN=0
void cmd(int c) {
  IOPIN0 = c << 15; // Sending data(cmd) to data pins
  IOCLR0 = RW;
  IOCLR0 = RS;
  IOSET0 = EN;
  delay(25);
  IOCLR0 = EN;
}
// DATA mode RS=1, RW=0, En=1 then EN=0
void data(char d) {
  IOPIN0 = d << 15; // Sending data to data pins
  IOCLR0 = RW;
  IOSET0 = RS;
  IOSET0 = EN;
  delay(25);
  IOCLR0 = EN;
}
void delay(int count) {
  int i, j;
  for (i = 0; i < count; i++)
    for (j = 0; j < 5000; j++)
      ;
}

int main() {

  char *string_1 = "   WELCOME TO   ";
  char *string_2 = " INNOWITECH ";

  IODIR0 |= port; // set all port once
                  //  IODIR0 |= ((1 << 5) | (1 << 6));
  cmd(0x38);      /*   //Function Set Command : 8 Bit Mode , 2 Rows , 5x10 Font
                     Style.        */
  cmd(0x0E);      // Display Switch Command : Display on , Cursor on , Blink on
  cmd(0x01);      /*   LCD clear                                   */
  cmd(0x80);      // Select 1st Row & 1st col
  while (*string_1) {
    data(*string_1);
    string_1++;
  }
  cmd(0xc0); // bring the cursor down

  while (*string_2) {
    data(*string_2);
    string_2++;
  }
}
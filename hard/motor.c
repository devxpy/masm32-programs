#include "LPC214x.H"
#include "motor.h"

#define PIN1 (1 << 27)
#define PIN2 (1 << 28)
#define PIN3 (1 << 29)
#define PIN4 (1 << 30)

void init_motor() { IODIR1 = (PIN1 | PIN2 | PIN3 | PIN4); }

void rotate_motor_anticlock_wise() {
  unsigned char i;

  for (i = 0; i < 25; i++) {
    IOCLR1 = (PIN1 | PIN2 | PIN4);
    IOSET1 = PIN3;
    delay();

    IOCLR1 = (PIN3 | PIN2 | PIN4);
    IOSET1 = PIN1;
    delay();

    IOCLR1 = (PIN1 | PIN3 | PIN2);
    IOSET1 = PIN4;
    delay();

    IOCLR1 = (PIN1 | PIN3 | PIN4);
    IOSET1 = PIN2;
    delay();
  }
}

void rotate_motor_clock_wise() {
  unsigned char i;

  for (i = 0; i < 25; i++) {

    IOCLR1 = (PIN2 | PIN3 | PIN4);
    IOSET1 = PIN1;
    delay();

    IOCLR1 = (PIN1 | PIN2 | PIN4);
    IOSET1 = PIN3;
    delay();

    IOCLR1 = (PIN1 | PIN3 | PIN4);
    IOSET1 = PIN2;
    delay();

    IOCLR1 = (PIN1 | PIN2 | PIN3);
    IOSET1 = PIN4;
    delay();
  }
}

void delay() {
  int i, j;
  for (i = 0; i < 10000; i++) {
    for (j = 0; j < 50; j++) {
      continue;
    }
  }
}

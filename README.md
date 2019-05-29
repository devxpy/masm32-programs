## DOS Functions

```asm
mov ah, <func>
int 21h
```

|                         |                                                              |
| ----------------------- | :----------------------------------------------------------- |
| `1`                     | read char from keyboard into `al`                            |
| `8`                     | read char without echo into `al`                             |
| `2`                     | print character from `dl`                                    |
| `9`                     | print string from `dx`                                       |
| `4c`                    | exit                                                         |
| `cld`<br />`repe cmpsb` | compare strings at `si` and `di`                             |
| `2c`                    | get time (`ch` - Hours, `cl` - Minutes)                      |
| `2a`                    | get date (`dh` - Day, `dl` - Month, `ch`+`cl` - Year). <br />remember to add `c30` to `cl` before. |



## Other functions



|                               |                                 |
| ----------------------------- | ------------------------------- |
| `mov al, 01h` <br />`int 16h` | read status of keyboard buffer. |
| `mul <reg>`                   | `ax = al * <reg>`               |
| `out dx, al`                  | output al into addr at dx       |
| `in al, dx`                   | input addr at dx int al         |



## I/O registers

|                                  |                                                              |
| -------------------------------- | ------------------------------------------------------------ |
| `c60`                            | port a (`pa`)                                                |
| `c61`                            | port b (`pb`)                                                |
| `c62`                            | port c (`pc`)                                                |
| `c63`                            | register for control word (`cwr`)                            |
| `82`                             | control word (`cw`)                                          |
| `0` and `11`<br />(with `outpc`) | pule clock signal values<br />(used after writing to 7 segment display) |



## Register usage

- binary search

    |      |                                         |
    | ---- | --------------------------------------- |
    | `bx` | lower position = `1`                    |
    | `cx` | element to search                       |
    | `dx` | upper position = `len`                  |
    | `ax` | current position = `(bx + dx) / 2`      |
    | `si` | double-index for array = `2 * (ax - 1)` |

- palindrome

    |             |                           |
    | ----------- | ------------------------- |
    | `SI` & `DI` | for indicies of 2 strings |
    | `cx`        | counter for repe cmpsb    |

- ncr

    |      |         |
    | ---- | ------- |
    | `AL` | n value |
    | `BL` | r value |

- date and time

    |      |                                      |
    | ---- | ------------------------------------ |
    | `ax` | for `aam` instruction                |
    | `bx` | for printing out char stored in `ax` |

- sort

    |      |                                       |
    | ---- | ------------------------------------- |
    | `cx` | outer loop position = `2` to `len`    |
    | `dx` | inner loop index = `cx - 1            |
    | `si` | inner loop array double-index = `2dx` |
    | `di` | to swap `si - 2` and `si`             |

- fire and help

    |      |                                  |
    | ---- | -------------------------------- |
    | `si` | index for table                  |
    | `bl` | for counting down from`8` to `0` |
    | `al` | to hold next table value         |

- multiply (h/w)

    |      |           |
    | ---- | --------- |
    | `al` | operand 1 |
    | `bl` | operand 2 |

- lcd screen (c)

    |                                |                                  |
    | ------------------------------ | -------------------------------- |
    | `0 << 10`                      | `EN`                             |
    | `0 << 12`                      | `RW`                             |
    | `0 << 13`                      | `RS`                             |
    | `0xff << 15`                   | `DATA`                           |
    | `IOPIN0 = x << 15`                | send data/char to pin |
    | `IODIR1 | EN | RW | RS | DATA` | `IODIR1`                         |
    | `38`, `E`, `1`, `8c`           | commands sent for initialization |
    | `RS=0`, `RW=0`, `EN=0` ->  `EN=1` | cmd mode |
    | `RS=1`, `RW=0`, `EN=0` ->  `EN=1` | data mode |
    | `c0` | bring cursor down |
    | `IOSET0` |  |
    | `IOCLR0` |  |

- motor (c)

    |                             |          |
    | --------------------------- | -------- |
    | `0 << 27`                   | `PIN1`   |
    | `0 << 28`                   | `PIN2`   |
    | `0 << 29`                   | `PIN3`   |
    | `0 << 30`                   | `PIN4`   |
    | `PIN1 | PIN2 | PIN3 | PIN4` | `IODIR1` |
    | `IOSET1`                    |          |
    | `IOCLR1`                    |          |



##  Magic

- ncr

    ```
    if r = 0 or = n
        1
    if r = 1 or n - 1
        n
    else
        (n - 1)C(r) + (n - 1)C(r - 1)      
    ```

- palindrome

  Ascii value for `'0'` is `30h`.

  To convert number to ascii byte, add `30h` or just `'0'`.

  To convert number to ascii word, add `3030h` or just `"00"`.

  

- motor

  start port value from `mov al, 88`, loop `200` times.
  
  for clockwise, use `rol al, 1`
  
  for anti-clockwise, use `ror al, 1`


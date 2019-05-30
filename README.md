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



|                               |                                                |
| ----------------------------- | ---------------------------------------------- |
| `mov al, 01h` <br />`int 16h` | read status of keyboard buffer.                |
| `mul <reg>`                   | `ax = al * <reg>`                              |
| `out dx, al`                  | send output value from `al` to address at `dx` |
| `in al, dx`                   | take input from address at `dx` into `al`      |



## I/O registers

|       |                                   |
| ----- | --------------------------------- |
| `c60` | port a (`pa`)                     |
| `c61` | port b (`pb`)                     |
| `c62` | port c (`pc`)                     |
| `c63` | register for control word (`cwr`) |
| `82`  | control word (`cw`)               |



## Register usage

- binary search

    |      |                                         |
    | ---- | --------------------------------------- |
    | `bx` | lower position = `1`                    |
    | `cx` | element to search (`key`)               |
    | `dx` | upper position = `len`                  |
    | `ax` | current position = `(bx + dx) / 2`      |
    | `si` | double-index for array = `2 * (ax - 1)` |
- sort

    |      |                                                              |
    | ---- | ------------------------------------------------------------ |
    | `cx` | outer loop position = `2` to `len`                           |
    | `dx` | inner loop index = `cx - 1` to `0`                           |
    | `si` | inner loop array double-index = `2 * dx`                     |
    | `di` | to swap `si - 2` and `si`                                    |
    | `ax` | element at `array[si]` <br />(element to compare in insertion sort loop) |

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


- fire and help

    |      |                                             |
    | ---- | ------------------------------------------- |
    | `si` | current index for table                     |
    | `cx` | count-down from `4` <br />(for each letter) |
    | `bl` | count down from `8`<br />(for each bit)     |
    | `al` | to hold current table value                 |

- multiply (h/w)

    |      |           |
    | ---- | --------- |
    | `al` | operand 1 |
    | `bl` | operand 2 |

- lcd screen (c)

    |                                    |                                  |
    | ---------------------------------- | -------------------------------- |
    | `0 << 10`                          | `EN`                             |
    | `0 << 12`                          | `RW`                             |
    | `0 << 13`                          | `RS`                             |
    | `0xff << 15`                       | `DATA`                           |
    | `IOPIN0 = x << 15`                 | send data/char to pin            |
    | `IODIR1 \| EN \| RW \| RS \| DATA` | `IODIR1`                         |
    | `38`, `E`, `1`, `80`               | commands sent for initialization |
    | `RS=0`, `RW=0`, `EN=0` ->  `EN=1`  | cmd mode                         |
    | `RS=1`, `RW=0`, `EN=0` ->  `EN=1`  | data mode                        |
    | `c0`                               | bring cursor down                |
    | `IOSET0`                           |                                  |
    | `IOCLR0`                           |                                  |

- motor (c)

    |                                |          |
    | ------------------------------ | -------- |
    | `0 << 27`                      | `PIN1`   |
    | `0 << 28`                      | `PIN2`   |
    | `0 << 29`                      | `PIN3`   |
    | `0 << 30`                      | `PIN4`   |
    | `PIN1 \| PIN2 \| PIN3 \| PIN4` | `IODIR1` |
    | `IOSET1`                       |          |
    | `IOCLR1`                       |          |



##  Magic

- ncr

    ```
    if r = 0 OR n
        1
    if r = 1 OR n - 1
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

- sine wave

  Magic Formula = `128 + 128 * sin(x)` (in degrees)

  `25h` values  (from `0` to `360` degrees)

- half sine wave

  `11h` values (from `10` to `170` degrees)

- fire and help

  ![Image result for 7 segment display](data:image/png;base64,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)

  ```
  h g f e | d c b a
  1 x x x | x x x x
  ```

  ` 0` - activate

  `1` - deactivate

  

  Write bit-by-bit to `pb`

  Then perform  pulse clock signal to `pc` -  send `0` followed by `11`.


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

![diagram](https://upload.wikimedia.org/wikipedia/commons/thumb/e/ed/7_Segment_Display_with_Labeled_Segments.svg/220px-7_Segment_Display_with_Labeled_Segments.svg.png)

  ```
  h g f e | d c b a
  1 x x x | x x x x
  ```

  ` 0` - activate

  `1` - deactivate

  

  Write bit-by-bit to `pb`

  Then perform  pulse clock signal to `pc` -  send `0` followed by `11`.


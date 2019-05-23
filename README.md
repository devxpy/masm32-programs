## DOS Functions

```
mov ah, <function>
int 21h
```

- `1` - read 1 char from keyboard into `AL`:
- `2` - print character from `DL`
- `9` - print string from `DX`
- `4C` - exit
- `CLD; REPE CMPSB` - compare strings at `SI` and `DI`
- `2C` - get time (`CH` - Hours, `CL` - Minutes)
- `2A` - get date (`DH` - Day, `DL` - Month, `CH`+`CL` - Year). Also, remeber to add `0C30H` to `CX`

## register usage

- binary search
  - `BX` - lower position = `1`
  - `CX` - element to search
  - `DX` - upper position = `len`
  - `AX` - current position = `(BX + DX) / 2`
  - `SI` - double-index for array = `2 * (AX - 1)`

- palindrome
  - `CX` -  counter for repe cmpsb
  - `SI` & `DI` - for indicies of 2 strings

- ncr
  - `AL` - n value 
  - `BL` - r value

- date and time
  - `AX` for `AAM` instruction
  - `BX` for printing out char stored in `AX`

- sort
  - `CX` - outer loop position = `2` to `len`
  - `DX` - inner loop index = `CX - 1`
  - `SI` - inner loop array double-index = `2DX`
  - `DI` - to swap `SI - 2` and `SI`

## magic

```
nCr =
    if r = 0 or = n
        1
    if r = 1 or n - 1
        n
    else
        (n - 1)C(r) + (n - 1)C(r - 1)

```

---


Asccii value for `'0'` is `30H`.

To convert number to ascii byte, add `30H` or just `'0'`.

To convert number to ascii word, add `3030H` or just `"00"`.
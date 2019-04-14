{

Theory of operation

There are fourteen pins connecting the Propeller to the host CPU:

D0-D7 - The data bus      [ Input/Output ]
RS    - Register select   [ Input ]
/CS   - Chip select       [ Input ]
PHI2  - Phi2 Clock        [ Input ]
STP   - STP               [ Input ]
/IRQ  - IRQ line.         [ Output ]

While the Propeller is not being accessed by the host (/CS is high) the data
bus pins are set as inputs, and the STP line is held high. This prevents
contention on the data bus, and allows STP to float high via its pullup resistor.

As soon as /CS goes low we start prepping for a bus transaction. The first
thing we do is wait until either /RD or /WR goes low (if both go low, /WR
takes precedence). At this point a R/W cycle is in progress and the CPU's
PHI2 clock is high. We immediately pull STP low by changing it to an output;
this halts the CPU and gives us time to process the request.

Once the request is processed, STP is released by changing it back to an
input, allowing the CPU to resume. We then wait for the /CS line to go high
again before looping and waiting for a new transaction

This just waits for /CS to go low while PHI2 is high. It then pulls STP low to
halt the CPU while we perform the requested operation. We support four types
of operations:

1. VRAM read (RWB=1, RS=0)
2. VRAM write (RWB=0, RS=0)
3. Register read (RWB=1, RS=1)
4. Register write (RWB=0, RS=1)
}

CON
  _clkmode = XTAL1|PLL16X
  _xinfreq = 5_000_000

PUB init(buffer_start, buffer_size, cursor, sidregs)
    buffer[0] := buffer_start
    buffer[1] := buffer_size
    buffer[2] := cursor
    buffer[3] := sidregs
    
    cognew(@Bus65xx, @buffer{0})

VAR
    long    buffer[3]
    
DAT
            org     0

Bus65xx     or      outa, Pin_IRQ               '/IRQ starts high
            or      dira, Pin_IRQ
                   
            andn    outa, Pin_STP               '/STP starts high (low, because inverter)
            or      dira, Pin_STP
 
            or      outa, Pin_RESET             '/RESET starts low (high, because inverter)
            or      dira, Pin_RESET
            
            or      outa, Pin_BE                '/BE starts high
            or      dira, Pin_BE

            mov     temp, par                   'Get address of parameters
            rdlong  vram_start, temp            'Copy VRAM start address
            add     temp, #4
            rdlong  vram_len, temp              'Copy VRAM length
            add     temp, #4
            rdlong  cursor_def, temp            'Copy cursor_def address
            add     temp, #4
            rdlong  sid_regs, temp              'Start of SID registers

            mov     vram_ptr, vram_len          'Initialize the VRAM pointer
            sub     vram_ptr, #1
            mov     target_reg, #0              'Reset the state for register writes
            mov     status_reg, #$42            'testing
            mov     ctrl_reg, #0                'start vram in dec mode

            andn    outa, Pin_RESET             'Raise (lower) /RESET and start the MPU

'' Main event loop; wait for a new bus request, service it, and repeat

mainloop    waitpeq Pin_PHI2, Pin_CS_PHI2       'Wait for /CS to go low with Phi2 high 
            or      outa, Pin_STP               'Pull /STP low
            andn    outa, Pin_BE                'Pull /BE low
            mov     _in, ina
            and     _in, Pin_RS WZ,NR           'Check RS bit (0 = vram, 1 = registers)
            and     _in, Pin_RWB                'Mask RWB bit for later
    if_e    jmp     #:vram
            tjz     _in, #write_register
            jmp     #read_register
:vram       tjz     _in, #write_vram
            jmp     #read_vram

'' Common code for all ops; unhalts the CPU, waits for /CS to go high and then loops

finish_request
            waitpne Pin_PHI2, Pin_PHI2          'Wait for Phi2 to go low
            waitpeq Pin_PHI2, Pin_PHI2          'one cycle so we restart on Phi2 high
            andn    outa, Pin_STP               'Unpause the CPU
            waitpeq Pin_CS, Pin_CS              'Wait for /CS to go high again
            or      outa, Pin_BE                'Pull /BE high                                        '
            andn    dira, Pins_Data             'Set data bus pins to high-Z (input state)
            jmp     #mainloop                   'Rinse and repeat

'' Read a register
read_register
            mov     target_reg,#0               'A read always resets the write state
            mov     data, status_reg
            jmp     #read_common
            
'' Read VRAM and increment pointer
read_vram
            mov     temp, vram_ptr
            add     temp, vram_start
            rdbyte  data, temp                  'Get the byte
            call    #adjust_vram_ptr

'' Common code for read_xxx functions, puts the data on the bus and calls finish_request

read_common and     data, Pins_Data
            andn    outa, Pins_Data             'Clear output pins
            or      outa, data                  'and put the data value on the bus
            or      dira, Pins_Data             'Set data bus pins to be outputs
            jmp     #finish_request

'' Write VRAM and increment pointer
write_vram
            mov     data, ina                   'Capture the data bus
            mov     temp, vram_ptr
            add     temp, vram_start
            wrbyte  data, temp
            call    #adjust_vram_ptr
            jmp     #finish_request

write_register
            mov     data, ina                   'Capture the data byte that was written
            and     data, #255                  'Mask off everything else
            tjnz    target_reg, #:doit          'If this is the second byte do the write
            mov     target_reg, data
            or      target_reg, #$100           'Mark target as set
            jmp     #finish_request
:doit       mov     temp, target_reg            'Save target reg value
            and     target_reg, #%1_1111        'Mask off the destination cog bits
            and     temp, #%1110_0000   wz      'Check destination cog bits in temp copy
    if_e    jmp     #write_video_registers
            cmp     temp, #$20  wz
    if_e    jmp     #write_sid_registers
            cmp     temp, #$40  wz
    if_e    jmp      #write_spi_registers

finish_write_register
            mov     target_reg, #0
            jmp     #finish_request
            
write_spi_registers
            jmp     #finish_write_register

write_sid_registers
            cmp     target_reg, #$1D  wc    'Are we past the highest SID register?
    if_ae   jmp     #finish_write_register
            add     target_reg, sid_regs    'Add offset of first SID register
            wrbyte  data, target_reg        'and write the data
            jmp     #finish_write_register

write_video_registers
            cmp     target_reg, #0  wz
    if_e    jmp     #:ctrl
            cmp     target_reg, #1  wz
    if_e    jmp     #:vram_lo
            cmp     target_reg, #2  wz
    if_e    jmp     #:vram_hi
            cmp     target_reg, #3  wz
    if_e    jmp     #:cursor_mode
            cmp     target_reg, #4  wz
    if_e    jmp     #:cursor_x
            cmp     target_reg, #5  wz
    if_e    jmp     #:cursor_y
            jmp     #finish_write_register
:vram_lo    and     vram_ptr, VramMaskLo
            or      vram_ptr, data
            jmp     #finish_write_register
:vram_hi    shl     data, #8
            and     vram_ptr, VramMaskHi
            or      vram_ptr, data
            cmp     vram_ptr, vram_len  wc
    if_ae   mov     vram_ptr, #0
            jmp     #finish_write_register
:ctrl       mov     ctrl_reg, data
            jmp     #finish_write_register
:cursor_mode
            and     data, #%111
            wrbyte  data, cursor_def
            jmp     #finish_write_register
:cursor_x   mov     temp, cursor_def
            add     temp, #1
            wrbyte  data, temp
            jmp     #finish_write_register
:cursor_y   mov     temp, cursor_def
            add     temp, #2
            wrbyte  data, temp
            jmp     #finish_write_register
            
'' Increment the VRAM pointer, wrapping back to zero if it passes the end of the buffer
adjust_vram_ptr
            and     ctrl_reg, #1    wz,nr
    if_ne   jmp     :inc
:dec        cmp     vram_ptr, #0    wz
    if_e    mov     vram_ptr, vram_len
            sub     vram_ptr, #1
            jmp     adjust_vram_ptr_ret
:inc        add     vram_ptr, #1
            cmp     vram_ptr, vram_len  wc
    if_ae   mov     vram_ptr, #0
adjust_vram_ptr_ret
            ret            

Pins_Data   long    %11111111                   'D0-D7
Pin_RS      long    |< 8                        'RS
Pin_CS      long    |< 9                        '/CS
Pin_RWB     long    |< 10                       'RWB
Pin_PHI2    long    |< 11                       'PHI2
Pin_STP     long    |< 12                       '/STP
Pin_IRQ     long    |< 13                       '/IRQ
Pin_RESET   long    |< 26                       '/RESET
Pin_BE      long    |< 27                       '/BE

Pin_CS_PHI2 long    |<9 | |<11                  '/CS | PHI2

VramMaskHi long   %0000_0000_1111_1111
VramMaskLo long   %1111_1111_0000_0000

_in         res     4
target_reg  res     4
data        res     4
temp        res     4
vram_start  res     4
vram_len    res     4
cursor_def  res     4

status_reg  res     4
ctrl_reg    res     4
vram_ptr    res     4
sid_regs    res     4
spi_regs    res     4

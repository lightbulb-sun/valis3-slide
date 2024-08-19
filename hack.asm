BIT_BUTTON_C = 5
BIT_BUTTON_DOWN = 1
HELD_BUTTONS = $fff400
NEW_BUTTONS = $fff401

    org 0
    incbin "valis3.md"

    ; advance dialogue with any button
    org $003b08
            andi.b  #$ff, d0
    org $003b24
            andi.b  #$ff, d0

    ; A+Down doesn't slide
    org $006f52
            nop
    ; A doesn't slide
    org $006f62
            nop

    org $006d74
            jmp     my_code

    org $0fcc00
my_code:
.check_for_down_press
            btst    #BIT_BUTTON_DOWN, (HELD_BUTTONS)
            beq     .original
.check_for_c_press
            btst    #BIT_BUTTON_C, (HELD_BUTTONS)
            beq     .original
.slide
            jmp     $006f7e
.original
            ; replace original instructions
            btst    #BIT_BUTTON_C, (NEW_BUTTONS)
            bne     .new_c_button
            jmp     $006d7e
.new_c_button
            jmp     $006e14

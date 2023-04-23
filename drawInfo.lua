API

Status - true/false = on/off

Key Modes - Always visible if key is set/only if true/always visible(no key will be displayed as not active)/always visible(no key will be displayed as active)/only shows when no key is assigned = 0/1/2/3/4

Checkbox Modes = always visible/only if true = 0/1

add.Indicator(text, r, g, b, a, status) - allows you to add a custom indicator.

Status(true/false) you can turn on and off the indicator.


add.IndicatorForKeybox(text, var, mode, status, r1, g1, b1, a1, r2, g2, b2, a2) - add an Indicator for an keybox

Var is the GUI variable of the keybox

Mode if set to 0 the indicator will show r1, g1, b1, a1 if the key is pressed and r2, g2, b2, a2 when they kes is not pressed when a key is assigned for the field

when using 1 it only shows the Indicator(r1, g1, b1, a1) while the key is pressed.(you don't to assaign r2, g2, b2, a2 if not used)

Mode 2 the indicator will show r1, g1, b1, a1 if the key is pressed and r2, g2, b2, a2 when the key is not pressed or no key is assigned

Mode 3 the indicator will show r1, g1, b1, a1 if the key is pressed or no key is assigned and r2, g2, b2, a2 when they key is not pressed

Mode 4 the indicator only shows r1, g1, b1, a1 if no key is assigned

Status(true/false) you can turn on and off the indicator


add.IndicatorForCheckbox(text, var, mode, status, r1, g1, b1, a1, r2, g2, b2, a2) - add an Indicator for an checkbox.

Var is the GUI variable of the checkbox.

Mode if set to 0 the indicator will show r1, g1, b1, a1 if the checkbox is active and r2, g2, b2, a2 when the checkbox is not active

when using 1 it only shows the Indicator(r1, g1, b1, a1) while the checkbox id checked. (you don't to assaign r2, g2, b2, a2 if not used)

Status(true/false) you can turn on and off the Indicator

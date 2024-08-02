#!/bin/sh

USB_P_EN1=PC09
USB_P_EN2=PC10

cmd_gpio set_func ${USB_P_EN1} output1
cmd_gpio set_func ${USB_P_EN2} output1

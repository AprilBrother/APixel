--init.lua

-- gpio5
PIN_LED   = 1
TIMER_LED = 3

ledOn = 1

gpio.mode(2, gpio.OUTPUT)
gpio.write(2, gpio.HIGH)
local cnt = 0

print("Starting AButton")

function blink(red, green, blue)
    ledOn = 0
    tmr.stop(TIMER_LED)

    ws2812.writergb(PIN_LED, string.char(red, green, blue))
    tmr.alarm(TIMER_LED, 200, 1, function()
        ledOn = ledOn + 1
        if ledOn % 2 == 0 then
            ws2812.writergb(PIN_LED, string.char(red, green, blue))
        else
            ws2812.writergb(PIN_LED, string.char(0, 0, 0))
        end

        if ledOn > 10 then
            tmr.stop(TIMER_LED)
        end
    end)
end

blink(255, 0, 0)
tmr.alarm(1, 1000, 1, function()
    if wifi.sta.getip()== nil then
        cnt = cnt + 1
        print("(" .. cnt .. ") Waiting for IP...")
        if cnt == 10 then
            tmr.stop(1)
            blink(255, 255, 0)
            dofile("setwifi.lua")
        end
    else
        tmr.stop(1)
        dofile("ifttt.lua")
    end
end)

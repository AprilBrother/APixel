--ifttt.lua

print("Sending to IFTTT")

blink(0, 0, 255)

local key
if file.open("config.txt", "r") then
    key = file.readline()
else
    return
end

conn = nil
conn=net.createConnection(net.TCP, 0) 

conn:on("receive", function(conn, payload) 
    --Shutdown!
    print("Let's shutdown");
    tmr.stop(TIMER_LED)
    ws2812.writergb(PIN_LED, string.char(0, 0, 0))
    gpio.write(2, gpio.LOW)

    --If esp is enabled that means the button is still pushed!
    tmr.alarm(0, 2000, 1, function()
        reset()
    end)
     
end) 
     
conn:on("connection", function(conn, payload) 
    print("Key:" .. key)
    conn:send("GET /trigger/button/with/key/" .. key
        .." HTTP/1.1\r\n" 
        .."Host: maker.ifttt.com\r\n"
        .."Accept: */*\r\n" 
        .."User-Agent: Mozilla/4.0 (compatible; esp8266 Lua; Windows NT 5.1)\r\n" 
        .."\r\n")
    print("IFTTT request sent. Goodbye") 
    blink(0, 255, 0)
end) 
                                       
conn:dns("maker.ifttt.com",function(conn,ip) 
    if (ip) then
        print("We can connect to " .. ip)
        conn:connect(80,ip)
    else
        reset()
    end
end)

function reset()
    print("Reseting Wifi..")
    wifi.sta.disconnect()
    wifi.sta.config("","")
    dofile("setwifi.lua")
end

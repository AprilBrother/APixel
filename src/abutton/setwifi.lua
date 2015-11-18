--setwifi.lua

local _GET = {}

function listap(t)
    for bssid,v in pairs(t) do
        local ssid, rssi, authmode, channel = string.match(v, "([^,]+),([^,]+),([^,]+),([^,]+)")
        ap_list = ap_list.."<option value='"..ssid.."'>"..ssid.."</option>"
    end
end

function saveConfig(client) 
    restarting = "<html><body style='width:90%;margin-left:auto;margin-right:auto;background-color:LightGray;'><h1>Restarting...You may close this window.</h1></body></html>"
    client:send(restarting);
    client:close();
    if(_GET.dssid)then
        local ssid = _GET.dssid
        local password = ""
        local key = ""
        if (_GET.ssid) then
            ssid = _GET.ssid
        end
        if (_GET.password) then
            password = _GET.password
        end
        if _GET.key then
            print("Saving key")
            key = _GET.key
            file.remove("config.txt")
            file.open("config.txt", "w")
            file.write(key)
            file.flush()
            file.close()
        end

        print("Setting to: "..ssid..":"..password)
        tmr.alarm(0, 5000, 1, function()
            wifi.setmode(wifi.STATION);
            wifi.sta.config(ssid,password);
            node.restart()
        end)
    end
end

print("Entering wifi Setup..")

wifi.setmode(wifi.STATIONAP)
cfg={}
cfg.ssid="AButton"
--cfg.password="12345678" --comment to leave open
wifi.ap.config(cfg)

ipcfg={}
ipcfg.ip="192.168.1.1"
ipcfg.netmask="255.255.255.0"
ipcfg.gateway="192.168.1.1"
wifi.ap.setip(ipcfg)

ap_list = ""

wifi.sta.getap(1, listap)
srv=net.createServer(net.TCP)
srv:listen(80,function(conn)
    local staticFile
    conn:on("receive", function(client,request)
        local buf = "";
        local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP");
        if(method == nil)then
            _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP");
        end
        if (vars ~= nil) then
            for k, v in string.gfind(vars, "([^&=]+)=([^&=]+)") do
                _GET[k] = v
                print(k)
                print(v)
            end
        end

        if path == "/favicon.ico" then
            conn:send("HTTP/1.1 404 file not found")
            return
        end   

        if path == "/pure.css" then
            staticFile = "pure.css"
            conn:send("HTTP/1.1 200 OK\r\n\r\n")
            return
        end

        if (path == "/" and  vars == nil) then
            print("received")
            staticFile = "index.tpl"
            conn:send("HTTP/1.1 200 OK\r\n\r\n")
            return
        elseif (vars ~= nil) then
            saveConfig(client)
            return
        end
    end)

    local offset = 0
    conn:on("sent", function(client) 
        if staticFile == nil then
            return
        end

        print("sent")
        if offset >= 0 then
            file.open(staticFile, "r") 
            file.seek("set", offset)
            local line = file.read(512)
            file.close();      
            if line then
                client:send(line)
                offset = offset + 512
                if (string.len(line) == 512) then
                    return
                end
            end
        end

        client:close()
        offset = 0
        collectgarbage();
    end)
end)

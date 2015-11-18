######################################################################
# User configuration
######################################################################
# Path to nodemcu-uploader (https://github.com/kmpm/nodemcu-uploader)
NODEMCU-UPLOADER=./nodemcu-uploader.py
# Serial port
PORT=/dev/cu.SLAB_USBtoUART
SPEED=9600

# t1 = {"httpserver.lua", "httpserver-request.lua", "httpserver-basicauth.lua", "httpserver-b64decode.lua", "httpserver-conf.lua", "httpserver-static.lua", "httpserver-header.lua", "httpserver-error.lua"}
# table.foreach(t1, function(i, v) 
# node.compile(v) 
# end)

######################################################################
# End of user config
######################################################################
HTTP_FILES := index.tpl pure.css
LUA_FILES := init.lua setwifi.lua ifttt.lua 

# Print usage
usage:
	@echo "make upload FILE:=<file>  to upload a specific file (i.e make upload FILE:=init.lua)"
	@echo "make upload_http          to upload files to be served"
	@echo "make upload_server        to upload the server code and init.lua"
	@echo "make upload_all           to upload all"
	@echo $(TEST)

# Upload one files only
upload:
	@$(NODEMCU-UPLOADER) -b $(SPEED) -p $(PORT) upload $(FILE)

# Upload HTTP files only
upload_http: $(HTTP_FILES)
	@$(NODEMCU-UPLOADER) -b $(SPEED) -p $(PORT) upload $(foreach f, $^, $(f))

# Upload httpserver lua files (init and server module)
upload_server: $(LUA_FILES)
	@$(NODEMCU-UPLOADER) -b $(SPEED) -p $(PORT) upload $(foreach f, $^, $(f))

# Upload all
upload_all: $(LUA_FILES) $(HTTP_FILES)
	@$(NODEMCU-UPLOADER) -b $(SPEED) -p $(PORT) upload $(foreach f, $^, $(f))

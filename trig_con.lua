--[[
@title Triggered Continuous Shooting

--]]

--[[
get_usb_power Documentation, see: http://chdk.wikia.com/wiki/USB_Remote

get_usb_power(0)
returns the pulse width of the most recent USB power activation and clears that value. 
USB remote must be enabled for this function to work
do 
p = get_usb_power 0 
until p>0

get_usb_power(1)
returns the current state of USB power ( 0=off, 1=on)
this function works whether or not USB remote mode is enabled.
do 
p = get_usb_power 1 
until p>0

get_usb_power(2)
returns the buffered pulse width or pulse gap timing.  Width values are positive, gap values are negative.
this function works whether or not USB remote mode is enabled.
do 
p = get_usb_power 2 
ntil p>0

get_usb_power(3)
returns the count of pulses since that last time the function was called. Function return 0 when no pulses are receive in the previons 1 second. 
this function works whether or not USB remote mode is enabled.
do 
p = get_usb_power 3 
until p>0	
--]]

--[[
get_drive_mode Documentation, see: http://chdk.wikia.com/wiki/Script_commands#get_drive_mode

get_drive_mode
returns drivemode (as described on the property page)

0 = single 1 = continuous 2 = timer (on Digic II) 3 = timer (on Digic III)

The timer issue will somewhat make it difficult to use it in universal scripts, however together with a get_propset this should be do-able.
--]]

if get_drive_mode() == 1 then
	print("                       ")
	print("                       ")
	print("                       ")
	print("                       ")
	print("                       ")
	print("Waiting for tirgger up.")
	while get_usb_power(1) ~= 1 do
		sleep(100)
	end

	print("Waiting for tirgger down.")
	while get_usb_power(1) == 1 do
		sleep(100)
	end

	press ("shoot_half")
	sleep (500)
	print("                       ")
	print("Shooting continually!!")
	print("          **** ")
	print("                       ")
	

	sleep(1500)
	press("shoot_full")
	sleep(1000)
	while get_usb_power(1) ~= 1 do
		sleep(100)
	end
	release("shoot_full")
	sleep(100)
	release("shoot_half")
	print ("Finished")
else
	print ("ERROR! Not in continuous mode!!!")
end

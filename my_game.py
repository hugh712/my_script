# Imports the monkeyrunner modules used by this program
from com.android.monkeyrunner import MonkeyRunner, MonkeyDevice
import os
from time import sleep
go  = True

print 'loading device'

# Connects to the current device, returning a MonkeyDevice object
device = MonkeyRunner.waitForConnection()

print 'device loaded'


while go:
        os.system('clear')
	# play
	# 1744,670
	print "play"
        device.touch(360, 1230 , MonkeyDevice.DOWN)
        device.touch(360, 1230 , MonkeyDevice.UP)
	sleep(130)
	
	# restart 
	# 681, 787
	print "restart"
	device.touch(600, 1225 , MonkeyDevice.DOWN)
        device.touch(600, 1225 , MonkeyDevice.UP)
	sleep(5)

        # next turn
else:
	print 'leave'

print 'Done'


#initiate_facetime_call.rb v1a Epoc mod
	# > path: /users/stephanegarnier/imac_ruby_dev/remote_facetime_epoc

require 'rubygems'
require 'appscript'
include Appscript
require 'osax'
include OSAX


################################## added for epoc build ##################################
#def setupCall()	 
	
#end	
##########################################################################################


# 0 > open terminal
terminalApp = Appscript.app("/Applications/Utilities/Terminal.app")
terminalApp.activate

# 0.5 check if we were provided arguments to sue within the script

# 1 > use a terminal cmd to open the Facetime URL in Safari app
#cmd = "/usr/bin/open -a Safari facetime://+33681382722" # function that was used before the epoc mod
#setupCall()


	if ARGV.length == 0 # > no arguments were passed
		puts 'No arguments were found > calling default number on facetime ...'
		cmd = "/usr/bin/open -a Safari facetime://+33681382722" 
	else #: accept arguments and use them to initiate the call
	
		if ARGV[0] == 'call' # if the ruby script was passed a first argument (at least one), and if it matches the string "call", then
			puts "calling phone number #{ARGV[1]} on facetime ..." # print the desired caller number, specified as second argument
			cmd = "/usr/bin/open -a Safari facetime://+#{ARGV[1]}" # ARGV[1] should contain any formatted phone number, like '33681382722'
		else
			puts 'Sorry, found no valid caller parameter, switching to default number...' # alert user that something went wrong
			#exit # quit the script > maybe a little 'radical' ? ^^
			cmd = "/usr/bin/open -a Safari facetime://+33681382722"
		end
	end

system (cmd)

# 2 > wait a little bit for Facetime to activate, then switch back to "previous app in front"[ it should be the empty safari tab], delete the tab (cmd + W), switch back to Facetime and initiate call by hitting Enter
sleep(5) #wait 5s

`osascript -e 'tell application "System Events" to keystroke (ASCII character 9) using command down'` # switch back to safari empty tab (the one that got opped up after opening the link from the terminal)

sleep(1) #wait 2s

`osascript -e 'tell application "System Events" to keystroke (ASCII character 119) using command down'` # delete the empty tab

sleep(1) #wait 0.5s

`osascript -e 'tell application "System Events" to keystroke (ASCII character 9) using command down'` # switch back to facetime

sleep(1) #wait 0.5s

`osascript -e 'tell application "System Events" to keystroke return'` # initiate call by "hitting Enter key" [^^!]

# 2 > Done! Your Mac should now be calling you

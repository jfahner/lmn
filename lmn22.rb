#ruby program by Jerry Fahner to read status of Lansing Maker Network space
#and control a blink(1) light.
#set blink(1) controller to check for color code in a file, here called 
#c:/junk/lmn.rb
# red = closed
# green = open
require 'rubygems'
require 'nokogiri'
require 'open-uri'
url="http://api.lansingmakersnetwork.org/status"
$i = 0
k=0
stateLast = ""
while $i < 1000  # max reads before quitting
data=Nokogiri::HTML(open(url))
lmnOut = data.xpath('//p')[0].content
state = lmnOut.split(',')[-3]   # split paragraph content at commas and use first part
state = state.split(':')[-1]  #use only the part after the :
  if state != stateLast
    j=0
      while j < 10  #sound alarm: state has changed
        print "\a"
        #sleep(1)
        j +=1
      end
    stateLast = state
  end
puts "State currently is ", state
print "Space is "  # print - no cr/lf    puts - cr/lf
  if state == "true"  
    print "open  "
    file = File.open("c:/junk/lmn.txt", "w")
    file.write("#00ff00")			#set to green - open
    file.close unless file == nil
  else
    print "closed  "
    file = File.open("c:/junk/lmn.txt", "w")
    file.write("#ff0000")			#set to red - closed
    file.close unless file == nil
  end 
time = Time.new
print "Time: "
print time.hour
print ":"
  if time.min <10 
    print "0"
  else
  end
puts time.min
$i +=1  # increment status check counter
sleep(60)  #seconds between status checks
data=""
end
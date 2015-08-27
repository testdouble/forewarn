require 'forewarn'

Forewarn.start!

obj = Object.new
obj.taint

puts "should not have been warned"

s = "hi"
s.taint

puts "NOW you good"

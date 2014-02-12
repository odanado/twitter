#!/usr/bin/ruby
# -*- coding: utf-8 -*-

if ARGV.empty?
    puts "usage: #{$0} {start|stop|restart}"
    exit
end

case ARGV[0]
when "start"
    system('nohup ./update_name.rb >> out.log 2>> err.log < /dev/null &')

when "stop"
    system('killall update_name.rb')

when "restart"
    system('./poke_odan.rb stop')
    system('./poke_odan.rb start')
else
    puts "usage: #{$0} {start|stop|restart}"
end


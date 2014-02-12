#!/usr/bin/ruby
# -*- coding: utf-8 -*-

if ARGV.empty?
    puts "usage: #{$0} {start|stop|restart}"
    exit
end

case ARGV[0]
when "start"
    system('./tweet.rb 起動しました.')
    system('nohup ./mention_event.rb >> out.log 2>> err.log < /dev/null &')

when "stop"
    system('killall mention_event.rb')
    system('./tweet.rb 終了しました.')

when "restart"
    system('./odanbot.rb stop')
    system('./odanbot.rb start')
else
    puts "usage: #{$0} {start|stop|restart}"
end


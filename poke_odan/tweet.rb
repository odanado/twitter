#!/usr/bin/ruby
# -*- coding: utf-8 -*-
require 'rubygems'
require 'twitter'

load File.expand_path(File.dirname($0))+"/twitter_config.rb"


if ARGV.empty?
    puts "usage: #{$0} <tweet text> ..."
    exit
end

tweet_text = ""

ARGV.each do |text|
    tweet_text += text + " "

end

begin
    $rest_client.update(tweet_text)
rescue => e
    warn "tweet error"
    warn e.class
    warn e.message
    warn e.backtrace
end

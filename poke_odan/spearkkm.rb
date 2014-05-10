#!/usr/bin/ruby
# -*- coding: utf-8 -*-
require 'rubygems'
require 'twitter'

load File.expand_path(File.dirname($0))+"/twitter_config.rb"

user_data = $rest_client.user("spearkkm")

text = Time.now.to_s + ","
text += user_data.name + ","
text += user_data.description + ","
text += user_data.location + "<br>"

puts text


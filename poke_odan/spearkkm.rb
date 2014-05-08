#!/usr/bin/ruby
# -*- coding: utf-8 -*-
require 'rubygems'
require 'twitter'

load File.expand_path(File.dirname($0))+"/twitter_config.rb"

p $rest_client.user("spearkkm")

#!/usr/bin/ruby
# -*- coding: utf-8 -*-
require 'rubygems'
require 'twitter'

load "./twitter_config.rb"

def update_profile(tweet,cmd)

    puts tweet.url.to_str

    text = tweet.text

    screen_name = tweet.url.to_str.split("/")[3]
    reply_id = tweet.url.to_str.split("/")[5]

    ary = text.split(" ")
    new_name = ""
    for i in 2..ary.length-1 do
        new_name += ary[i] + " ";
    end

    tweet_text = "@#{screen_name} によって #{new_name} と #{cmd} されました。"

    begin
    #ここもっといい方法があるはず
    $rest_client.update_profile({cmd.split("update_")[1] => new_name})
    
    $rest_client.update(tweet_text,:in_reply_to_status_id => reply_id)

    rescue => e
        warn "!!!!error!!!!"
        warn Time.now
        warn tweet.url
        warn e.class
        warn e.message
        warn e.backtrace
        warn "\n"
    end
end

def event(tweet,client)
    if tweet.text.split(" ")[0] == "@poke_odan" then
        puts "reply!"

        cmd = tweet.text.split(" ")[1]
        
        if cmd.index("update_name") != nil then
            update_profile(tweet,cmd)
        end
    end

end

begin
    $streaming_client.user do |object|
        case object
        when Twitter::Tweet
            event(object,$rest_client)
        when Twitter::DirectMessage
            puts "It's a direct message!"
        when Twitter::Streaming::StallWarning
            warn "Falling behind!"
        end
    end
rescue => e
    warn "!!!!error!!!!"
    warn Time.now
    warn e.class
    warn e.message
    warn e.backtrace
    warn "\n"
    system("./tweet.rb @poke_odan update name 死んだよ." + 
           Time.now.to_s)
end


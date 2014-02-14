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

    tweet_text = "@#{screen_name} によって #{new_name} と #{cmd} されました."

    begin
    #ここもっといい方法があるはず
    $rest_client.update_profile({cmd.split("update_")[1] => new_name})
    
    $rest_client.update(tweet_text,:in_reply_to_status_id => reply_id)

    rescue => e
        warn e.class
        warn e.message
        warn e.backtrace
    end
end

def primenumber(tweet)
    puts tweet.url.to_str

    screen_name = tweet.url.to_str.split("/")[3]
    reply_id = tweet.url.to_str.split("/")[5]

    n = tweet.text.split(" ")[2].to_i

    tweet_text = ""
    if n <= 0
        tweet_text = "正の整数がほしい."
    elsif n == 1
        tweet_text = "1 は素数ではありません."
    elsif n.to_s.length >= 10
        if `./Miller-Rabin.rb #{n}` == "true"
            tweet_text = "#{n} は確率的素数です."
        else
            tweet_text = "#{n} は合成数です."
        end
    else
        tweet_text = "#{n} は素数です."
        for i in 2..Math.sqrt(n) do
            if n % i == 0
                tweet_text = "#{n} は素数ではありません."
            end

        end
    end

    begin
        $rest_client.update("@#{screen_name} " + tweet_text,:in_reply_to_status_id => reply_id)

    rescue => e
        warn "!!!!error!!!!"
        warn Time.now
        warn tweet.url
        warn e.class
        warn e.message
        warn e.backtrace
    end

end

def event(tweet,client)
    if tweet.text.split(" ")[0] == "@odanbot" then
        puts "reply!"

        cmd = tweet.text.split(" ")[1]
        
        puts "cmd is #{cmd}"
        if cmd.index("update") != nil then
            update_profile(tweet,cmd)
        elsif cmd == "primenumber"
            primenumber(tweet)
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

end



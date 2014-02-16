#!/usr/bin/ruby
# -*- coding: utf-8 -*-

def isPrimeNumber(n)
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
    return tweet_text

end

def randomPrimeNumber(len)
    len = 130 - len
    warn len
    loop do
        n = ""
        for i in 1..len do
            n += rand(9).to_s
        end
        return n.to_i if `./Miller-Rabin.rb #{n}` == "true"
    end
end

reply_from = ARGV[0]
cmd = ARGV[1]
n = ARGV[2]


if n.to_i <= 0
    print randomPrimeNumber(reply_from.length)
else
    print isPrimeNumber(n.to_i)
end


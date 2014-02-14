#!/usr/bin/ruby
def pow_mod(a,n,m)
    res = 1
    while n > 0
        res = res * a % m if n & 1 == 1
        a = a * a % m
        n >>= 1
    end
    return res

end

def isProbabilisticPrimality(n)
    return true if n == 2
    return false if n == 1 || n % 2 == 0

    s = 0
    m = 0
    d = n-1
    while d & 1 == 0
        s = d >> 1
        m+=1
        d >>=1
    end
    
    100.times do
        a = rand(n-2) + 1
        return false if pow_mod(a,n-1,n) != 1

        r1 = pow_mod(a,s,n)
        s<<=1;
        
        for i in 1..m do
            r2 = pow_mod(a,s,n)
            return false if r2 == 1 && r1 != 1 && r1 != n-1

            r1 = r2
            s <<= 1
        end

    end
    return true
end

if ARGV.empty?
    puts "usage: #{$0} <natural number> ..."

end

if isProbabilisticPrimality(ARGV[0].to_i)
    print "true"
else
    print "false"
end


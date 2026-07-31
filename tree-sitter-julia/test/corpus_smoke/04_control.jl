function classify(n)
    if n < 0
        "negative"
    elseif n == 0
        "zero"
    else
        "positive"
    end
end

total = 0
for i in 1:10
    i % 2 == 0 && continue
    global total += i
end

while total > 10
    global total ÷= 2
end

println(classify(3), " ", total)

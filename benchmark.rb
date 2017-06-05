require 'byebug'
puts "JSONB"
total = 0
res = Benchmark.measure do
  Product.all.each { |e| total += e.number + e.value }
end
puts total
puts 'Sum each row columns in both'
puts res

total = 0
res = Benchmark.measure do
  1000.times do
    numbers = (1..3).to_a.map { |e| rand(12..98) }
    total += numbers.reduce(0) { |v, e| v + Product.where(number: e).first.value }
  end
end
puts total
puts 'Sum three random elements by number 1000 times'
puts res

puts 'Order by value'
puts Benchmark.measure do
  numbers.reduce(0) { |v, e| v + Product.where(number: e).first.value }
end

puts "TWO TABLES"
total = 0
res = Benchmark.measure do
  Base.includes(:data_item).all.each { |e| total += e.number + e.data_item.value }
end

puts total
puts 'Sum each row columns in both'
puts res

total = 0
res = Benchmark.measure do
  1000.times do
    numbers = (1..3).to_a.map { |e| rand(12..98) }
    total += numbers.reduce(0) { |v, e| v + Base.where(number: e).includes(:data_item).first.data_item.value }
  end
end

puts total
puts 'Sum three random elements by number 1000 times'
puts res

require 'byebug'
require 'ruby-prof'

puts 'JSONB'
total = 0
product_active = Product.active
base_active = Base.active
single_active = SingleTable.active
puts "#{SingleTable.all.count} table size"
puts "#{single_active.count * 1.0 / SingleTable.all.count} active rate"

puts 'Sum each row columns in both'
puts (Benchmark.measure do
  product_active.each { |e| total += e.number + e.value }
end)

puts 'Sum three random elements by number 1000 times'
puts (Benchmark.measure do
  1000.times do
    numbers = (1..3).to_a.map { |e| rand(12..98) }
    total += numbers.reduce(0) { |v, e| v + product_active.where(number: e).first.value }
  end
end)

puts 'Where value over 500 ordered'
puts (Benchmark.measure do
  10.times do
    product_active.data_where(value: { greater_than: 500 }).data_order(value: :asc).map { |e| e.number + e.value }
  end
end)
puts 'TWO TABLES'
puts 'Sum each row columns in both'
puts (Benchmark.measure do
  DataItem.includes(:base).all.each { |e| total += e.base.number + e.value }
  # base_active.includes(:data_item).all.each { |e| total += e.number + e.data_item.value }
end)

puts 'Sum three random elements by number 1000 times'
puts (Benchmark.measure do
  1000.times do
    numbers = (1..3).to_a.map { |e| rand(12..98) }
    numbers.reduce(0) { |v, e| v + DataItem.includes(:base).where(bases: { number: e }).first&.value.to_i }
    # total += numbers.reduce(0) { |v, e| v + base_active.where(number: e).first.data_item.value }
  end
end)

puts 'Where value over 500 ordered no join'
puts (Benchmark.measure do
  10.times do
    DataItem.where('value > ?', 500).order(value: :asc).map(&:value)
  end
end)

puts 'Where value over 500 ordered with join'
puts (Benchmark.measure do
  10.times do
    DataItem.where('value > ?', 500).includes(:base).order(value: :asc).map { |e| e.base.number + e.value }
  end
end)

puts "SINGLE TABLE with #{SingleTable.column_names.count} cols, medium selects"
puts 'Sum each row columns in both'
puts (Benchmark.measure do
  single_active.select('number','value','type','name','title','store_id').each { |e| total += e.number + e.value }
end)

#RubyProf.start
puts 'Sum three random elements by number 1000 times'
puts (Benchmark.measure do
  1000.times do
    numbers = (1..3).to_a.map { |e| rand(12..98) }
    numbers.reduce(0) { |v, e| v + single_active.select('number','value','type','name','title','store_id').where(number: e).first&.value.to_i }
  end
end)
#result = RubyProf.stop
#printer = RubyProf::FlatPrinter.new(result)
#printer.print(STDOUT)
puts 'Where value over 500 ordered'
puts (Benchmark.measure do
  10.times do
    single_active.select('number','value','type','name','title','store_id').where('value > ?', 500).order(value: :asc).map { |e| e.number + e.value }
  end
end)

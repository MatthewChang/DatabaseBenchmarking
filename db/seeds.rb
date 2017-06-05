# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
times = Benchmark.measure do
  10_000.times do
    Base.create(name: SecureRandom.hex, number: rand(12..98), data_item: DataItem.create(title: SecureRandom.hex, value: rand(-1000..1000), store_id: rand(0..100)))
  end
end
puts 'Create Tables'
puts times

times = Benchmark.measure do
  10_000.times do
    Product.create(name: SecureRandom.hex, number: rand(12..98), title: SecureRandom.hex, value: rand(-1000..1000), store_id: rand(0..100))
  end
end
puts 'Create Json'
puts times

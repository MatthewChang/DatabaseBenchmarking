volume = 500000
rate = 0.1

times = Benchmark.measure do
  volume.times do
    active = (rand(0..1.0) < rate)
    attrs = { active: active, name: SecureRandom.hex, number: rand(12..98) }
    attrs = attrs.merge(title: SecureRandom.hex, value: rand(-1000..1000), store_id: rand(0..100)) if active
    attrs = attrs.merge(extra: SecureRandom.hex * (1 / rate)) unless active
    SingleTable.create(attrs)
  end
end
puts 'Create SingleTable'
puts times

times = Benchmark.measure do
  volume.times do
    active = (rand(0..1.0) < rate)
    data_item = active ? DataItem.create(title: SecureRandom.hex, value: rand(-1000..1000), store_id: rand(0..100)) : nil
    attrs = { active: active, name: SecureRandom.hex, number: rand(12..98), data_item: data_item }
    attrs = attrs.merge(extra: SecureRandom.hex * (1 / rate)) unless active
    Base.create(attrs)
  end
end
puts 'Create MultiTable'
puts times

times = Benchmark.measure do
  volume.times do
    active = (rand(0..1.0) < rate)
    attrs = { active: active, name: SecureRandom.hex, number: rand(12..98) }
    attrs = attrs.merge(title: SecureRandom.hex, value: rand(-1000..1000), store_id: rand(0..100)) if active
    attrs = attrs.merge(extra: SecureRandom.hex * (1 / rate)) unless active
    Product.create(attrs)
  end
end
puts 'Create Json'
puts times

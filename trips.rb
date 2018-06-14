require 'time'
require_relative 'driver'
require_relative 'trip'

drivers = []
trips = []

ARGV.each do |file|
  File.open(file).each do |line|
    if line.index('Driver') == 0
      d = Driver.new(line.split(" ")[1..line.split(" ").length].join(" "))
      drivers.push(d)
    elsif line.index('Trip') == 0
      trip = line.split(" ")
      t = Trip.new(trip[1], trip[2], trip[3], trip[4])
      trips.push(t)
      drivers.find {|x| x.name == t.name}.add_trip(t)
    end
  end
end

puts drivers
puts trips

drivers.each do |driver|
  driver.calculate_report
end

drivers.sort! {|x, y| y.total_distance <=> x.total_distance}

File.open("out.txt", "w") {|f|
  drivers.each do |driver|
    if driver.total_distance != 0
      f.puts("#{driver.name}: #{driver.total_distance} miles @ #{driver.avg_speed} mph ")
    else
      f.puts("#{driver.name}: #{driver.total_distance} miles")
    end
  end
}








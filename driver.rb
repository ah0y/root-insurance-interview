class Driver
  attr_accessor :trips, :name, :avg_speed, :total_distance, :total_time

  def initialize(name)
    @name = name
    @trips = []
    @total_distance = 0
    @total_time = 0
    @avg_speed = 0
  end

  def add_trip(trip)
    if trip.calculate_trip_time !=0 and trip.calculate_speed > 5 and trip.calculate_speed < 100
      self.trips << trip
    end
  end

  def calculate_report
    @total_time = self.trips.map {|x| x.calculate_trip_time}.inject(0) {|sum, x| sum + x}
    @total_distance = self.trips.map {|x|  x.miles }.inject(0) {|sum, x| sum + x}
    @avg_speed = (@total_distance / @total_time).round unless @total_time == 0 or @total_time.nil?
    @avg_speed
  end

end

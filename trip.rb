class Trip
  attr_accessor :name, :start, :stop, :miles, :total_time

  def initialize(name, start, stop, miles)
    @name = name
    @start = start
    @stop = stop
    @miles = miles.to_f.round
  end

  def calculate_trip_time
    @total_time = 0
    z = Time.parse(@stop)
    a = Time.parse(@start)
    @total_time = (z - a) / 3600 unless z - a < 0
    @total_time
  end

  def calculate_speed
    @hours = self.calculate_trip_time
    @mph = (@miles / @hours).round
  end
end
require 'sinatra'
require 'haml'
# require 'time'
require_relative 'driver'
require_relative 'trip'



get '/' do
  haml :index
end


post '/out' do
  unless params[:file] &&
      (tmpfile = params[:file][:tempfile]) &&
      (name = params[:file][:filename])
    @error = "No file selected"
    return haml(:index)
  end
  STDERR.puts "Uploading file, original name #{name.inspect}"
  while blk = tmpfile.read(65536)
    arr = blk.split("\n").select{ |x| x.size!= 1}.map{ |x| x.chomp}
    drivers = []
    trips = []
    arr.each do |line|
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

    drivers.each do |driver|
      driver.calculate_report
    end

    drivers.sort! {|x, y| y.total_distance <=> x.total_distance}


    # here you would write it to its final location
    STDERR.puts blk.inspect
  end
  haml(:out, :locals => {:drivers => drivers})
end
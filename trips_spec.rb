require 'rspec'
require 'time'
require_relative 'driver'
require_relative 'trip'


RSpec.describe "can't have 'bad' trip times" do

  it "can't divide total miles driven by 0" do
    d = Driver.new('abe')
    t = Trip.new('abe', '07:45', '07:45', 100)
    d.add_trip(t)
    expect(d.calculate_report).to eq(0)
  end


  it "can't have a stop time that comes before a start time" do
    d = Driver.new('abe')
    t = Trip.new('abe', '07:45', '07:15', 100)
    expect(t.calculate_trip_time).to eq(0)
    d.add_trip(t)
    d.calculate_report
    expect(d.total_distance).to eq(0)
    expect(d.avg_speed).to eq(0)
  end

  it "a trip with a stop time that comes before the start time doesn't mess up the average speed if there is another trip present" do
    d = Driver.new('abe')
    t = Trip.new('abe', '07:45', '07:15', 100)
    t2 = Trip.new('abe', '07:15', '07:45', 17.3)
    d.add_trip(t)
    d.add_trip(t2)
    expect(d.calculate_report).to eq(34)
  end

  it "can't add a trip time that averages more than 100mph or less than 5" do
    d = Driver.new('abe')
    t = Trip.new('abe', '07:15', '07:45', 100)
    t2 = Trip.new('abe', '07:45', '23:15', 10)
    d.add_trip(t)
    d.add_trip(t2)
    expect(d.trips.size).to eq(0)
  end

end





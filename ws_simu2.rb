require 'csv'
require './restroom'

frequency = 3
use_duration = 1
population_size = 200
facilities_per_restroom_range = 1..30
data = {}

facilities_per_restroom_range.each do |facilities_per_restroom|
    Person.population.clear
    population_size.times {Person.population << Person.new(frequency, use_duration)}
    data[facilities_per_restroom] = []
    restroom = Restroom.new facilities_per_restroom

    DURATION.times do |t|
        queue = restroom.queue.clone
        restroom.queue.clear
        data[facilities_per_restroom] << queue.size

        until queue.empty?
            restroom.enter queue.shift
        end

        Person.population.each do |person|
            if person.need_to_go?
                restroom.enter person
            end
        end
        restroom.tick
    end
    puts("now : facilities_per_restroom = #{facilities_per_restroom}")
end

puts("write csv...")

CSV.open('result_ws_simu2.csv', 'w') do |csv|
    lbl = []
    facilities_per_restroom_range.each {|facilities_per_restroom| lbl << facilities_per_restroom}
    csv << lbl

    DURATION.times do |t|
        row = []
        facilities_per_restroom_range.each do |facilities_per_restroom|
            row << data[facilities_per_restroom][t]
        end
        csv << row
    end
end

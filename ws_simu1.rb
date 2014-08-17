require 'csv'
require './restroom'

frequency = 3 # トイレにいく回数
facilities_per_restroom = 3 # トイレあたりの便器の数
use_duration = 1 # 一回にかかる時間
population_range = 10..600

data = {}
population_range.step(10).each do |population_size|
    Person.population.clear
    population_size.times {Person.population << Person.new(frequency, use_duration) }
    data[population_size] = []
    restroom = Restroom.new facilities_per_restroom
    
    DURATION.times do |t|
        data[population_size] << restroom.queue.size
        queue = restroom.queue.clone
        restroom.queue.clear

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
    puts "now : population_size = #{population_size}"
end

CSV.open('result_ws_simu1.csv', 'w') do |csv|
    lbl = []
    population_range.step(10).each {|population_size| lbl << population_size}
    csv << lbl
    DURATION.times do |t|
        row = []
        population_range.step(10).each do |population_size|
            row << data[population_size][t]
        end
        csv << row
    end
end



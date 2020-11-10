require "faker"
require "date"
require "csv"

# we already provide a filled out works_seeds.csv file, but feel free to
# run this script in order to replace it and generate a new one
# run using the command:
# $ ruby db/generate_seeds.rb
# if satisfied with this new works_seeds.csv file, recreate the db with:
# $ rails db:reset
# doesn't currently check for if titles are unique against each other

CSV.open("db/tasks_seeds.csv", "w", :write_headers => true,
         :headers => ["name", "description", "completed_at"]) do |csv|
  10.times do
    name = %w(homework household job family).sample
    description = Faker::Lorem.sentence
    completed_at = Faker::Date.between(from: Date.today - 2, to: Date.today)

    csv << [name, description, completed_at]
  end
end

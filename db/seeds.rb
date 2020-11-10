# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

TASK_FILE = Rails.root.join('db', 'tasks_seeds.csv')
puts "Loading tasks data from #{TASK_FILE}"

task_upload_failures = []
CSV.foreach(TASK_FILE, :headers => true) do |row|
  task = Task.new

  task.name = row['name']
  task.description = row['description']
  task.completed_at = row['completed_at']

  successful = task.save
  if !successful
    task_upload_failures << task
    puts "Failed to save task: #{task.inspect}"
  else
    puts "Created task: #{task.inspect}"
  end
end

puts "Added #{Task.count} task records"
puts "#{task_upload_failures.size} tasks failed to save"

puts "done"

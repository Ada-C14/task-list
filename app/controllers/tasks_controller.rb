TASKS = [{id: 0, name: "Unit 2: Ruby on Rails", description: "learn rails", due_date: "10-20-2020"}]

 class TasksController < ApplicationController
   def index
     @tasks = TASKS
   end

   def show
     @task = TASKS[0]
   end
 end
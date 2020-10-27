TASKS = ["finish homework", "clean room", "do laundry", "facetime with friends"]


class TasksController < ApplicationController
    def index 
        @tasks = TASKS 
    end
end

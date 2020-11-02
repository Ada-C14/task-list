require "test_helper"

describe TasksController do
  let (:task) {
    Task.create name: "sample task", description: "this is an example for a test",
    completed_at: Time.now + 5.days
  }
  
  # Tests for Wave 1
  describe "index" do
    it "can get the index path" do
      # Act
      get tasks_path
      
      # Assert
      must_respond_with :success
    end
    
    it "can get the root path" do
      # Act
      get root_path
      
      # Assert
      must_respond_with :success
    end
  end
  
  # Unskip these tests for Wave 2
  describe "show" do
    it "can get a valid task" do
      # Act
      get task_path(task.id)
      
      # Assert
      must_respond_with :success
    end
    
    it "will redirect for an invalid task" do
      # Act
      get task_path(-1)
      
      # Assert
      must_respond_with :redirect
    end
  end
  
  describe "new" do
    it "can get the new task page" do

      # Act
      get new_task_path
      
      # Assert
      must_respond_with :success
    end
  end
  
  describe "create" do
    it "can create a new task" do

      # Arrange
      task_hash = {
        task: {
          name: "new task",
          description: "new task description",
          completed_at: nil,
        },
      }
      
      # Act-Assert
      expect {
        post tasks_path, params: task_hash
      }.must_change "Task.count", 1
      
      new_task = Task.find_by(name: task_hash[:task][:name])
      expect(new_task.description).must_equal task_hash[:task][:description]
      expect(new_task.completed_at).must_equal task_hash[:task][:completed_at]
      
      must_respond_with :redirect
      must_redirect_to task_path(new_task.id)
    end
  end
  
  # Unskip and complete these tests for Wave 3
  describe "edit" do
    it "can get the edit page for an existing task" do
      get edit_task_path(task.id)
      must_respond_with :success
    end
    
    it "will respond with redirect when attempting to edit a nonexistant task" do
      # Your code here
      get edit_task_path(-1)
      must_respond_with :redirect
    end
  end
  
  describe "update" do
    # Note:  If there was a way to fail to save the changes to a task, that would be a great
    #        thing to test.

    before do
      @task_hash = {
          task: {
              name: task.name,
              description: "Updated description of task",
              completed_at: task.completed_at,
          }
      }
    end


    it "can update an existing task" do
      expect {
        patch task_path(task.id), params: @task_hash
      }.wont_change "Task.count"

      new_task = Task.find_by(name: @task_hash[:task][:name])
      expect(new_task.description).must_equal @task_hash[:task][:description]

      must_respond_with :redirect
      must_redirect_to task_path(task.id)
    end
    
    it "will redirect to the root page if given an invalid id" do

      expect {
        patch task_path(-1), params: @task_hash
      }.wont_change "Task.count"

      must_redirect_to root_path
    end
  end
  
  # Complete these tests for Wave 4
  describe "destroy" do

    before do
      @task2_hash = {task: {name: "sample task2", description: "this is a second example for a test", completed_at: Time.now + 6.days}}

      Task.create(name: @task2_hash[:task][:name], description: @task2_hash[:task][:description], completed_at: @task2_hash[:task][:description])
    end

    it "deletes a valid task" do
      task2 = Task.find_by(name: @task2_hash[:task][:name])
      expect {
        delete task_path(task2.id)
      }.must_differ 'Task.count', -1
    end


    it "will redirect to the not found page if given an invalid id" do
      expect {
        delete task_path(-1)
      }.wont_change 'Task.count'
      must_respond_with :redirect
      must_redirect_to task_not_found_path
    end

  end
  
  describe "toggle complete" do

    before do
      @task3_hash = {task: {name: "sample task 3", description: "description of task 3", completed_at: Time.now + 6.days}}

      Task.create(name: @task3_hash[:task][:name], description: @task3_hash[:task][:description], completed_at: @task3_hash[:task][:completed_at])


      @task3 = Task.find_by(name: @task3_hash[:task][:name])
    end

    it "removes completed_at time and saves nil to database when marked as Incomplete" do

      expect {
        patch toggle_task_complete_path(@task3)
      }.wont_change "Task.count"

      expect(@task3.reload.completed_at).wont_equal @task3_hash[:task][:completed_at]

      expect(@task3.completed_at).must_be_nil
    end

    it "saves completed_at time to database when marked as Complete" do
      @task3.completed_at = nil
      @task3.save

      expect {
        patch toggle_task_complete_path(@task3)
      }.wont_change "Task.count"

      expect(@task3.reload.completed_at).wont_equal @task3_hash[:task][:completed_at]

      expect(@task3.completed_at).wont_be_nil
    end

    it "will redirect to the not found page if given an invalid id" do
      expect {
        patch toggle_task_complete_path(-1)
      }.wont_change 'Task.count'

      must_respond_with :redirect
      must_redirect_to task_not_found_path
    end
  end
end

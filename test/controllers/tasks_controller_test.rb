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
      get edit_task_path(-1)
      must_respond_with :redirect
    end
  end
  
  # Uncomment and complete these tests for Wave 3
  describe "update" do
    before do
      @task_hash = {
          task: {
              name: task[:name],
              description: "Describe your task",
              completed_at: task[:completed_at],
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

  describe 'destroy' do
    it 'will destroy to permanently remove a task' do
      task
      expect {
        delete task_path(task.id)
      }.must_change 'Task.count', -1
    end

    it 'will redirect to root if task does not exist' do
      expect {
        delete task_path(-1)
      }.wont_change 'Task.count'

      must_respond_with :redirect
      must_redirect_to root_path
    end

  end

  # Complete for Wave 4
  describe 'toggle_complete' do
    before do

      @task_incomplete = Task.create(
          name: 'a new task',
          description: 'its time for a nap',
          completed_at: nil
      )

    end

    it 'can mark a task as complete' do
      expect {
        patch complete_task_path(@task_incomplete.id)
      }.wont_change 'Task.count'

      expect {
        patch complete_task_path(@task_incomplete.completed_at)
      }.wont_be_nil

      must_respond_with :redirect
      must_redirect_to root_path
    end

  end
end

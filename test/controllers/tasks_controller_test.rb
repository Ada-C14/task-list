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
    # Note:  If there was a way to fail to save the changes to a task, that would be a great
    #        thing to test.
    before do
      Task.create(name: "Cry in Bed", description: "Wahhhhhhhhhhhhhh")
    end

    let (:edit_task_hash) do
      {
          task: {
              name: "Sleep",
              description: "Zzzzzzzzzzzzzzz"
          }
      }
    end

    it "can update an existing task" do
      id = Task.first.id
      expect {
        patch task_path(id), params: edit_task_hash
      }.wont_change "Task.count"

      must_respond_with :redirect

      task = Task.find_by(id: id)
      expect(task.name).must_equal edit_task_hash[:task][:name]
      expect(task.description).must_equal edit_task_hash[:task][:description]
    end
    
    it "will redirect to the root page if given an invalid id" do
      # Your code here
      id = -1
      patch task_path(id), params: edit_task_hash
      must_redirect_to tasks_path
    end
  end
  
  # Complete these tests for Wave 4
  describe "destroy" do
    before do
      Task.create(name: "Cry in Bed", description: "Wahhhhhhhhhhhhhh")
    end

    # Your tests go here
    it "can destroy a task" do
      # Arrange
      id = Task.first.id

      # Act
      expect {
        delete task_path(id)
      }.must_change 'Task.count', -1

      task = Task.find_by(name: "Cry in Bed")

      expect(task).must_be_nil

      must_respond_with :redirect
      must_redirect_to tasks_path
    end

    it "will redirect to the root page if given an invalid id" do
      # Your code here
      id = -1
      delete task_path(id)
      must_redirect_to tasks_path
    end
  end
  
  # Complete for Wave 4
  describe "toggle_complete" do
    # Your tests go here
    before do
      Task.create(name: "Cry in Bed", description: "Wahhhhhhhhhhhhhh")
    end


    it "can update an existing task" do
      id = Task.first.id
      expect {
        patch complete_task_path(id)
      }.wont_change "Task.count"

      must_respond_with :redirect

      task = Task.find_by(id: id)
      expect(task.completed_at).must_be_instance_of ActiveSupport::TimeWithZone
    end

    it "can update an existing task" do
      Task.first.update(completed_at: Time.now)

      id = Task.first.id
      expect {
        patch complete_task_path(id)
      }.wont_change "Task.count"

      must_respond_with :redirect

      task = Task.find_by(id: id)
      expect(task.completed_at).must_be_nil
    end

    it "will redirect to the root page if given an invalid id" do
      # Your code here
      id = -1
      patch complete_task_path(id)
      must_redirect_to tasks_path
    end
  end
end
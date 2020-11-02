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

      # Assert
      must_respond_with :redirect
    end
  end
  
  # Uncomment and complete these tests for Wave 3
  describe "update" do
    before do
      Task.create(name: "old task name", description: "old task description", completed_at: "old day")
    end
    let (:updated_task_hash) {
      {
        task: {
          name: "updated task name",
          description: "updated task description",
          completed_at: "updated new day",
        }
      }
    }
    # Note:  If there was a way to fail to save the changes to a task, that would be a great
    #        thing to test.
    #
    it "won't change number of existing tasks" do
      task = Task.first
      expect {
        patch task_path(task.id), params: updated_task_hash
      }.wont_change "Task.count" # doesn't change number of existing tasks
    end

    it "can update an existing task" do
      task = Task.first
      patch task_path(task.id), params: updated_task_hash

      task = Task.find_by(id: task.id)
      expect(task.name).must_equal updated_task_hash[:task][:name]
      expect(task.description).must_equal updated_task_hash[:task][:description]
      expect(task.completed_at).must_equal updated_task_hash[:task][:completed_at]
    end

    it "will redirect to the root page if given an invalid id" do

      patch task_path(-1), params: updated_task_hash

      must_respond_with :redirect
      must_redirect_to tasks_path
    end
  end
  
  # Complete these tests for Wave 4
  describe "destroy" do
    before do
      Task.create(name: "old task name", description: "old task description", completed_at: "old day")
    end

    it "will reduce number of existing tasks by 1" do
      task = Task.first

      expect(task).must_be_instance_of Task

      expect {
        delete task_path(task.id)
      }.must_change "Task.count", -1
    end
  end
  
  # Complete for Wave 4
  describe "toggle_complete" do
    before do
      Task.create(name: "task name", description: "task description", completed_at: nil)
      Task.create(name: "task name", description: "task description", completed_at: "Sun Nov 01 at 11:04 PM")
    end

    it "won't change number of existing tasks" do
      task = Task.first
      expect {
        patch complete_task_path(task.id)
      }.wont_change "Task.count" # doesn't change number of existing tasks
    end

    it "will redirect to tasks_path" do
      task = Task.first

      patch complete_task_path(task.id)

      must_respond_with :redirect
      must_redirect_to tasks_path
    end

    it "toggles incomplete to complete" do
      task = Task.first

      patch complete_task_path(task.id)

      task.reload

      expect(task.completed_at).wont_be_nil
    end

    it "toggles complete to incomplete" do
      task = Task.last

      patch complete_task_path(task.id)

      task.reload

      expect(task.completed_at).must_be_nil
    end
  end
end

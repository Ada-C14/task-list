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
      
      editted_task = Task.find_by(name: task_hash[:task][:name])
      expect(editted_task.description).must_equal task_hash[:task][:description]
      expect(editted_task.completed_at).must_equal task_hash[:task][:completed_at]
      
      must_respond_with :redirect
      must_redirect_to task_path(editted_task.id)
    end
  end
  
  # Unskip and complete these tests for Wave 3
  describe "edit" do
    it "can get the edit page for an existing task" do

      # Act
      get edit_task_path(task.id)
      
      # Assert
      must_respond_with :success
    end
    
    it "will respond with redirect when attempting to edit a nonexistant task" do
      
      # Act
      get edit_task_path(-1)
      
      # Assert
      must_respond_with :redirect
    end
  end
  
  # Uncomment and complete these tests for Wave 3
  describe "update" do
    # Note:  If there was a way to fail to save the changes to a task, that would be a great
    #        thing to test.
    it "can update an existing task" do

      # Arrange

      get task_path(task.id)

      task_edit = {
        task: {
          name: "editted task name",
          description: "editted task description",
          completed_at: nil,
        },
      }
      
      # Act-Assert 

      expect {
        patch task_path(task.id), params: task_edit
      }.wont_change "Task.count"
      
      editted_task = Task.find_by(name: task_edit[:task][:name])
      expect(editted_task.description).must_equal task_edit[:task][:description]
      expect(editted_task.completed_at).must_equal task_edit[:task][:completed_at]
      
      must_respond_with :redirect
      must_redirect_to task_path(editted_task.id)
    end
    
    it "will redirect to the root page if given an invalid id" do
      id = -1

      expect {
        patch task_path(id), params: task
      }.wont_change "Task.count"

      must_respond_with :redirect
      must_redirect_to tasks_path
    end
  end
  
  # Complete these tests for Wave 4
  describe "destroy" do
    it "deletes a task that previously existed" do
    end
    
    it "redirects to root index after deleting said task" do
    end
    
    it "responds with 404 error if task is not found" do
    end  
    
  end
  
  # Complete for Wave 4
  describe "toggle_complete" do
    # Your tests go here
  end
end

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

    let (:edited_task_hash) {
      {
        task: {
          name: "edited task",
          description: "edited task description",
          completed_at: nil,
        },
      }
    }

    it "can update an existing task" do

      # Arrange

      get task_path(task.id)

      # Act-Assert 

      expect {
        patch task_path(task.id), params: edited_task_hash
      }.wont_change "Task.count"
      
      edited_task = Task.find_by(name: edited_task_hash[:task][:name])
      expect(edited_task.description).must_equal edited_task_hash[:task][:description]
      expect(edited_task.completed_at).must_equal edited_task_hash[:task][:completed_at]
      
      must_respond_with :redirect
      must_redirect_to task_path(edited_task.id)
    end
    
    it "will redirect to the root page if given an invalid id" do
      id = -1

      expect {
        patch task_path(id), params: edited_task_hash
      }.wont_change "Task.count"

      must_redirect_to root_path
    end
  end
  
  # Complete these tests for Wave 4
  describe "destroy" do
    it "deletes a task that previously existed, redirects to root path" do
      # Arrange
      get task_path(task.id)

      # Act-Assert
      expect {
        delete task_path(task.id)
      }.must_change "Task.count", -1

      not_there_task = Task.find_by(name: "sample task")
      expect(not_there_task).must_be_nil

      must_respond_with :redirect
      must_redirect_to root_path
    end
    
    it "responds with not_found if task is not found" do
       # Act
       delete task_path(-1)
      
       # Assert
       must_respond_with :not_found
    end  
    
  end
  
  # Complete for Wave 4
  describe "toggle_complete" do

    it "can mark an existing task complete (updates completed_at to current time) and redirect to root" do

      task_to_complete = Task.create(
        name: "create this existing task",
        description: "task description",
        completed_at: nil,
      )

      expect{
        patch toggle_path(task_to_complete.id)
      }.wont_change "Task.count"

      completed_task = Task.find_by(name:"create this existing task")

      expect(completed_task.completed_at).wont_be_nil
      expect(completed_task.completed_at).must_equal Date.current.to_s

      must_respond_with :redirect
      must_redirect_to root_path
      
    end
    
    it "can redirect if task id is not found" do
      id = -1

      patch toggle_path(id), params: {completed_at: Date.current}

      must_redirect_to root_path
    end

  end
end

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
      # skip
      # Act
      get task_path(task.id)
      
      # Assert
      must_respond_with :success
    end
    
    it "will redirect for an invalid task" do
      # skip
      # Act
      get task_path(-1)
      
      # Assert
      must_respond_with :redirect
    end
  end
  
  describe "new" do
    it "can get the new task page" do
      # skip
      
      # Act
      get new_task_path
      
      # Assert
      must_respond_with :success
    end
  end
  
  describe "create" do
    it "can create a new task" do
      # skip
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
      # skip
      # Your code here
      # # Act
      get edit_task_path(task.id)
      #
      # # Assert
      must_respond_with :success
    end
    
    it "will respond with redirect when attempting to edit a nonexistant task" do
      # skip
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
      # skip
      # Arrange
      old_task = task
      edited_task_hash = {
          task: {
              name: "edited task",
              description: "edited task description",
          },
      }
      # Act-Assert
      expect {
        patch task_path(old_task.id), params: edited_task_hash
      }.wont_change "Task.count" # won't change runs before the expect block

      edited_task = Task.find_by(id: old_task.id) ### expect name & description thank!
      expect(edited_task.name).must_equal edited_task_hash[:task][:name]
      expect(edited_task.description).must_equal edited_task_hash[:task][:description]

      must_respond_with :redirect
      must_redirect_to task_path(old_task.id)
    end
    
    it "will redirect to the root page if given an invalid id" do

      task_hash = {
          task: {
              name: "edited task",
              description: "edited task description",
              # completed_at: nil,
          },
      }
      patch task_path(-1), params: task_hash #an update should get params (:redierct for bad input or nil values)
      # expect {
      #   patch task_path(-1), params: task_hash
      # }.wont_change "Task.count"

      # Assert
      must_respond_with :redirect

    end
  end


  # Complete these tests for Wave 4
  describe "destroy" do

    it "can destroy an existing task & redirect" do
      # # Arrange
      delete_me_task = task

      # # Act-Assert
      expect {
        delete task_path(delete_me_task)
      }.must_change "Task.count", -1 # won't change runs before the expect block

      must_respond_with :redirect
      must_redirect_to tasks_path
    end
  end
  
  # Complete for Wave 4
  describe "toggle_complete" do
    it "can mark an existing task complete" do
      #This works, but I don't think it's testing what I want tested.
      toggle_task = task
      # # Act-Assert
      expect {
        patch completed_at_task_path(toggle_task.id)
      }.wont_change "Task.count" # won't change runs before the expect block

      expect(toggle_task.completed_at).wont_be_nil

      must_respond_with :redirect
      must_redirect_to tasks_path

      # # Arrange
      # incomplete_task_hash = {
      #     task: {
      #         name: "completed task",
      #         description: "completed task description",
      #         completed_at: nil,
      #     },
      # }
      # completed_task_hash = {
      #     task: {
      #         name: "completed task",
      #         description: "completed task description",
      #         completed_at: DateTime.now,
      #     },
      # }
      # # Act-Assert
      # expect {
      #   patch completed_at_task_path(incomplete_task_hash.id), params: completed_task_hash
      # }.wont_change "Task.count" # won't change runs before the expect block
      #
      # completed_task = Task.find_by(id: completed_task_hash) ### expect name & description thank!
      # expect(completed_task.name).must_equal completed_task_hash[:task][:name]
      # expect(completed_task.description).must_equal completed_task_hash[:task][:description]
      # expect(completed_task.completed_at).must_be completed_task_hash[:task][:completed_at]
      #
      # must_respond_with :redirect
      # must_redirect_to tasks_path(completed_task_hash.id)
    end
  end
end

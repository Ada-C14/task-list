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
  
  # Tests for Wave 2
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
  
#   Tests for Wave 3
  describe "edit" do
    it "can get the edit page for an existing task" do
      get edit_task_path(task)
      must_respond_with :success
    end

    it "will respond with redirect when attempting to edit a nonexistant task" do
      nonexistent_task_id = -1

      get edit_task_path(nonexistent_task_id)
      must_respond_with :redirect
    end
  end

  describe "update" do
    # Note:  If there was a way to fail to save the changes to a task, that would be a great thing to test.
    before do
      Task.create(name: "Go hiking", description: "Mossy Fern Forest", completed_at: "weekend")
    end

    let (:new_task_hash) {
      {
      task: {
        name: "Hike",
        description: "Snow-capped alpine peaks",
        completed_at: "Sunday"
      }
    }
  }

    it "can update an existing task" do
      task = Task.first

      expect {
        patch task_path(task.id), params: new_task_hash
      }.must_differ 'Task.count', 0

      must_redirect_to task_path(task.id)

      task = Task.find_by(id: task.id)
      expect(task.name).must_equal new_task_hash[:task][:name]
      expect(task.description).must_equal new_task_hash[:task][:description]
      expect(task.completed_at).must_equal new_task_hash[:task][:completed_at]
    end

    it "will redirect to the root page if given an invalid id but valid params" do
      invalid_task_id = -1

      expect {
        patch task_path(invalid_task_id), params: new_task_hash
      }.must_differ 'Task.count', 0

      must_respond_with :not_found
    end
  end
#
#   # Complete these tests for Wave 4
#   describe "destroy" do
#     # Your tests go here
#
#   end
#
#   # Complete for Wave 4
#   describe "toggle_complete" do
#     # Your tests go here
#   end
end

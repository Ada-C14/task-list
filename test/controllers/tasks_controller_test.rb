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
      must_redirect_to tasks_path(new_task.id)
    end
  end

  # Unskip and complete these tests for Wave 3
  describe "edit" do
    it "can get the edit page for an existing task" do

      # Your code here
    end

    it "will respond with redirect when attempting to edit a nonexistant task" do

      # Your code here
    end
  end

  # Uncomment and complete these tests for Wave 3
  describe "update" do
    before do
      Task.create(name: "new task", description: "new description", completed_at: nil)
    end

    let(:new_task_hash) {
      {
          task: {
              name: "new task",
              description: "new task description",
              completed_at: nil,
          },
      }
    }
    it "can update an existing task" do
      id = Task.first.id
      expect {
        patch task_path(id), params: new_task_hash
      }.wont_change "Task.count"

      must_respond_with :redirect

      task = Task.find_by(id: id)
      expect(task.name).must_equal new_task_hash[:task][:name]
      expect(task.description).must_equal new_task_hash[:task][:description]
      expect(task.completed_at).must_equal new_task_hash[:task][:completed_at]
    end

    # Note:  If there was a way to fail to save the changes to a task, that would be a great
    #        thing to test.
    it "will redirect to the root page if given an invalid id" do
      id = -1

      expect {
        patch task_path(id), params: new_task_hash
      }.wont_change "Task.count"

      must_respond_with :redirect
      must_redirect_to root_path
    end
  end

  # Complete these tests for Wave 4
  describe "destroy" do
    it "can destroy a task" do
      # Arrange
      task_title_to_delete = "Test task"
      task_to_delete = Task.create(name: task_title_to_delete, description: "test description", completed_at: nil)

      # Act
      expect {
        delete task_path(task_to_delete.id)
      }.must_change "Task.count", -1

      deleted_task = Task.find_by(name: task_title_to_delete)
      expect(deleted_task).must_be_nil

      must_respond_with :redirect
      must_redirect_to tasks_path
    end

    it "should not delete non existing book" do
      expect {
        delete task_path(-1)
      }.wont_change "Task.count"

      must_respond_with :not_found
    end

  end

  # Complete for Wave 4
  describe "toggle_complete" do
    # Your tests go here
  end
end
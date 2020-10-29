require "test_helper"
require "minitest/skip_dsl"

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
      get task_path(task)

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

      # #Act
      get task_path(task)

      # Assert
      must_respond_with :ok
    end

    it "will respond with redirect when attempting to edit a nonexistant task" do

      # Act
      get task_path(-1)

      # Assert
      must_respond_with :redirect

    end
  end

  # Uncomment and complete these tests for Wave 3
  describe "update" do
    # Note:  If there was a way to fail to save the changes to a task, that would be a great thing to test.
    it "Does not change count and redirects to task_path when task id is valid" do

      # Arrange
      Task.create(name: "Get Coffee", description: "With my friend at Bellevue Mall", completed_at: "10/31/1010")
      task_hash = {
          task: {
              name: "Hair Cut",
              description: "Go to Fairwood Hairstylist",
              completed_at: "10/29/1010"
          },
      }
      task = Task.first

      # Act-Assert
      expect {
        patch task_path(task.id), params: task_hash
      }.must_differ "Task.count", 0

      must_redirect_to task_path
      expect(Task.last.name).must_equal task_hash[:task][:name]
      expect(Task.last.description).must_equal task_hash[:task][:description]
      expect(Task.last.completed_at).must_equal task_hash[:task][:completed_at]
    end

    it "will redirect to the root page if given an invalid id" do
      # Arrange
      Task.create(name: "Get Coffee", description: "With my friend at Bellevue Mall", completed_at: "10/31/1010")
      task_hash = {
          task: {
              name: "Hair Cut",
              description: "Go to Fairwood Hairstylist",
              completed_at: "10/29/1010"
          },
      }
      task = Task.first

      # Act-Assert
      expect {
        patch task_path(-1), params: task_hash
      }.must_differ "Task.count", 0

      must_respond_with :not_found

  end
  end

  # # Complete these tests for Wave 4
  # xdescribe "destroy" do
  #   # Your tests go here
  #
  # end
  #
  # # Complete for Wave 4
  # xdescribe "toggle_complete" do
  #   # Your tests go here
  # end

end
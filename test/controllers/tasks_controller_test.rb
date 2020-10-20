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
      get "/tasks"

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

    it "will respond with not_found" do
      # Act
      get task_path(-1)

      # Assert
      must_respond_with :not_found
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

  describe "edit" do
    it "can get the edit page for an existing task" do
      get edit_task_path(task.id)
      must_respond_with :success
    end

    it "will respond with not_found when attempting to edit a nonexistant task" do
      get edit_task_path(-1)
      must_respond_with :not_found
    end
  end

  describe "update" do
    before do
      @task = task
      @task_hash = {
        task: {
          name: "new task",
          description: "new task description",
          completed_at: nil,
        },
      }
    end

    it "can update an existing task" do
      expect {
        patch task_path(@task.id), params: @task_hash
      }.must_differ "Task.count", 0

      #making sure it gets saved
      expect(Task.last.name).must_equal @task_hash[:task][:name]
      expect(Task.last.description).must_equal @task_hash[:task][:description]
      expect(Task.last.completed_at).must_equal @task_hash[:task][:completed_at]

      must_respond_with :redirect
      must_redirect_to task_path(Task.last.id)
    end

    it "will respond with not_found when given an invalid id" do
      patch task_path(-1)
      must_respond_with :not_found
    end
  end

  # Complete these tests for Wave 4
  describe "destroy" do
    it "removes a task with a valid id" do
      test_task = Task.create(name: "test task", description: "test task description", completed_at: "test task not completed")

      expect {
        delete task_path(test_task.id)
      }.must_differ "Task.count", -1

      must_redirect_to root_path
    end

    it "will respond with not_found when given an invalid id" do
      delete task_path(-1)
      must_respond_with :not_found
    end
  end

  # Complete for Wave 4
  describe "mark_complete" do
    before do
      @task = Task.create(name: "test task", description: "test task description", completed_at: "")
    end

    it "can mark an existing task as completed on the day the button was clicked" do
      expect {
        patch mark_complete_path(@task.id)
      }.must_differ "Task.count", 0

      expect(Task.last.completed_at).must_equal Date.today.to_s

      must_respond_with :redirect
      must_redirect_to root_path
    end

    it "will respond with not_found when given an invalid id" do
      patch mark_complete_path(-1)
      must_respond_with :not_found
    end
  end
end

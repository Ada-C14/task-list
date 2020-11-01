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
      task_params = {
          task: {
              name: "new task",
              description: "new task description",
              completed_at: nil,
          },
      }

      # Act-Assert
      expect {
        post tasks_path, params: task_params
      }.must_change "Task.count", 1

      new_task = Task.find_by(name: task_params[:task][:name])
      expect(new_task.description).must_equal task_params[:task][:description]
      expect(new_task.completed_at).must_equal task_params[:task][:completed_at]

      must_respond_with :redirect
      must_redirect_to task_path(new_task.id)
    end
  end

  # Wave 3
  describe "edit" do
    it "can get the edit page for an existing task" do
      get edit_task_path(task.id)
      must_respond_with :success
    end

    it "will respond with redirect when attempting to edit a nonexistant task" do
      get edit_task_path(-1)
      must_respond_with :redirect
      must_redirect_to tasks_path
    end
  end

  describe "update" do
    # Note:  If there was a way to fail to save the changes to a task, that would be a great thing to test.
    before do
      @update_params = {
          task: {
              name: "updated name",
              description: "updated description",
              completed_at: nil,
          },
      }
    end

    it "can update an existing task" do

      # Act-Assert
      expect {
        patch task_path(task.id), params: @update_params
      }.must_change "Task.count", 0

      updated_task = Task.find_by(id: task.id)

      expect(updated_task.name).must_equal @update_params[:task][:name]
      expect(updated_task.description).must_equal @update_params[:task][:description]
      expect(updated_task.id).must_equal task.id

      must_respond_with :redirect
      must_redirect_to tasks_path
    end

    it "will do something if the updates fail to save" do
      # will not save if required columns (i.e. "name")
      # expect to redirect
    end

    it "will redirect to the root page if given an invalid id" do
      id = -1

      expect {
        patch task_path(id), params: @update_params
      }.wont_change "Task.count"

      must_respond_with :redirect
      must_redirect_to tasks_path
    end
  end

  # Complete these tests for Wave 4
  describe "destroy" do
    it "can destroy a task" do

      id = task.id

      # Act
      expect {
        delete task_path(id)
      }.must_change 'Task.count', -1

      deleted = Task.find_by(name: "sample task")

      expect(deleted).must_be_nil

      must_respond_with :redirect
      must_redirect_to tasks_path
    end

    it "will redirect to the root page if given an invalid id" do
      id = -1

      expect {
        delete task_path(id)
      }.wont_change "Task.count"

      must_respond_with :redirect
      must_redirect_to tasks_path
    end
  end

  # Complete for Wave 4
  describe "toggle_complete" do

    let (:incomplete_task) {
      Task.create name: "incomplete task", description: "a task in progress",
                  completed_at: nil
    }

    it "can set completed_at to today's date" do

      id = incomplete_task.id

      expect {
        patch mark_complete_path(id)
      }.wont_change "Task.count"

      toggle_task = Task.find_by(id: id)

      expect(toggle_task.completed_at).must_equal Date.today

      must_respond_with :redirect
      must_redirect_to task_path(toggle_task.id)
    end

    it "can set completed_at to nil if task is completed" do

      id = task.id

      expect {
        patch mark_complete_path(id)
      }.wont_change "Task.count"

      toggle_task = Task.find_by(id: id)

      expect(toggle_task.completed_at).must_be_nil

      must_respond_with :redirect
      must_redirect_to task_path(toggle_task.id)
    end

  end
end

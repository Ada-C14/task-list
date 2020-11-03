require "test_helper"

describe TasksController do

  before do
      @task = Task.create(name: "Original name", description: "Original description", completed_at: "Original Date")
  end

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
      # # Act
      # get task_path(task.id)
      valid_task_id = @task.id
      get task_path(valid_task_id)
      must_respond_with :success
    end

    it "will redirect for an invalid task" do
      get task_path(-1)
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
      # Your code here
      valid_task_id = @task.id
      get edit_task_path(valid_task_id)
      must_respond_with :success
    end

    it "will respond with redirect when attempting to edit a nonexistant task" do
      # Your code here
      get edit_task_path(-1)
      must_respond_with :redirect
    end
  end

  # Uncomment and complete these tests for Wave 3
  describe "update" do
    # Note:  If there was a way to fail to save the changes to a task, that would be a great
    #        thing to test.
    before do
      @task_hash = {
          task: {
              name: "New name",
              description: "New description",
              completed_at: "New date"
          }
      }
    end

    it "can update an existing task" do
      # Your code here
      expect {
        patch task_path(@task.id), params: @task_hash
      }.must_differ 'Task.count', 0

      must_redirect_to tasks_path

      updated_task = Task.find(@task.id)
      expect(updated_task.name).must_equal @task_hash[:task][:name]
      expect(updated_task.description).must_equal @task_hash[:task][:description]
      expect(updated_task.completed_at).must_equal @task_hash[:task][:completed_at]

    end

    it "will redirect to the root page if given an invalid id" do
      # Your code here

      expect {
        patch task_path(-1), params: @task_hash
      }.must_differ 'Task.count', 0

      must_redirect_to tasks_path
      # must_respond_with :not_found
    end

  end

  # Complete these tests for Wave 4
  describe "destroy" do
    # Your tests go here
    it "can destroy a model" do
      task1 = Task.new name: "Eat a snack", description: "fruits", completed_at: "today"

      task1.save
      id = task1.id

      expect {
        delete task_path(id)
      }.must_change 'Task.count', -1

      task1 = Task.find_by(name: "Eat a snack")
      expect(task1).must_be_nil

      must_respond_with :redirect
      must_redirect_to tasks_path
    end

    it "will respond with not_found for invalid ids" do
      expect{
        delete task_path(-1)
      }.wont_change "Task.count"

      must_respond_with :not_found
    end

  end


  # Complete for Wave 4
  describe "toggle_complete" do
    # Your tests go here

    it "can update an existing task's status from completed to not completed" do
      # Your code here
      expect {
        post task_done_path(@task.id)
      }.must_differ 'Task.count', 0

      must_redirect_to tasks_path

      updated_task = Task.find(@task.id)
      expect(updated_task.completed_at).must_equal "Not completed yet"
    end

    it "can update an existing task's status from not completed to completed" do
      # Your code here
      task2 = Task.create(name: "Original name", description: "Original description", completed_at: "Not completed yet")

      expect {
        post task_done_path(task2.id)
      }.must_differ 'Task.count', 0

      must_redirect_to tasks_path

      updated_task = Task.find(task2.id)
      expect(updated_task.completed_at).must_be_instance_of String

      # if parse doesn't work on the string, then it's not a string formed from a Time instance
      Time.parse(updated_task.completed_at)

    end

  end
end
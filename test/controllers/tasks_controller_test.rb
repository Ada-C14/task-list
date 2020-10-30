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

    it "will redirect to the tasks_path" do

      task_params = {
        task: {
          name: "Finish homework",
          description: "Complete the task list project",
          completed_at: "today"
        }
      }

      post tasks_path, params: task_params

      new_task = Task.find_by(name: task_params[:task][:name])

      must_redirect_to task_path(new_task.id)
    end

    it "will add a new task to the database" do
      task_params = {
        task: {
          name: "Finish homework",
          description: "Complete the task list project",
          completed_at: "today"
        }
      }

      task_count = Task.count

      post tasks_path, params: task_params

      new_task_count = Task.count

      expect(new_task_count - task_count). must_equal 1
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

      must_respond_with :redirect
    end
  end

  # Uncomment and complete these tests for Wave 3
  describe "update" do
    # Note:  If there was a way to fail to save the changes to a task, that would be a great
    #        thing to test.
    before do
      Task.create(name: "Finish homework", description: "Complete the task list project", completed_at: "10/29/2020")
    end
    let (:new_task_hash) {
      {
        task: {
          name: "Pay tuition",
          description: "Hamza's school tuition",
          completed_at: nil,
        }
      }
    }
    it "can update an existing task" do
      id = Task.first.id
      expect {
        patch task_path(id), params: new_task_hash
      }.wont_change "Task.count"

      must_redirect_to task_path(id)

      task = Task.find_by(id: id)
      expect(task.name).must_equal new_task_hash[:task][:name]
      expect(task.description).must_equal new_task_hash[:task][:description]
      expect(task.completed_at).must_equal new_task_hash[:task][:completed_at]
    end

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
    it "can destroy a model" do
      # Arrange
      new_task = Task.create(name: "Eat lunch", description: "Eat lunch on TIME everyday", completed_at: nil)

      new_task.save

      id = new_task.id

      # Act
      expect {
        delete task_path(id)

        # Assert
      }.must_change 'Task.count', -1

      must_respond_with :redirect
      must_redirect_to root_path
    end

    it "will respond :not_found for an invalid id" do
      id = -1

      expect {
        delete task_path(id)
      }.wont_change "Task.count"

      must_respond_with :not_found
    end
  end

  # Complete for Wave 4
  describe "toggle_complete" do
    it "will respond with a not_found for an invalid id" do

      id = -1

      patch toggle_complete_path(id)

      must_respond_with :not_found

    end

    it "can switch an incomplete task to a completed task" do
      new_task = Task.create(name: "Fold laundry", description: "Finish weekly laundry folds by Sat evening", completed_at: nil)

      id = new_task.id

      patch toggle_complete_path(id)

      task = Task.find_by(id: id)

      expect(task.completed_at).must_equal Date.today.to_s

      must_redirect_to root_path
    end
  end
end

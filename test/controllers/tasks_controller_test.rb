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
      #skip
      # Act
      get task_path(task.id)
      
      # Assert
      must_respond_with :success
    end
    
    it "will redirect for an invalid task" do
      #skip
      # Act
      get task_path(-1)
      
      # Assert
      must_respond_with :redirect
    end
  end
  
  describe "new" do
    it "can get the new task page" do
      #skip
      
      # Act
      get new_task_path
      
      # Assert
      must_respond_with :success
    end
  end
  
  describe "create" do
    it "can create a new task" do
      #skip
      
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

      pp Task.all
      new_task = Task.find_by(name: task_hash[:task][:name]) ## used to be stored under title label not name
      expect(new_task.description).must_equal task_hash[:task][:description]
      expect(new_task.completed_at).must_equal task_hash[:task][:completed_at]
      
      must_respond_with :redirect
      must_redirect_to task_path(new_task.id)
    end
  end
  
  # Unskip and complete these tests for Wave 3
  describe "edit" do
    it "can get the edit page for an existing task" do
      #skip
      get edit_task_path(task.id)

      must_respond_with :success
    end
    
    it "will respond with redirect when attempting to edit a nonexistant task" do
      #skip
      get edit_task_path(-1)

      must_respond_with :redirect
    end
  end

  # Uncomment and complete these tests for Wave 3
  describe "update" do
    # Note:  If there was a way to fail to save the changes to a task, that would be a great
    #        thing to test.

    before do
      Task.create(name: "Hiking", description: "Mountains", completed_at: nil)
    end

    it "can update an existing task" do
      newest_task_id = Task.last.id

      updated_newest_task = {
          task: {
              name: "Jogging",
              description: "Around town.",
              completed_at: nil
          }
      }

      expect {
        patch update_task_path(newest_task_id), params: updated_newest_task
      }.wont_change 'Task.count'

      after_updating = Task.find_by(id: newest_task_id)

      expect( after_updating.name ).must_equal updated_newest_task[:task][:name]
      expect( after_updating.description ).must_equal updated_newest_task[:task][:description]
      expect( after_updating.completed_at ).must_equal updated_newest_task[:task][:completed_at]


    end

    
    it "will redirect to the root page if given an invalid id" do
      patch task_path(-1)
      must_respond_with :redirect
    end
  end
  
  # Complete these tests for Wave 4
  describe "destroy" do

    it "deletes a task if given a valid id" do
      existing_task = Task.first

      expect {
        delete task_path(existing_task)
      }.must_change 'Task.count', 1

      must_respond_with :redirect
      must_redirect_to tasks_path
    end

    it "should render not found if given an invalid id" do
      # Act
      delete destroy_task_path(-1)

      # Assert
      must_respond_with :not_found

    end
  end

  # Complete for Wave 4
  describe "toggle_complete" do
    it "should mark task as complete" do
      sample_task = Task.create(name: "Hiking", description: "mountains", completed_at: nil)

      expect {
        patch complete_task_path(sample_task)
      }.wont_change "Task.count"

      sample_task = Task.find_by(name: "Hiking")
      expect(sample_task.completed_at).wont_be_nil

      must_respond_with :redirect
      must_redirect_to tasks_path
    end

    it "should redirect to the tasks path if task is not found" do

      expect {
        patch complete_task_path(-1)
      }.wont_change "Task.count"

      must_respond_with :not_found
    end

  end
end

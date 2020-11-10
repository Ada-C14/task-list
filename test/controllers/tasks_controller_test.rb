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
      must_redirect_to task_path(new_task.id)
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
      must_redirect_to tasks_path
    end
  end
  
  # Uncomment and complete these tests for Wave 3
  describe "update" do
    let (:update_task) {
      {
        task: {
          name: "new task",
          description: "new task description",
          completed_at: nil,
        },
      }
    }
    # Note:  If there was a way to fail to save the changes to a task, that would be a great
    #        thing to test.
    it "can update an existing task" do    
      # Arrange
      id = task.id
      # Act-Assert
      expect {
        patch task_path(id), params: update_task
      }.wont_change 'Task.count'
      
      must_redirect_to task_path(task.id)

      new_task = Task.find_by(id: task.id)
      expect(new_task.name).must_equal update_task[:task][:name]
      expect(new_task.description).must_equal update_task[:task][:description]
      expect(new_task.completed_at).must_equal update_task[:task][:completed_at]
    end
    
    it "will redirect to the root page if given an invalid id" do
      # Act
      patch task_path(-1), params: update_task 

      # Assert
      must_redirect_to tasks_path
    end

    it "will fail to save the bad changes to a task" do
      # Arrange
      bad_data = {
        task: {
          re_name: "new task",
          completed: false,
          re_completed_at: "it's a test",
        },
      }

      original_task = Task.find_by(id: task.id)

      # Act-Assert
      expect {
        patch task_path(original_task.id), params: bad_data
      }.wont_change 'Task.count'

      task.reload
      expect(task.name).must_equal original_task.name
      expect(task.description).must_equal original_task.description
      expect(task.completed_at).must_equal original_task.completed_at
    end
  end
  
  # Complete these tests for Wave 4
  describe "destroy" do
    it "will redirect to the root page for the non-existent task" do
      expect {
        delete task_path(-1)
      }.wont_change "Task.count"

      must_redirect_to tasks_path
    end

    it "can delete an existing task and redirect to the tasks page" do
      # Act & Assert
      deleted_task = task.name
      
      expect { 
        delete task_path(task.id)
      }.must_differ "Task.count", -1

      check_deleted_task = Task.find_by(name: deleted_task)
      expect(check_deleted_task).must_be_nil

      must_redirect_to tasks_path
    end
  end
  
  # Complete for Wave 4
  describe "toggle_complete" do
    let (:task2) {
    Task.create name: "sample task", description: "this is an example for a test",
    completed_at: nil
    }
    let (:complete_task2) {
      {
        task: {
          name: "sample task",
          description: "this is an example for a test",
          completed_at: Time.now.strftime("%Y-%m-%d at %I:%M %p"),
        },
      }
    }
    let (:imcomplete_task2) {
      {
        task: {
          name: "sample task",
          description: "this is an example for a test",
          completed_at: nil,
        },
      }
    }
    it "will redirect to the root page for the non-existent task" do
      patch complete_task_path(-1)

      must_redirect_to tasks_path
    end

    it "will mark an existing task a complete time and redirect to the tasks page" do
      # Act 
      patch complete_task_path(task2.id), params: complete_task2

      # Assert
      task2.reload
      expect(task2.completed_at).must_equal Time.now.strftime("%Y-%m-%d at %I:%M %p")
      must_redirect_to tasks_path
    end

    it "will unmark an existing task to nil and redirect to the tasks page" do
      # Act 
      patch complete_task_path(task2.id), params: complete_task2 # mark the task completed
      task2.reload
      patch complete_task_path(task2.id), params: imcomplete_task2 # unmark the task

      # Assert
      task2.reload
      expect(task2.completed_at).must_be_nil
      must_redirect_to tasks_path
    end
  end
end

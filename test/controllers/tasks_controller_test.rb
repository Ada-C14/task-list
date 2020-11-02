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
      get root_path #"/tasks"

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
      get edit_task_path(task.id)

      # Assert
      must_respond_with :success
    end
    
    it "will respond with redirect when attempting to edit a nonexistant task" do
      #skip
      # Act
      get task_path(-1)

      # Assert
      must_respond_with :redirect
    end
  end
  
  # Uncomment and complete these tests for Wave 3
  describe "update" do
    # Note:  If there was a way to fail to save the changes to a task, that would be a great
    #        thing to test.

    before do
      Task.create(name: "Watch halloween movie", description: "nightmare before christmas and corpse bride", completed_at: "10/30/2020 7:30pm")
    end

    let (:new_task_hash) {
      {
        task: {
            name: "Dress up as boyfriend for Halloween",
            description: "draw on eyebrows, beard, and sit in his gaming chair to surprise him",
            completed_at: "10/30/2020 10:40pm"
        }
      }
    }

    it "can update an existing task" do
      # Your code here
      #
      task = Task.first
      expect {
        patch task_path(task.id), params: new_task_hash
      }.wont_change "Task.count"

      must_redirect_to task_path(task.id)

      task = Task.find_by(id: task.id)
      expect(task.name).must_equal new_task_hash[:task][:name]
      expect(task.description).must_equal new_task_hash[:task][:description]
      expect(task.completed_at).must_equal new_task_hash[:task][:completed_at]
    end
    
    it "will redirect to the root page if given an invalid id" do
      # Your code here
      get task_path(-1)

      # Assert
      must_respond_with :redirect
    end
  end
  
  # Complete these tests for Wave 4
  describe "destroy" do
    # Your tests go here

    it "will not change db with an invalid ID" do

      expect {
        delete task_path(-1)
      }.wont_change 'Task.count'
    end

    it "can destroy a model" do
      # Arrange
      #
      Task.create(name: "Try to see if this test works", description: "not going well so far", completed_at: "11/01/2020 5:00pm")

      sacrificial_task = Task.first

      id = sacrificial_task.id

      # Act
      expect {
        delete task_path(id)

        # Assert
      }.must_change 'Task.count', -1

      after_sacrifice = Task.find_by(name: "We'll See if this Works")

      expect(after_sacrifice).must_be_nil

      must_respond_with :redirect
      must_redirect_to tasks_path
    end

  end
  
  # Complete for Wave 4
  describe "toggle_complete" do
    # Your tests go here
    #
    it "will not change db with an invalid ID" do

      expect {
        complete_task_path(-1)
      }.wont_change 'Task.count'

      expect {
        incomplete_task_path(-1)
      }.wont_change 'Task.count'
    end

    it "will not change count, but will edit corerctly " do
      Task.create(name: "Task starting at complete", description: "task_a", completed_at: "complete")
      Task.create(name: "Task starting at incomplete", description: "task_b", completed_at: "")


      task_a = Task.find_by(description: "task_a")
      task_b = Task.find_by(description: "task_b")

      expect {
        patch incomplete_task_path(task_a.id)
      }.wont_change 'Task.count'

      expect {
        patch complete_task_path(task_b.id)
      }.wont_change 'Task.count'

      post_incomplete = Task.find_by(description: "task_a")
      post_complete = Task.find_by(description: "task_b")

      expect(post_complete).wont_be_nil
      expect(post_incomplete).wont_be_nil

      expect(post_incomplete.completed_at).must_equal ""
      expect(post_complete.completed_at).wont_equal ""

      must_respond_with :redirect
      must_redirect_to tasks_path
    end

  end
end
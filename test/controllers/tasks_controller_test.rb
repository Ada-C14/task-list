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
    before do 
      @task = Task.create(name: "hello world")
    end

    # it "will get show for valid ids" do
    #   # Arrange
    #   valid_task_id = @task.id

    #   # Act
    #   get "/tasks/#{valid_task_id}"

    #   # Assert
    #   must_respond_with :success
    # end

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
      task = Task.create(name: 'Clean up the kitchen', description: 'Wash the sink, floors')
      get edit_task_path(task.id)
      
      # Assert
      must_respond_with :success
    end
    
    it "will respond with redirect when attempting to edit a nonexistant task" do
      # Act
      get edit_task_path(-1)
      
      # Assert
      must_respond_with :redirect
   end
  end
  
  # Uncomment and complete these tests for Wave 3
  describe "update" do
    before do
      Task.create(name: 'Clean up the kitchen', description: 'Wash the sink, floors')
    end

    # Note:  If there was a way to fail to save the changes to a task, that would be a great
    #        thing to test.
    it "can update an existing task" do
      #arrange
      updated_task_hash = {
          task: {
            name: "Do nothing, relax",
            description: "You deserve it",
            completed_at: "never",
          }
      }
      task = Task.first

      #act
      expect {
        patch task_path(task.id), params: updated_task_hash
      }.wont_change "Task.count"

      #assert
      must_redirect_to task_path

      task = Task.find_by(id: task.id)
      expect(task.name).must_equal updated_task_hash[:task][:name]
    end
    
    it "will responde with not found if given an invalid id" do
      updated_task_hash = {
          task: {
            name: 'Do nothing, relax',
            description: 'You deserve it',
            completed_at: 'never',
        }
      }
      expect {
        patch task_path(-1), params: updated_task_hash
      }.wont_change "Task.count"

      must_respond_with :not_found
    end
  end
  
  # Complete these tests for Wave 4
  describe "destroy" do
    it "can destroy a model and redirect to the index page" do
      #arrange

      task_to_delete = Task.new(name: "Task for tests")
      task_to_delete.save
      id = task_to_delete.id

      #act
      expect {
        delete task_path(id)
      #assert
      }.must_change 'Task.count', -1

      task_to_delete = Task.find_by(name: "Task for tests")
      expect(task_to_delete).must_be_nil

      must_respond_with :redirect
      must_redirect_to tasks_path
    end

    it "will respond with not_found for nonexisting tasks id" do
      expect {
        delete task_path(-1)
      }.wont_change "Task.count"

      must_respond_with :not_found
    end  
  end
  
  # Complete for Wave 4
  describe "complete" do
    before do
      Task.create(name: 'Completion check', description: 'If task is complete, there is a timestamp')
    end
    it "can add a timestamp in the completed_at field and redirect to root path" do
      #arrange
      task = Task.first

      #act
      expect {
        patch complete_task_path(task.id)
      }.wont_change "Task.count"

      #assert
      must_redirect_to tasks_path
      task = Task.find_by(id: task.id)
      expect(task.completed_at).must_equal Time.now.strftime("%m/%d/%Y")
    end

    it "will respond with not_found for nonexisting tasks id" do
      expect {
        patch complete_task_path(-1)
      }.wont_change "Task.count"

      must_respond_with :not_found
    end
  end
end

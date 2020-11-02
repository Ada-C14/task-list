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
      must_redirect_to error_path(error: 'Task not found!')
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
    before do
      @task_hash = {
          task: {
              name: 'cat',
              description: 'cat',
              completed_at: 'cat'
          }
      }
    end

    it "can get the edit page for an existing task" do
      post tasks_path, params: @task_hash
      task_id = Task.find_by(name: 'cat').id

      get edit_task_path(id: task_id)

      must_respond_with :success
    end
    
    it "will respond with redirect when attempting to edit a nonexistant task" do
      get edit_task_path(id: -1)

      must_redirect_to error_path(error: 'Task to edit not found!')
    end
  end
  
  # Uncomment and complete these tests for Wave 3
  describe "update" do
    before do
      @task_hash = {
          task: {
              name: 'cat',
              description: 'cat',
              completed_at: 'cat'
          }
      }
      @new_hash = {
          task: {
              name: 'cat',
              description: 'dog',
              completed_at: 'dog'
          }
      }
      post tasks_path, params: @task_hash

    end
    # Note:  If there was a way to fail to save the changes to a task, that would be a great
    #        thing to test.
    it "can update an existing task (PUT)" do
      task = Task.first

      expect {
        put task_path(task.id), params: @new_hash
      }.wont_change "Task.count"

      task.reload
      expect(task.name).must_equal @new_hash[:task][:name]
      expect(task.description).must_equal @new_hash[:task][:description]
      expect(task.completed_at).must_equal @new_hash[:task][:completed_at]
    end

    it 'can update an existing task (PATCH)' do
      task = Task.first

      expect {
        patch task_path(task.id), params: {task: { description: 'dog', completed_at: 'dog'} }
      }.wont_change "Task.count"

      task.reload
      expect(task.name).must_equal @new_hash[:task][:name]
      expect(task.description).must_equal @new_hash[:task][:description]
      expect(task.completed_at).must_equal @new_hash[:task][:completed_at]
    end
    
    it "will redirect to the root page if given an invalid id" do
      expect {
        put task_path(-1), params: @new_hash
      }.wont_change "Task.count"

      must_redirect_to error_path(error: 'Task to update not found!')
    end

    it 'will fail to save a task with invalid params' do
      skip
      # TODO: Think of a way to cause a failed save task
      # task = Task.first
      # put task_path(task.id), params: { task: {a: 1} }
      # must_redirect_to error_path(error: 'Unable to update task!')
    end


  end
  
  # Complete these tests for Wave 4
  describe "destroy" do
    before do
      task_hash = {
          task: {
              name: 'cat',
              description: 'cat',
              completed_at: 'cat'
          }
      }

      post tasks_path, params: task_hash
    end
    it 'can delete a task' do
      @task = Task.first
      expect {
        delete task_path(@task.id)
      }.must_change 'Task.count', -1

      task = Task.find_by(name: 'cat')

      expect(task).must_be_nil

      must_redirect_to tasks_path
    end

    it 'fails to delete a nonexistent task' do
      expect {
        delete task_path(-1)
      }.wont_change 'Task.count'

      must_redirect_to error_path(error: 'Can\'t find task to delete!')
    end

  end
  
  # Complete for Wave 4
  describe "toggle_complete" do
    # Your tests go here
  end
end

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

    it "will render :edit if attempts to enter an empty task are made" do
      # Arrange
      empty_task = {task: {name:nil, description:nil}}

      # Act-Assert
      expect {
        post tasks_path, params: empty_task
      }.wont_change "Task.count"

      # success indicates rendering of page
      assert_response :success
    end
  end
  
  # DONE - Unskip and complete these tests for Wave 3
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
      must_respond_with :redirect
    end
  end
  
  # Uncomment and complete these tests for Wave 3
  describe "update" do
    # Arrange
    before do
      Task.create(name:"edit this task name", description: "edit this description")
    end
    let (:edit_task_data) {
      {
        task: {name: "Task edited!",
                description:"Description edited!"}
      }
    }
    # Note:  If there was a way to fail to save the changes to a task, that would be a great
    #        thing to test - used validation and added a test for "create" as well!
    it "can update an existing task" do
      # Arrange
      id = Task.find_by(name:"edit this task name")[:id]
      # Act-Assert
      expect{
        patch task_path(id), params: edit_task_data
      }.wont_change "Task.count"

      must_redirect_to task_path(id)

      edited_task = Task.find_by(name: edit_task_data[:task][:name])
      expect(edited_task.description).must_equal edit_task_data[:task][:description]
      expect(edited_task.completed_at).must_equal edit_task_data[:task][:completed_at]
    end
    
    it "will redirect to the root page if given an invalid id" do
      id = -1
      # Act-Assert
      expect {
        patch task_path(id), params: edit_task_data
      }.wont_change "Task.count"

      must_redirect_to :root
    end

    it "will redirect to the root page if given an invalid id" do
      id = -1
      # Act-Assert
      expect {
        patch task_path(id), params: edit_task_data
      }.wont_change "Task.count"

      must_redirect_to :root
    end

    it "will render :edit if attempts to enter an empty task are made" do
      # Arrange
      id = Task.find_by(name:"edit this task name")[:id]
      empty_task = {task: {name:nil, description:nil}}

      # Act-Assert
      expect {
        patch task_path(id), params: empty_task
      }.wont_change "Task.count"

      # success indicates rendering of page
      assert_response :success
    end
  end
  
  # DONE - Complete these tests for Wave 4
  describe "destroy" do
    it "can destroy a model" do
      # Arrange
      delete_me = Task.new name: "Delete me", description: "Delete me"

      delete_me.save
      id = delete_me.id

      # Act
      expect {
        delete task_path(id)

        # Assert
      }.must_change 'Task.count', -1

      assert_nil(Task.find_by(name: delete_me.name))

      must_respond_with :redirect
      must_redirect_to tasks_path
    end
    it "directs to 404 error page if task doesn't exist" do
      # Act
      expect {
        delete task_path(-1)

        # Assert
      }.wont_change 'Task.count'

      must_respond_with :not_found
    end
  end
  
  # Complete for Wave 4
  describe "toggle_complete" do
    # Arrange
    before do
      Task.create(name:"test", description: "testing")
    end
    # Note:  If there was a way to fail to save the changes to a task, that would be a great
    #        thing to test - used validation and added a test for "create" as well!
    it "can toggle a task between incomplete and complete" do
      # Arrange
      id = Task.find_by(name:"test")[:id]
      # Act-Assert
      # incomplete -> incomplete
      expect{
        patch toggle_complete_task_path(id)
      }.wont_change "Task.count"

      must_redirect_to :root

      toggled_task = Task.find_by(name:"test")
      expect(toggled_task.description).must_equal "testing"
      expect(toggled_task.completed_at).must_be_instance_of String

      # complete -> incomplete
      # try on task page

      expect{
        get task_path(id)
        patch toggle_complete_task_path(id)
      }.wont_change "Task.count"

      must_redirect_to :root

      toggled_task = Task.find_by(name:"test")
      expect(toggled_task.description).must_equal "testing"
      assert_nil(toggled_task.completed_at)
    end

    it "will redirect to the root page if given an invalid id" do
      id = -1
      # Act-Assert
      expect {
        patch toggle_complete_task_path(id)
      }.wont_change "Task.count"

      must_redirect_to :root
    end

    it "will redirect to the root page if given an invalid id" do
      id = -1
      # Act-Assert
      expect {
        patch toggle_complete_task_path(id)
      }.wont_change "Task.count"

      must_redirect_to :root
    end
  end
end

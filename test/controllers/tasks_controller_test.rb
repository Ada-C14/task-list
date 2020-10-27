require "test_helper"

describe TasksController do
  describe "index" do
    it "should get index" do
      get "/tasks"
      must_respond_with :success
    end
  end

  describe "show" do
    it "will get show for valid ids" do
      # Arrange
      valid_task_id = 1

      # Act
      get "/tasks/#{valid_task_id}"

      # Assert
      must_respond_with :success
    end

    it "will respond with not found for invalid ids" do

      invalid_task_id = 999

      get "/tasks/#{invalid_task_id}"

      must_respond_with :success
    end


  end

end




# it "can get tasks path" do
#   #Act
#   get "/tasks"
#   must_respond_with :success
#   must_respond_with :ok
# end
#
# it "can get task path even with no books in DB" do
#   skip
#   #Act
#   get "/tasks"
#   must_respond_with :ok
# end
require "test_helper"

# US #4: As a User, I want to create a task for a specific category so that i can organize tasks quicker
# US #5: As a User, I want to edit a task to update task’s details
# US #6: As a User, I want to view a task to show task’s details
# US #7: As a User, I want to delete a task to lessen my unnecessary daily tasks

class TaskCrudTest < ActionDispatch::IntegrationTest
  # include devise helpers
  include Devise::Test::IntegrationHelpers

  test "should create task" do
    # sign in
    sign_in users(:one)

    # go to new task page
    get new_category_task_path(tasks(:one).category)
    assert_response :success

    # create task
    post category_tasks_path, params: {
      task: {
        name: "test task 123",
        notes: "test task notes 123",
        date: DateTime.new(2021,10,16),
        complete: true
      } 
    }
    assert :redirect
    follow_redirect!
    assert_response :success

    # validate if task was created
    assert_select "div a", "test task 123"
  end

  test "should update task" do
    # sign in
    sign_in users(:one)

    # go to edit task page
    get edit_category_task_path(tasks(:one).category, tasks(:one))
    assert_response :success

    # edit task
    patch category_task_path, params: {
      task: {
        name: "MyString (edited)",
        notes: "MyText (edited)",
        date: DateTime.new(2021,10,9,10,51,2),
        complete: false
      }
    }
    assert :redirect
    follow_redirect!
    assert_response :success

    # validate if task was edited
    assert_select "div a", "MyString (edited)"
  end

  test "should read task" do
    # sign in
    sign_in users(:one)

    # go to a specified task
    get category_task_path(tasks(:one).category, tasks(:one))
    assert_response :success

    # validate task details are shown
    assert_select "h1 a", tasks(:one).category.title # check if category of task is on the page
    assert_select "h1 span", tasks(:one).name # check if task name is on the page
  end

  test "should destroy task" do
    # sign in
    sign_in users(:one)

    # delete task
    assert_difference("Task.count", -1) do
      delete category_task_path(tasks(:one).category, tasks(:one))
    end
  end
end
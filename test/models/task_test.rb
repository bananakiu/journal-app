require "test_helper"

class TaskTest < ActiveSupport::TestCase
  # setup
  setup do
    @user = users(:one)
  end

  test "should not save task without name" do
    @category = @user.categories.create(title: "Test Category")
    task = @category.tasks.create(name: nil)
    assert_not task.save, "saved category without name"
  end

  test "should not save task with name longer than 100 characters" do
    @category = @user.categories.create(title: "Test Category")
    task = @category.tasks.create(name: "a"*101)
    assert_not task.save, "saved category with name longer than 100 characters"
  end

  test "should not save task with notes longer than 2000 characters" do
    @category = @user.categories.create(title: "Test Category")
    task = @category.tasks.create(name: "Test Task", notes: "a"*2001)
    assert_not task.save, "saved category with notes longer than 2000 characters"
  end

end

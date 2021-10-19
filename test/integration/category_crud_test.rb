require "test_helper"

# US #1: As a User, I want to create a category that can be used to organize my tasks
# US #2: As a User, I want to edit a category to update the category’s details
# US #3: As a User, I want to view a category to show the category’s details

class CategoryCrudTest < ActionDispatch::IntegrationTest
  # include devise helpers
  include Devise::Test::IntegrationHelpers

  test "should create category" do
    # sign in
    sign_in users(:one)

    # go to create category page
    get new_category_path
    assert_response :success

    # create category
    post categories_path, params: {
      category: {
        title: "test category 123"
      } 
    }
    assert :redirect
    follow_redirect!
    assert_response :success

    # validate if category was created
    assert_select "h1 a span", "test category 123"
  end

  test "should update categories" do
    # sign in
    sign_in users(:one)

    # go to edit category page
    get edit_category_path(categories(:one))
    assert_response :success

    # edit category
    patch category_path, params: {
      category: {
        title: "MyString (edited)"
      }
    }
    assert :redirect
    follow_redirect!
    assert_response :success

    # validate if category was edited
    assert_select "h1 a span", "MyString (edited)"
  end

  test "should read category" do
    # sign in
    sign_in users(:one)

    # go to a specified category (redirects to task index)
    get category_path(categories(:one))
    assert :redirect
    follow_redirect!
    assert_response :success

    # validate if category title is seen
    assert_select "h1", "MyString" + " Tasks"
  end

  test "should destroy category" do
    # sign in
    sign_in users(:one)

    # delete category
    assert_difference("Category.count", -1) do
      delete category_path(categories(:one))
    end
  end
end

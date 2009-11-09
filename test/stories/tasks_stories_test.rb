require File.expand_path(File.join(File.dirname(__FILE__), '..', 'test_helper.rb'))

class TasksStoriesTest < ActionController::IntegrationTest
  story "Creating a new task" do
    def setup
      @user = User.create(:login => "albert",
                          :email => "albert@foo.com",
                          :password => "mypassword",
                          :password_confirmation => "mypassword")
      @list = @user.lists.create(:name => "A new list")
      @task = @list.tasks.create(:title => "some task")
    end

    scenario "given valid paramters" do
      login("albert", "mypassword")
      visit "/lists/#{@list.id}/tasks/new"
      fill_in "Title", :with => "A new task"
      click_button "Create"
      assert_contain "New task created!"
    end

    scenario "given bad parameters" do
      login("albert", "mypassword")
      visit "/lists/#{@list.id}/tasks/new"
      click_button "Create"
      assert_contain "Title can't be blank"
    end

    def teardown
      user = User.find_by_login("albert")
      user.lists.delete_all
      user.delete
    end
  end

  story "Edit a task" do
    def setup
      @user = User.create(:login => "albert",
                          :email => "albert@foo.com",
                          :password => "mypassword",
                          :password_confirmation => "mypassword")
      @list = @user.lists.create(:name => "A new list")
      @task = @list.tasks.create(:title => "some task")
    end

    scenario "given good parameters" do
      login("albert", "mypassword")
      visit "/lists/#{@list.id}/tasks/#{@task.id}/edit"
      fill_in "Title", :with => "do something"
      click_button "Update"
      assert_contain "Task successfuly updated!"
    end

    scenario "given bad parameters" do
      login("albert", "mypassword")
      visit "/lists/#{@list.id}/tasks/#{@task.id}/edit"
      fill_in "Title", :with => ""
      click_button "Update"
      assert_contain "Title can't be blank"
    end

    def teardown
      user = User.find_by_login("albert")
      user.lists.delete_all
      user.delete
    end
  end
end


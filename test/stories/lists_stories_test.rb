require File.expand_path(File.join(File.dirname(__FILE__), '..', 'test_helper.rb'))

class ListsStoriesTest < ActionController::IntegrationTest

  story "As a user I want to Log in so I can start using Tasks" do
    def setup
      @user = User.create(:login => "Mancu", :email => "foo@bar.com", :password => "mypassword", :password_confirmation => "mypassword")
      @list = @user.lists.create(:name => "things" )
    end

    scenario "Given a valid user with a valid list should be listed" do
      login("Mancu", "mypassword")
      assert_contain "things"
    end

    scenario "Given a valid user, with a valid list, add a new list" do
      login("Mancu", "mypassword")
      assert_contain "My lists"
      assert_contain "things"
      assert_not_contain "stuff"
      click_link "New list"
      fill_in :name, :with => "stuff"
      click_button "Create"
      assert_contain "New list created!"
    end

    scenario "Show a valid list" do
      login("Mancu", "mypassword")
      assert_contain "My lists"
      assert_contain "things"
      click_link "show"
      assert_contain "New task"
    end

    scenario "Edit a valid list" do
      login("Mancu", "mypassword")
      assert_contain "My lists"
      assert_contain "things"
      assert_not_contain "list updated"
      click_link "edit"
      assert_contain "Edit list"
      fill_in :name, :with => "list updated"
      click_button "Update"
      assert_contain "My lists"
      assert_not_contain "things"
      assert_contain "list updated"
    end
  end

end

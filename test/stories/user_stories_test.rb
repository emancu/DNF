require File.expand_path(File.join(File.dirname(__FILE__), '..', 'test_helper.rb'))

class UserStoriesTest < ActionController::IntegrationTest

  story "Login successful" do
    def setup
      @user = User.create(:login => "Mancu", :email => "foo@bar.com", :password => "mypassword", :password_confirmation => "mypassword")
    end

    scenario "Given a valid user" do
      login("Mancu", "mypassword")
      assert_contain "Welcome Mancu"
    end

    scenario "Given a valid user, fill with wrong password" do
      login("Mancu", "wrong_password")
      assert_contain "Password is not valid"
    end
  end

  story "Login fail" do

    scenario "Try with an unknown user" do
      login("non_user","wrong_passord")
      assert_contain "Login is not valid"
    end

    scenario "Fields are empty" do
      login("", "")
      assert_contain "You did not provide any details for authentication."
    end

    scenario "Do not fill the password field" do
      login("user", "")
      assert_contain "Password cannot be blank"
    end

    scenario "Do not fill the login field" do
      login("","mypassword")
      assert_contain "Login cannot be blank"
    end
  end

  story "Registration" do
    scenario "Given good information" do
      visit "/users/new"
      fill_in :login, :with => "ablert"
      fill_in :email, :with => "foo@bar.com"
      fill_in :password, :with => "mypassword"
      fill_in "Password confirmation", :with => "mypassword"
      click_button "Register"
      assert_contain "Account registered!"
    end

    scenario "Given bad information" do
      visit "/users/new"
      click_button "Register"
      assert_contain "Password confirmation is too short (minimum is 4 characters)"
      assert_contain "Password is too short (minimum is 4 characters)"
      assert_contain "Password doesn't match confirmation"
      assert_contain "Login is too short (minimum is 3 characters)"
      assert_contain "Login should use only letters, numbers, spaces, and .-_@ please."
      assert_contain "Email is too short (minimum is 6 characters)"
      assert_contain "Email should look like an email address."
    end
  end

end


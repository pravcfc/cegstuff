require 'spec_helper'

describe "User pages" do

  subject { page }

describe "profile page" do
	let( :user ) { FactoryGirl.create(:user) }
	before { visit user_path(user) }

	it {should have_content(user.name)}
	#it {should have_content(user.email)}
end
  
  describe "register" do

    before { visit register_path }

    let(:submit) { "Register Account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Username",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end

  describe "edit user" do
    
    let(:user) { FactoryGirl.create(:user) }
    before { visit edit_user_path(user) }

    describe "page" do
      it { should have_content("Update your profile") }
      it { should have_link("change", href: 'http://gravatar.com/emails') }
    end

    describe "with invalid information" do
      before { click_button "Save Changes" }
      #it { should have_content('error') }
    end

  end

end
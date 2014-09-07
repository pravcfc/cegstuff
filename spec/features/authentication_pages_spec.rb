require 'spec_helper'

describe "Authentication" do

  subject { page }

describe "signin" do
  before { visit signin_path } 

  describe "signin page" do
    it { should have_content('SignIn') }
  end

 describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Email",    with: user.email.upcase
        fill_in "Password", with: user.password
        click_button "SignIn"
      end
      it { should have_link('Profile',     href: user_path(user) ) }
      it { should have_link('Sign Out',    href: signout_path) }
      it { should_not have_link('SignIn', href: signin_path) }
  end
end
end
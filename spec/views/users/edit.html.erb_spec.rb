require 'rails_helper'

RSpec.describe "users/edit", type: :view do
  before(:each) do
    @user = assign(:user, User.create!(
      :name => "MyString",
      :role => 1,
      :email => "MyString",
      :gender => 1,
      :tel => "MyString"
    ))
  end

  it "renders the edit user form" do
    render

    assert_select "form[action=?][method=?]", user_path(@user), "post" do

      assert_select "input[name=?]", "user[name]"

      assert_select "input[name=?]", "user[role]"

      assert_select "input[name=?]", "user[email]"

      assert_select "input[name=?]", "user[gender]"

      assert_select "input[name=?]", "user[tel]"
    end
  end
end

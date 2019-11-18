require 'rails_helper'

RSpec.describe "users/new", type: :view do
  before(:each) do
    assign(:user, User.new(
      :name => "MyString",
      :role => 1,
      :email => "MyString",
      :gender => 1,
      :tel => "MyString"
    ))
  end

  it "renders new user form" do
    render

    assert_select "form[action=?][method=?]", users_path, "post" do

      assert_select "input[name=?]", "user[name]"

      assert_select "input[name=?]", "user[role]"

      assert_select "input[name=?]", "user[email]"

      assert_select "input[name=?]", "user[gender]"

      assert_select "input[name=?]", "user[tel]"
    end
  end
end

require 'rails_helper'

RSpec.describe "users/index", type: :view do
  before(:each) do
    assign(:users, [
      User.create!(
        :name => "Name",
        :role => 2,
        :email => "Email",
        :gender => 3,
        :tel => "Tel"
      ),
      User.create!(
        :name => "Name",
        :role => 2,
        :email => "Email",
        :gender => 3,
        :tel => "Tel"
      )
    ])
  end

  it "renders a list of users" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Tel".to_s, :count => 2
  end
end

require 'spec_helper'

describe "departments/index" do
  before(:each) do
    assign(:departments, [
      stub_model(Department,
        :name => "Name"
      ),
      stub_model(Department,
        :name => "Name"
      )
    ])
  end

  it "renders a list of departments" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end

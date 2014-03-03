require 'spec_helper'

describe "professors/index" do
  before(:each) do
    assign(:professors, [
      stub_model(Professor,
        :name => "Name",
        :department_id => ""
      ),
      stub_model(Professor,
        :name => "Name",
        :department_id => ""
      )
    ])
  end

  it "renders a list of professors" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end

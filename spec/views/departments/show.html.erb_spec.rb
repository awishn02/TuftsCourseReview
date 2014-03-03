require 'spec_helper'

describe "departments/show" do
  before(:each) do
    @department = assign(:department, stub_model(Department,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end

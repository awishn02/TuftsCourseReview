require 'spec_helper'

describe "schools/show" do
  before(:each) do
    @school = assign(:school, stub_model(School,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end

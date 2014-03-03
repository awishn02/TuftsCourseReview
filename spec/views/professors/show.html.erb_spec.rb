require 'spec_helper'

describe "professors/show" do
  before(:each) do
    @professor = assign(:professor, stub_model(Professor,
      :name => "Name",
      :department_id => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
  end
end

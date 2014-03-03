require 'spec_helper'

describe "schools/edit" do
  before(:each) do
    @school = assign(:school, stub_model(School,
      :name => "MyString"
    ))
  end

  it "renders the edit school form" do
    render

    assert_select "form[action=?][method=?]", school_path(@school), "post" do
      assert_select "input#school_name[name=?]", "school[name]"
    end
  end
end

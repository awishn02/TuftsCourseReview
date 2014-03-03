require 'spec_helper'

describe "professors/new" do
  before(:each) do
    assign(:professor, stub_model(Professor,
      :name => "MyString",
      :department_id => ""
    ).as_new_record)
  end

  it "renders new professor form" do
    render

    assert_select "form[action=?][method=?]", professors_path, "post" do
      assert_select "input#professor_name[name=?]", "professor[name]"
      assert_select "input#professor_department_id[name=?]", "professor[department_id]"
    end
  end
end

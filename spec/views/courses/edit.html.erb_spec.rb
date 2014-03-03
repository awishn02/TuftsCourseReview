require 'spec_helper'

describe "courses/edit" do
  before(:each) do
    @course = assign(:course, stub_model(Course,
      :department_id => "",
      :course_num => "MyString",
      :name => "MyString",
      :school_id => ""
    ))
  end

  it "renders the edit course form" do
    render

    assert_select "form[action=?][method=?]", course_path(@course), "post" do
      assert_select "input#course_department_id[name=?]", "course[department_id]"
      assert_select "input#course_course_num[name=?]", "course[course_num]"
      assert_select "input#course_name[name=?]", "course[name]"
      assert_select "input#course_school_id[name=?]", "course[school_id]"
    end
  end
end

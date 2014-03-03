require 'spec_helper'

describe "courses/new" do
  before(:each) do
    assign(:course, stub_model(Course,
      :department_id => "",
      :course_num => "MyString",
      :name => "MyString",
      :school_id => ""
    ).as_new_record)
  end

  it "renders new course form" do
    render

    assert_select "form[action=?][method=?]", courses_path, "post" do
      assert_select "input#course_department_id[name=?]", "course[department_id]"
      assert_select "input#course_course_num[name=?]", "course[course_num]"
      assert_select "input#course_name[name=?]", "course[name]"
      assert_select "input#course_school_id[name=?]", "course[school_id]"
    end
  end
end

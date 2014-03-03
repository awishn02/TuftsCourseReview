require 'spec_helper'

describe "courses/index" do
  before(:each) do
    assign(:courses, [
      stub_model(Course,
        :department_id => "",
        :course_num => "Course Num",
        :name => "Name",
        :school_id => ""
      ),
      stub_model(Course,
        :department_id => "",
        :course_num => "Course Num",
        :name => "Name",
        :school_id => ""
      )
    ])
  end

  it "renders a list of courses" do
    render
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Course Num".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end

require 'spec_helper'

describe "courses/show" do
  before(:each) do
    @course = assign(:course, stub_model(Course,
      :department_id => "",
      :course_num => "Course Num",
      :name => "Name",
      :school_id => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Course Num/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
  end
end

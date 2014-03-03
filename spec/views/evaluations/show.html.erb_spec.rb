require 'spec_helper'

describe "evaluations/show" do
  before(:each) do
    @evaluation = assign(:evaluation, stub_model(Evaluation,
      :course_id => "",
      :teacher_id => "",
      :course_score => "",
      :teacher_score => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end

require 'spec_helper'

describe "evaluations/edit" do
  before(:each) do
    @evaluation = assign(:evaluation, stub_model(Evaluation,
      :course_id => "",
      :teacher_id => "",
      :course_score => "",
      :teacher_score => ""
    ))
  end

  it "renders the edit evaluation form" do
    render

    assert_select "form[action=?][method=?]", evaluation_path(@evaluation), "post" do
      assert_select "input#evaluation_course_id[name=?]", "evaluation[course_id]"
      assert_select "input#evaluation_teacher_id[name=?]", "evaluation[teacher_id]"
      assert_select "input#evaluation_course_score[name=?]", "evaluation[course_score]"
      assert_select "input#evaluation_teacher_score[name=?]", "evaluation[teacher_score]"
    end
  end
end

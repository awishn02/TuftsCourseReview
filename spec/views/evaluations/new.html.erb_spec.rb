require 'spec_helper'

describe "evaluations/new" do
  before(:each) do
    assign(:evaluation, stub_model(Evaluation,
      :course_id => "",
      :teacher_id => "",
      :course_score => "",
      :teacher_score => ""
    ).as_new_record)
  end

  it "renders new evaluation form" do
    render

    assert_select "form[action=?][method=?]", evaluations_path, "post" do
      assert_select "input#evaluation_course_id[name=?]", "evaluation[course_id]"
      assert_select "input#evaluation_teacher_id[name=?]", "evaluation[teacher_id]"
      assert_select "input#evaluation_course_score[name=?]", "evaluation[course_score]"
      assert_select "input#evaluation_teacher_score[name=?]", "evaluation[teacher_score]"
    end
  end
end

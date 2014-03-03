require 'spec_helper'

describe "evaluations/index" do
  before(:each) do
    assign(:evaluations, [
      stub_model(Evaluation,
        :course_id => "",
        :teacher_id => "",
        :course_score => "",
        :teacher_score => ""
      ),
      stub_model(Evaluation,
        :course_id => "",
        :teacher_id => "",
        :course_score => "",
        :teacher_score => ""
      )
    ])
  end

  it "renders a list of evaluations" do
    render
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end

require 'spec_helper'

describe "professors/edit" do
  before(:each) do
    @professor = assign(:professor, stub_model(Professor,
      :name => "MyString",
      :department_id => ""
    ))
  end

  it "renders the edit professor form" do
    render

    assert_select "form[action=?][method=?]", professor_path(@professor), "post" do
      assert_select "input#professor_name[name=?]", "professor[name]"
      assert_select "input#professor_department_id[name=?]", "professor[department_id]"
    end
  end
end

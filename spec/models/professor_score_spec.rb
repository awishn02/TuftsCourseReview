require 'spec_helper'

describe ProfessorScore do
  it "is valid with a course_id, professor_id, semester_id, department_id, score and total_reviews" do
    expect(build(:professor_score)).to be_valid
  end

  it "is invalid without a course_id" do
    contact = build(:professor_score, course_id: nil)
    expect(contact).to have(1).errors_on(:course_id)
  end

  it "is invalid without a professor_id" do
    contact = build(:professor_score, professor_id: nil)
    expect(contact).to have(1).errors_on(:professor_id)
  end

  it "is invalid without a department_id" do
    contact = build(:professor_score, department_id: nil)
    expect(contact).to have(1).errors_on(:department_id)
  end

  it "is invalid without a semester_id" do
    contact = build(:professor_score, semester_id: nil)
    expect(contact).to have(1).errors_on(:semester_id)
  end

  it "is invalid without a score" do
    contact = build(:professor_score, score: nil)
    expect(contact).to have(1).errors_on(:score)
  end

  it "is invalid without total_reviews" do
    contact = build(:professor_score, total_reviews: nil)
    expect(contact).to have(1).errors_on(:total_reviews)
  end

  describe "search by professor" do
    let(:prof1) { create(:professor_score)}

  end
end

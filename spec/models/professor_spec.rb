require 'spec_helper'

describe Professor do
  it "is valid with name, department_id, opt_out, utln" do
    expect(build(:professor)).to be_valid
  end

  it "is invalid without name" do
    expect(build(:professor, name: nil)).to have(1).errors_on(:name)
  end

  it "is invalid without department_id" do
    expect(build(:professor, department_id: nil)).to have(1).errors_on(:department_id)
  end

  it "is invalid without utln" do
    expect(build(:professor, utln: nil)).to have(1).errors_on(:utln)
  end
end

require 'spec_helper'

describe "Courses" do
  describe "GET /courses" do
    it "works! (now write some real specs)" do
      get courses_path
      expect(response.status).to be(200)
    end
  end
end

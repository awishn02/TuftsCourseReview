require 'spec_helper'

describe "Professors" do
  describe "GET /professors" do
    it "works! (now write some real specs)" do
      get professors_path
      expect(response.status).to be(200)
    end
  end
end

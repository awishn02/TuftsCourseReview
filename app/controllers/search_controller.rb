class SearchController < ApplicationController
  autocomplete :professor, :name, :full => true
  def index

  end
end

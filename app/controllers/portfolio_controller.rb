class PortfolioController < ApplicationController
  def top
    @languages = Language.all
    @frameworks = Framework.all
  end
end

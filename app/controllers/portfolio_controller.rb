class PortfolioController < ApplicationController
  def top
    @user = User.get
    Rails.logger.debug(@user)
    @languages = Language.all
    @frameworks = Framework.all
  end
end

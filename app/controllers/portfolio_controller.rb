require "date"

class PortfolioController < ApplicationController
  def top
    @user = User.get
    @languages = Skills::Language.all
    @frameworks = Skills::Framework.all
    @databases = Skills::Database.all
    @others = Skills::Other.all
    @works = Work.all

    # 誕生日と年齢のフォーマットを整形する
    birthday = @user['birthday'].in_time_zone('Tokyo')
    today = Date.today.in_time_zone('Tokyo')

    age = (today.strftime('%Y%m%d').to_i - birthday.strftime('%Y%m%d').to_i) / 10000
    @user['birthdayText'] = "#{birthday.strftime("%Y/%m/%d")}（#{age}歳）"

    # 好きなものと趣味のフォーマットを整形する
    @user['like'] = @user['likes'].join('、')
    @user['hobby'] = @user['hobbies'].join('、')
  end

  def show_work
    respond_to do |format|
      format.html
      # link_toメソッドをremote: trueに設定したのでリクエストはjs形式で行われる
      format.js
    end
  end
end

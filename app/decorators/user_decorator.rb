class UserDecorator < Draper::Decorator
  include Draper::LazyHelpers

  delegate :webinars

  def starred_webinars
    object.stars.joins(:webinar).map { |star| star.webinar }
  end

  def liked_webinars
    object.votes.joins(:webinar).map { |star| star.webinar }
  end

end

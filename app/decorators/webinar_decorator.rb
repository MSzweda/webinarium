class WebinarDecorator < Draper::Decorator
  include Draper::LazyHelpers

  delegate :youtube_url, :language, :blogpost_url, :doc_url, :code_url, :translation_available,
    :user, :title, :description, :id

  def thumbnail
    vid = youtube_video_id
    "http://i1.ytimg.com/vi/#{vid}/hqdefault.jpg" if vid.present?
  end

  def vote_count
    object.votes.count
  end

  def voted?(user)
    object.votes.pluck(:user_id).include? user.id
  end

  def like_link(user)
    if voted?(user)
      link_to I18n.t('webinars.webinar.unvote'), webinar_vote_path(webinar_id: object.id, id: user_vote(user).id),
        method: :delete, class: 'btn btn-default'
    else
      link_to I18n.t('webinars.webinar.vote'), webinar_votes_path(webinar_id: webinar.id),
        method: :post, class: 'btn btn-info'
    end
  end

  private

  def user_vote(user)
    object.votes.find_by(user_id: user.id)
  end

  def youtube_video_id
    uri = URI.parse(object.youtube_url)
    params = CGI.parse(uri.query)
    video_id = params.fetch("v", nil)
    video_id[0] if video_id.present?
  end

end
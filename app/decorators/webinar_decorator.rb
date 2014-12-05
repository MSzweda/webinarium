class WebinarDecorator < Draper::Decorator
  include Draper::LazyHelpers

  delegate :youtube_url, :language, :blogpost_url, :doc_url, :code_url, :translation_available,
    :user, :title, :description, :id, :planned_date

  def thumbnail
    return if object.upcoming?
    vid = youtube_video_id
    "http://i1.ytimg.com/vi/#{vid}/hqdefault.jpg" if vid.present?
  end

  def vote_count
    object.votes_count
  end

  def star_count
    object.stars_count
  end

  def like_link(vote_id)
    if vote_id.present?
      link_to I18n.t('webinars.webinar.unvote'), webinar_vote_path(webinar_id: object.id, id: vote_id),
        method: :delete, class: 'btn btn-default'
    else
      link_to I18n.t('webinars.webinar.vote'), webinar_votes_path(webinar_id: webinar.id),
        method: :post, class: 'btn btn-info'
    end
  end

  def star_link(star_id)
    if star_id.present?
      link_to webinar_star_path(webinar_id: object.id, id: star_id), method: :delete, class: 'btn btn-default' do
        content_tag(:span, nil, class: 'glyphicon glyphicon-star')
      end
    else
      link_to webinar_stars_path(webinar_id: webinar.id), method: :post, class: 'btn btn-info' do
        content_tag(:span, nil, class: 'glyphicon glyphicon-star-empty')
      end
    end
  end

  def youtube_video_id
    uri = URI.parse(object.youtube_url)
    params = CGI.parse(uri.query)
    video_id = params.fetch("v", nil)
    video_id[0] if video_id.present?
  end

end

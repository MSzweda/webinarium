FactoryGirl.define do
  factory :webinar do
    title 'some title'
    description 'some description'
    youtube_url 'https://www.youtube.com/watch?v=dummyid'
    language 'PL'
    planned_date Time.now
  end
end

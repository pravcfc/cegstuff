# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :relation do
    follower_id ""
    followed_id 1
  end
end

# frozen_string_literal: true

require "factory_girl"

FactoryGirl.define do
  factory :etd, class: ETD do
    sequence(:title) { |n| ["Test Thesis #{n}"] }

    factory :public_etd do
      admin_policy_id AdminPolicy::PUBLIC_POLICY_ID
    end
  end
end

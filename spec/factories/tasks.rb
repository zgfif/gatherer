FactoryBot.define do
  factory :task do
    sequence(:title) { |n| "Thing to do #{n}" }
    size { 1 }
    completed_at { nil }

    trait :small do
      size { 1 }
    end

    trait :large do
      size { 4 }
    end

    trait :newly_complete do
      completed_at { 1.day.ago }
    end

    trait :long_complete do
      completed_at { 6.months.ago }
    end

    factory :trivial, class: Task, traits: %i[small long_complete]
    factory :panic, class: Task, traits: %i[large newly_complete]
  end
end

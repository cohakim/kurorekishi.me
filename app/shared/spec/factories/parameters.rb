FactoryBot.define do
  factory :parameter do
    signedin_at      { 100.minutes.ago }
    collect_method   { Parameter.collect_methods[:timeline] }
  end
end

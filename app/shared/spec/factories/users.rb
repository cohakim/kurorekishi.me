FactoryBot.define do
  factory :user do
    sequence :token do |n|
      "#{n}-#{Faker::Internet.password(16)}"
    end
    secret { Faker::Internet.password(8) }
    name   { Faker::Internet.username }

    factory :cohakim do
      id     { 14186100 }
      token  { '14186100-EMAnvEUOZr5V9gw2ub4XGywFYojmEXhvVyBiZ74Cg' }
      secret { 'IZ2StmiKnabINIee94C1brJQCccECrUvA7vexQLfHE' }
      name   { 'cohakim' }
    end
  end
end

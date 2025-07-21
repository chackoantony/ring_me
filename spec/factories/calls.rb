FactoryBot.define do
  factory :call do
    to_number { "MyString" }
    body { "MyText" }
    status { 1 }
    twilio_status { "MyString" }
    sid { "MyString" }
  end
end

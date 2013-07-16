# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :page do
    title "Last Page"
    image File.open(Rails.root.join('spec/fixtures/ada.jpeg'))
    comment "Kommentar"
    page_nr 1
  end
end

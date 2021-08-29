require 'rails_helper'

RSpec.describe 'User registration', type: :system do
  before do
    driven_by(:selenium, using: :chrome)
  end

  it 'creates and confirms a user' do
    visit new_user_registration_path
    email = "alen@example.com"
    expect(ActionMailer::Base.deliveries.size).to eq(0)

    sign_up(email)

    user = User.find_by(email: email)
    expect(user).not_to be_nil
    expect(user).not_to be_confirmed

    expect(ActionMailer::Base.deliveries.size).to eq(1)

    confirmation_email = ActionMailer::Base.deliveries.last
    expect(confirmation_email.to).to eq([ email ])
    expect(confirmation_email.subject).to eq("Confirmation instructions")

    confirm_email(confirmation_email)

    user.reload
    expect(user).to be_confirmed
  end

  def sign_up(email)
    fill_in "Email", with: email
    fill_in "Name", with: "Alen"
    fill_in "Surname", with: "Esteibar"
    fill_in "Password", with: "1234567890AlEn"
    fill_in "Password confirmation", with: "1234567890AlEn"

    click_button "Sign up"
  end

  def confirm_email(confirmation_email)
    confirmation_link = find_confirmation_link(confirmation_email)

    visit confirmation_link
  end

  def find_confirmation_link(email)
    html = Nokogiri::HTML.parse(email.body.raw_source)

    uri = URI(html.at('a:contains("Confirm my account")').attributes["href"].value)

    uri.request_uri
  end
end

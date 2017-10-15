require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe 'notify user' do
    let(:user) { User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01', password: 'password', password_confirmation: 'password') }

    it 'renders the headers' do
      user.reset_token = User.new_token
      mail = UserMailer.password_reset(user)
      expect(mail.subject).to eq('Password reset')
      expect(mail.to).to eq(['test@test.com'])
      expect(mail.from).to eq(['hello@thecheerpost.com'])
      expect(mail.body.encoded).to match(user.reset_token)
      expect(mail.body.encoded).to match(CGI.escape(user.email))
    end
  end
end

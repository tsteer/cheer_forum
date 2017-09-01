require 'rails_helper'

RSpec.describe User, type: :model do
  let(:username) { nil }
  let(:email) { nil }
  let(:date_of_birth) { nil }
  let(:user) { User.new(username: username, email: email, date_of_birth: date_of_birth) }

  subject { user }

  describe 'validate user' do
    context 'with no username, email or date of birth' do
      it('is not valid') { is_expected.to_not be_valid }
    end

    context 'with a username but no email or date of birth' do
      let(:username) { 'testusername' }
      it('is not valid') { is_expected.to_not be_valid }
    end

    context 'with a username and email but no date of birth' do
      let(:username) { 'testusername' }
      let(:email) { 'test@test.com' }
      it('is not valid') { is_expected.to_not be_valid }
    end

    context 'with a username, email and date of birth' do
      let(:date_of_birth) { '31-09-17' }
      let(:username) { 'testusername' }
      let(:email) { 'test@test.com' }
      it('is valid') { is_expected.to be_valid }
    end
  end
end

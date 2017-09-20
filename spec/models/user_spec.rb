require 'rails_helper'

RSpec.describe User, type: :model do
  let(:username) { nil }
  let(:email) { nil }
  let(:date_of_birth) { nil }
  let(:password) { nil }
  let(:password_confirmation) { nil }
  let(:user) { User.new(username: username, email: email, date_of_birth: date_of_birth, password: password, password_confirmation: password_confirmation) }

  subject { user }

  describe 'validate user' do
    context 'with no username, email or date of birth' do
      it('is not valid') { is_expected.to_not be_valid }
    end

    context 'with a username but no email, date of birth, password or password confirmation' do
      let(:username) { 'testusername' }
      it('is not valid') { is_expected.to_not be_valid }
    end

    context 'with a username and email but no date of birth, password or password confirmation' do
      let(:username) { 'testusername' }
      let(:email) { 'test@test.com' }
      it('is not valid') { is_expected.to_not be_valid }
    end

    context 'with a username, email and date of birth but no password or password confirmation' do
      let(:date_of_birth) { Date.parse('1990-08-31') }
      let(:username) { 'testusername' }
      let(:email) { 'test@test.com' }
      it('is not valid') { is_expected.to_not be_valid }
    end

    describe 'age validation' do
      context 'with an invalid age' do
        let(:date_of_birth) { Date.parse('2015-09-01') }
        let(:username) { 'testusername' }
        let(:email) { 'test@test.com' }
        let(:password) { 'password' }
        let(:password_confirmation) { 'password' }
        it('is not valid') { is_expected.to_not be_valid }
      end

      context 'with a valid age' do
        let(:date_of_birth) { Date.parse('1989-09-01') }
        let(:username) { 'testusername' }
        let(:email) { 'test@test.com' }
        let(:password) { 'password' }
        let(:password_confirmation) { 'password' }
        it('is valid') { is_expected.to be_valid }
      end
    end

    describe 'email validation' do
      context 'with an already registered email' do
        let(:email) { 'test@test.com' }
        let(:username) { 'testusername' }
        let(:date_of_birth)  { Date.parse('1989-09-01') }
        let(:password) { 'password' }
        let(:password_confirmation) { 'password' }
        let(:user_1) { User.create(username: username, email: email, date_of_birth: date_of_birth, password: password, password_confirmation: password_confirmation) }
        
        before do
          user_1
        end

        it('is not valid') { is_expected.to_not be_valid }
      end
    end

    describe 'username validation' do
      context 'with an already registered username' do
        let(:email) { 'test@test.com' }
        let(:username) { 'testusername' }
        let(:date_of_birth)  { Date.parse('1989-09-01') }
        let(:password) { 'password' }
        let(:password_confirmation) { 'password' }
        let(:user_1) { User.create(username: username, email: email, date_of_birth: date_of_birth, password: password, password_confirmation: password_confirmation) }
        
        before do
          user_1
        end

        it('is not valid') { is_expected.to_not be_valid }
      end
    end
  end
end

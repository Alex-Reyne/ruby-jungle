require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'should create a valid user when all fields are correctly entered' do
      @bruh = User.new first_name: 'Alex', last_name: 'Reyne', email: 'alex@gmail.com', password: '1234', password_confirmation: '1234'
      @bruh.save
      expect(@bruh).to be_valid
    end
    it 'should throw error when when password and password_confirmation field do not match' do
      @bruh = User.new first_name: 'Alex', last_name: 'Reyne', email: 'alex@gmail.com', password: '1234', password_confirmation: '123'
      @bruh.save
      expect(@bruh.errors.full_messages).to include "Password confirmation doesn't match Password"
    end
    it 'should throw error when when password is blank' do
      @bruh = User.new first_name: 'Alex', last_name: 'Reyne', email: 'alex@gmail.com', password: nil, password_confirmation: nil
      @bruh.save
      expect(@bruh.errors.full_messages).to include "Password can't be blank"
    end
    it 'should throw error when when first_name is blank' do
      @bruh = User.new first_name: nil, last_name: 'Reyne', email: 'alex@gmail.com', password: '1234', password_confirmation: '1234'
      @bruh.save
      expect(@bruh.errors.full_messages).to include "First name can't be blank"
    end
    it 'should throw error when when last_name is blank' do
      @bruh = User.new first_name: 'Alex', last_name: nil, email: 'alex@gmail.com', password: '1234', password_confirmation: '1234'
      @bruh.save
      expect(@bruh.errors.full_messages).to include "Last name can't be blank"
    end
    it 'should throw error when when email is blank' do
      @bruh = User.new first_name: 'Alex', last_name: 'Reyne', email: nil, password: '1234', password_confirmation: '1234'
      @bruh.save
      expect(@bruh.errors.full_messages).to include "Email can't be blank"
    end
    it 'should throw error when email is not unique' do
      @bruh = User.new first_name: 'Alex', last_name: 'Reyne', email: 'alex@gmail.com', password: '1234', password_confirmation: '1234'
      @bruh.save
      @bruh2 = User.new first_name: 'Alex', last_name: 'Reyne', email: 'ALEX@gmail.com', password: '1234', password_confirmation: '1234'
      @bruh2.save
      expect(@bruh2.errors.full_messages).to include "Email has already been taken"
    end
    it 'should throw error when when password is too short' do
      @bruh = User.new first_name: 'Alex', last_name: 'Reyne', email: 'alex@gmail.com', password: '1', password_confirmation: '1'
      @bruh.save
      expect(@bruh.errors.full_messages).to include "Password is too short (minimum is 4 characters)"
    end
  end

  describe '.authenticate_with_credentials' do
    it 'should allow login with valid credentials' do
      @bruh = User.create first_name: 'Alex', last_name: 'Reyne', email: 'alex@gmail.com', password: '1234', password_confirmation: '1234'
      @signin = User.authenticate_with_credentials('alex@gmail.com', '1234')
      expect(@bruh).to eql(@signin)
    end
    it 'should NOT allow login with invalid credentials' do
      @bruh = User.create first_name: 'Alex', last_name: 'Reyne', email: 'alex@gmail.com', password: '1234', password_confirmation: '1234'
      @signin = User.authenticate_with_credentials('alex@gmail.com', '1111')
      expect(@signin).to eql(nil)
    end
    it 'should allow login if there is whitespace in email' do
      @bruh = User.create first_name: 'Alex', last_name: 'Reyne', email: 'alex@gmail.com', password: '1234', password_confirmation: '1234'
      @signin = User.authenticate_with_credentials('  alex@gmail.com  ', '1234')
      expect(@bruh).to eql(@signin)
    end
    it 'should allow login if email has wrong case' do
      @bruh = User.create first_name: 'Alex', last_name: 'Reyne', email: 'alex@gmail.com', password: '1234', password_confirmation: '1234'
      @signin = User.authenticate_with_credentials('ALEX@gmail.com', '1234')
      expect(@bruh).to eql(@signin)
    end
  end
end

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it "should not create user without all validations" do
      @user = User.new(first_name:'Harjeet',last_name: "Kaur",email: "harjeetkaur.gmail.com",password: "Abc@123",password_confirmation: "Abc@123")
      @user.save
     expect(@user.errors).not_to include(/conformation does not match password/) 
    end
    it "should not create user without first name" do
      @user = User.new(last_name: "Kaur",email: "harjeetkaur.gmail.com",password: "Abc@123",password_confirmation: "Abc@123")
      @user.valid?
     expect(@user.errors.full_messages).to include(/First name can't be blank/) 
    end
    it "should not create user without last name" do
      @user = User.new(first_name:'Harjeet',email: "harjeetkaur.gmail.com",password: "Abc@123",password_confirmation: "Abc@123")
      @user.valid?
     expect(@user.errors.full_messages).to include(/can't be blank/) 
    end
    it "should not create user without password" do
      @user = User.new(first_name:'Harjeet',last_name: "Kaur",email: "harjeetkaur.gmail.com",password_confirmation: "Abc@123")
      @user.valid?
     expect(@user.errors.full_messages).not_to include(/"Password can't be blank/) 
    end
    it "should not create user without password conformation" do
      @user = User.new(first_name:'Harjeet',last_name: "Kaur",email: "harjeetkaur.gmail.com",password: "Abc@123",password_confirmation: "ABC@123")
      @user.valid?
     expect(@user.errors.full_messages).not_to include(/Password can't be blank/) 
    end
    it "should not create user without password and password conformation" do
      @user = User.new(first_name:'Harjeet',last_name: "Kaur",email: "harjeetkaur.gmail.com",password: "Abc@123")
      @user.valid?
     expect(@user.errors.full_messages).not_to include(/Password can't be blank/) 
    end
    it "should not create user if password length is less than 5 character" do
      @user = User.new(first_name:'Harjeet',last_name: "Kaur",email: "harjeetkaur.gmail.com")
      @user.valid?
     expect(@user.errors.full_messages).not_to include(/password too short/) 
    end
    it "should not create user without email" do
      @user = User.new(first_name:'Harjeet',last_name: "Kaur",password: "Abc@123",password_confirmation: "Abc@123")
      @user.valid?
     expect(@user.errors.full_messages).to include(/can't be blank/) 
    end
    it "should not create user if email already exists" do
      @user1 = User.new(first_name:'Harjeet',last_name: "Kaur",email: "harjeetkaur.gmail.com",password: "Abc@123",password_confirmation: "Abc@123")
      @user1.save
      @user2 = User.new(first_name:'Kaur',last_name: "Harjeet",email: "harjeetkaur.gmail.com",password: "Abcd@123",password_confirmation: "Abcd@123")
      @user2.save
     expect(@user1.errors.full_messages).not_to include(/email alredy exists/) 
    end
    it 'should not create a user if email already exits but in capital letters' do
      @user1 = User.new(first_name: "Harjeet", last_name: "Kaur", email: "HARJEETKAUR@GMIL.COM", password: "Abc@123", password_confirmation: "Abc@123")
      @user1.save
      @user2 = User.new(first_name: "Kaur", last_name: "Harjeet", email: "harjeetkaur.gmail.com", password: "Abc@123", password_confirmation: "Abc@123")
      @user2.save
      expect(@user2.errors.full_messages).not_to include(/Email has already been taken/)
    end
    
  end 
  describe '.authenticate_with_credentials' do
    it 'should authenticate user if email and password is correct' do
      @user = User.new(first_name: "Harjeet", last_name: "Kaur", email: "harjeetkaur.gmail.com", password: "Abc@123", password_confirmation: "Abc@123")
      @user.save
      @findUser = User.authenticate_with_credentials("harjeetkaur.gmail.com", "Abc@123")
      expect(@findUser).to be_present
    end
  end
end

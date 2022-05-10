require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do 
    @user = User.new
    @user.first_name = 'josh'
    @user.last_name = 'sparkes'
    @user.email = 'alvin@gmail.com'
    @user.password = 'password'
    @user.password_confirmation = 'password'
  end

  describe "Validations" do 
    it "is valid" do
      expect(@user.valid?).to be true
    end
    
    
    it "throws an error if first_name is blank" do
      @user.first_name = nil
      @user.save
      expect(@user.errors.full_messages).to include("First name can't be blank") 
    end
    
    
    it "throws an error if last_name is blank" do
      @user.last_name = nil
      @user.save
      expect(@user.errors.full_messages).to include("Last name can't be blank") 
    end
    
    
    it "throws an error if last_name is blank" do
      @user.email = nil
      @user.save
      expect(@user.errors.full_messages).to include("Email can't be blank") 
    end
    
    
    it "throws an error if password is blank" do
      @user.password = nil
      @user.save
      expect(@user.errors.full_messages).to include("Password can't be blank") 
    end
  
    it "throws an error if password_confirmation is blank" do
      @user.password_confirmation = nil
      @user.save
      expect(@user.errors.full_messages).to include("Password confirmation can't be blank") 
    end
    it "throws an error if password and confirmation are not the same" do
      @user.password_confirmation = 'passwords'
      @user.save
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    
    it "throws an error if email is not unique" do
      @user1 = User.new(first_name: 'a', last_name: 'b', email: 'alvin@gmail.com', 
        password: 'password', password_confirmation: 'password')
      @user.save
      @user1.save
      expect(@user).to be_valid
      expect(@user1).to_not be_valid
      expect(@user1.errors.full_messages).to include("Email has already been taken")
    end

    it "throws an error if password is not long enough" do 
      @user.password = 'short'
      @user.password_confirmation = 'short'
      @user.save
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 8 characters)")
    end
  end
  
  describe ".authenticate_with_credentials" do 
    it "should not pass with invalid email" do
      @user.save
      @user = User.authenticate_with_credentials('wrong@email.com', @user.password)
      expect(@user).to be(nil)
    end
    it "should not pass with invalid password" do
      @user.save
      @user = User.authenticate_with_credentials(@user.email, 'pass')
      expect(@user).to be(nil)
    end
    it "should pass with valid credentials" do
      @user.save
      @user = User.authenticate_with_credentials(@user.email, @user.password)
      expect(@user).to_not be(nil)
    end
    it "should authenticate with whitespace" do
      @user.save
      @user = User.authenticate_with_credentials('  alvin@gmail.com  ', @user.password )
      expect(@user).to_not be(nil)
    end
    it "should authenticate with valid email no matter what the case" do
      @user.save
      @user = User.authenticate_with_credentials('AlVin@gmail.com', @user.password)
      expect(@user).to_not be(nil)
    end
  end
end

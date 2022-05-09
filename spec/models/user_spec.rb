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
    context "valid with all fields filled out" do 
      it "is valid" do
        expect(@user.valid?).to be true
      end
    end
    context "invalid without a first_name" do
      it "throws an error if first_name is blank" do
        @user.first_name = nil
        @user.save
        expect(@user.errors.full_messages).to include("First name can't be blank") 
      end
    end
    context "invalid without a last_name" do
      it "throws an error if last_name is blank" do
        @user.last_name = nil
        @user.save
        expect(@user.errors.full_messages).to include("Last name can't be blank") 
      end
    end
    context "invalid without a email" do
      it "throws an error if last_name is blank" do
        @user.email = nil
        @user.save
        expect(@user.errors.full_messages).to include("Email can't be blank") 
      end
    end
  end
end

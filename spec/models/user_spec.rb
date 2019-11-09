require 'rails_helper'

RSpec.describe User, :type => :model do
  before(:all) do
    @user = create(:user)
    @admin_user = create(:admin_user)
  end

  describe 'Validations' do
    it "is valid with valid attributes" do
      expect(@user).to be_valid
    end
  
    it "is not valid without a email" do
      @user.email = nil
      expect(@user).to_not be_valid
    end
  
    it "is not valid without a valid email" do
      @user.email = Faker::Lorem.word
      expect(@user).to_not be_valid
    end
  
    it "is not valid without a first_name" do
      @user.first_name = nil
      expect(@user).to_not be_valid
    end
  
    it "is not valid without a last_name" do
      @user.last_name = nil
      expect(@user).to_not be_valid
    end
  
    it "is not valid with a password shorter than 6" do
      @user.password = 'hello'
      expect(@user).to_not be_valid
    end
  end

  describe '.admin_role?' do
    context 'when user is employee' do
      it 'should return false' do
        expect(@user.admin_role?).to be false
      end 
    end

    context 'when user is admin' do
      it 'should return true' do
        expect(@admin_user.admin_role?).to be true
      end
    end

  end
end
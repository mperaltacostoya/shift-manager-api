require 'rails_helper'
require 'jwt'

RSpec.describe UsersController, :type => :api do
  before(:all) do
    create_list(:employee_user_with_shifts, 10)
    @user = create(:employee_user_with_shifts)
  end

  context 'when user is admin' do
    before(:all) do
      admin = create(:admin_user)
      @token = JsonWebToken.encode(user_id: admin.id)
    end

    describe 'GET #index' do
      before do
        header 'Authorization', @token
        get '/users.json'
      end

      it 'responds with a 200 status' do
        expect(last_response.status).to eq 200
      end
    end

    describe 'GET #show' do
      before do
        header 'Authorization', @token
        get "/users/#{@user.id}.json"
      end

      it 'responds with a 200 status' do
        expect(last_response.status).to eq 200
      end

      it 'show a specific user information' do
        p json_response
        expect(json_response['id']).to eql(@user.id)
      end

      it 'show information to indetify user' do
        expect(json_response.keys).to include('id', 'firstName', 'lastName', 'email')
      end
    end
  end

  context 'when user is employee' do
    before(:all) do
      @token = JsonWebToken.encode(user_id: @user.id)
    end

    describe 'GET #index' do
      before do
        header 'Authorization', @token
        get '/users.json'
      end

      it 'responds with a 403 status' do
        expect(last_response.status).to eq 403
      end
    end
  end
end
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
      before(:all) do
        header 'Authorization', @token
        get '/users.json'
      end

      it 'responds with a 200 status' do
        expect(last_response.status).to eq 200
      end
    end

    describe 'GET #show' do
      before(:all) do
        header 'Authorization', @token
        get "/users/#{@user.id}.json"
      end

      it 'responds with a 200 status' do
        expect(last_response.status).to eq 200
      end

      it 'shows a specific user information' do
        expect(json_response['id']).to eql(@user.id)
      end

      it 'shows information to indetify user' do
        expect(json_response.keys).to include('id', 'firstName', 'lastName', 'email')
      end
    end

    describe 'POST #create' do
      before(:all) do
        @params = {
          first_name: Faker::Name.first_name,
          last_name: Faker::Name.last_name,
          email: Faker::Internet.safe_email,
          password: 'hello123',
          password_confirmation: 'hello123'
        }
        header 'Authorization', @token
        post '/users.json', @params
      end

      it 'responds with a 201 status' do
        expect(last_response.status).to eq 201
      end

      it 'shows new user information' do
        expect(json_response['email']).to eql(@params[:email])
      end
    end

    describe 'PUT #update' do
      before(:all) do
        @params = {
          first_name: Faker::Name.first_name,
        }
        header 'Authorization', @token
        put "/users/#{@user.id}.json", @params
      end

      it 'responds with a 204 status' do
        expect(last_response.status).to eq 204
      end

      it 'should change attribute in the system' do
        expect(User.find_by(id: @user.id).first_name).to eql(@params[:first_name])
      end
    end

    describe 'DELETE #destroy' do
      before(:all) do
        @other_user = create(:user)
        header 'Authorization', @token
        delete "/users/#{@other_user.id}.json"
      end

      it 'responds with a 204 status' do
        expect(last_response.status).to eq 204
      end

      it 'should destroy user from the system' do
        expect(User.find_by(id: @other_user.id)).to be_nil
      end
    end
  end

  context 'when user is employee' do
    before(:all) do
      @token = JsonWebToken.encode(user_id: @user.id)
    end

    describe 'GET #index' do
      before(:all) do
        header 'Authorization', @token
        get '/users.json'
      end

      it 'responds with a 403 status' do
        expect(last_response.status).to eq 403
      end
    end

    describe 'GET #show' do
      context 'when user accesss own information' do
        before(:all) do
          header 'Authorization', @token
          get "/users/#{@user.id}.json"
        end

        it 'responds with a 200 status' do
          expect(last_response.status).to eq 200
        end

        it 'shows self information' do
          expect(json_response['id']).to eql(@user.id)
        end
      end

      context 'when user accesss other user' do
        before(:all) do
          other_user = create(:user)
          header 'Authorization', @token
          get "/users/#{other_user.id}.json"
        end

        it 'responds with a 403 status' do
          expect(last_response.status).to eq 403
        end
      end
    end

    describe 'POST #create' do
      before(:all) do
        @params = {
          first_name: Faker::Name.first_name,
          last_name: Faker::Name.last_name,
          email: Faker::Internet.safe_email,
          password: 'hello123',
          password_confirmation: 'hello123'
        }
        header 'Authorization', @token
        post "/users.json", @params
      end

      it 'responds with a 403 status' do
        expect(last_response.status).to eq 403
      end
    end

    describe 'PUT #update' do
      before(:all) do
        @params = {
          first_name: Faker::Name.first_name,
        }
        header 'Authorization', @token
        put "/users/#{@user.id}.json", @params
      end

      it 'responds with a 403 status' do
        expect(last_response.status).to eq 403
      end
    end

    describe 'DELETE #destroy' do
      before(:all) do
        header 'Authorization', @token
        delete "/users/#{@user.id}.json"
      end

      it 'responds with a 403 status' do
        expect(last_response.status).to eq 403
      end
    end
  end
end

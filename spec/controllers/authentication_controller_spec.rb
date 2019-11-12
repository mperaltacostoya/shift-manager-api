RSpec.describe V1::AuthenticationController, :type => :api do
  describe 'POST #signup' do
    before(:all) do
      @params = {
        email: Faker::Internet.safe_email,
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        password: 'hello123',
        password_confirmation: 'hello123'
      }
    end

    context 'when user signup with valid credentials' do
      it 'responds with a 201 status' do
        post 'v1/auth/signup.json', @params
        expect(last_response.status).to eq 201
      end

      it 'responds with a 422 status if email is taken' do
        user = create(:user)
        @params[:email] = user.email
        post 'v1/auth/signup.json', @params
        expect(last_response.status).to eq 422
      end
    end

    context 'when user signup with not valid credentials' do
      it 'responds with a 422 status' do
        @params[:email] = 'no valid email'
        post 'v1/auth/signup.json', @params
        expect(last_response.status).to eq 422
      end
    end
  end

  describe 'POST #login' do
    before(:all) do
      @user = create(:user)
      @params = {
        email: @user.email,
        password: 'hello123'
      }
    end

    context 'when user login with valid credentials' do
      before(:all) do
        post 'v1/auth/login.json', @params
      end

      it 'responds with a 200 status' do
        expect(last_response.status).to eq 200
      end

      it 'shows user information' do
        expect(json_response['id']).to eql(@user.id)
      end

      it 'responds with a token key' do
        expect(json_response.keys).to include('token')
      end

      it 'responds with a token' do
        expect(json_response['token']).to_not be_empty
      end
    end

    context 'when user login with not valid credentials' do
      it 'responds with a 401 status' do
        @params[:password] = 'other'
        post 'v1/auth/login.json', @params
        expect(last_response.status).to eq 401
      end
    end
  end
end

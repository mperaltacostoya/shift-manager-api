RSpec.describe V1::ShiftsController, :type => :api do
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
      context "when access all user's shifts" do
        before(:all) do
          header 'Authorization', @token
          get "v1/users/#{@user.id}/shifts.json"
        end

        it 'responds with a 200 status' do
          expect(last_response.status).to eq 200
        end
      end

      context 'when access all shifts' do
        before(:all) do
          header 'Authorization', @token
          get '/v1/shifts.json'
        end

        it 'responds with a 200 status' do
          expect(last_response.status).to eq 200
        end
      end
    end

    describe 'GET #show' do
      before(:all) do
        @shift = @user.shifts.first
        header 'Authorization', @token
        get "v1/shifts/#{@shift.id}.json"
      end

      it 'responds with a 200 status' do
        expect(last_response.status).to eq 200
      end

      it "responds with user's shift" do
        expect(json_response['userId']).to eql(@user.id)
      end
    end

    describe 'POST #create' do
      before(:all) do
        @params = {
          comments: Faker::Lorem.sentence,
          check_in_time: Faker::Time.between(
            from: DateTime.now - 8.hours,
            to: DateTime.now - 4.hours
          )
        }
      end

      context 'when user has an open shift' do
        before(:all) do
          user_with_open_shift = create(:employee_user_with_open_shift)
          header 'Authorization', @token
          post "v1/users/#{user_with_open_shift.id}/shifts.json", @params
        end

        it 'responds with a 422 status' do
          expect(last_response.status).to eq 422
        end
      end

      context 'when user does not have an open shift' do
        before(:all) do
          header 'Authorization', @token
          post "v1/users/#{@user.id}/shifts.json", @params
        end

        it 'responds with a 201 status' do
          expect(last_response.status).to eq 201
        end
      end
    end

    describe 'PUT #update' do
      before(:all) do
        @shift = @user.shifts.first
        @params = {
          comments: Faker::Lorem.sentence,
          check_in_time: Faker::Time.between(
            from: DateTime.now - 8.hours,
            to: DateTime.now - 4.hours
          ),
          check_out_time: Faker::Time.between(
            from: DateTime.now - 4.hours,
            to: DateTime.now
          )
        }
        header 'Authorization', @token
        put "v1/shifts/#{@shift.id}.json", @params
      end

      it 'responds with a 204 status' do
        expect(last_response.status).to eq 204
      end

      it 'should change attribute in the system' do
        expect(Shift.find_by(id: @shift.id).comments)
          .to eql(@params[:comments])
      end
    end

    describe 'DELETE #destroy' do
      before(:all) do
        @shift = @user.shifts.first
        header 'Authorization', @token
        delete "v1/shifts/#{@shift.id}.json"
      end

      it 'responds with a 204 status' do
        expect(last_response.status).to eq 204
      end

      it 'should destroy shift from the system' do
        expect(Shift.find_by(id: @shift.id)).to be_nil
      end
    end
  end

  context 'when user is employee' do
    before(:all) do
      @token = JsonWebToken.encode(user_id: @user.id)
    end

    describe 'GET #index' do
      context 'when user access own shifts' do
        before(:all) do
          header 'Authorization', @token
          get "v1/users/#{@user.id}/shifts.json"
        end

        it 'responds with a 200' do
          expect(last_response.status).to eq 200
        end
      end

      context "when user access other user's shifts" do
        before(:all) do
          other_user = create(:user)
          header 'Authorization', @token
          get "v1/users/#{other_user.id}/shifts.json"
        end

        it 'responds with a 403 status' do
          expect(last_response.status).to eq 403
        end
      end

      context 'when user access all shifts' do
        before(:all) do
          header 'Authorization', @token
          get 'v1/shifts.json'
        end

        it 'responds with a 403 status' do
          expect(last_response.status).to eq 403
        end
      end
    end

    describe 'GET #show' do
      context 'when user access own shift' do
        before(:all) do
          shift = @user.shifts.first
          header 'Authorization', @token
          get "v1/shifts/#{shift.id}.json"
        end

        it 'responds with a 200 status' do
          expect(last_response.status).to eq 200
        end

        it 'shows own shift' do
          expect(json_response['userId']).to eql(@user.id)
        end
      end

      context "when user access other user's shift" do
        before(:all) do
          other_user = create(:employee_user_with_shifts)
          shift = other_user.shifts.first
          header 'Authorization', @token
          get "v1/shifts/#{shift.id}.json"
        end

        it 'responds with a 403 status' do
          expect(last_response.status).to eq 403
        end
      end
    end

    describe 'POST #create' do
      before(:all) do
        @params = {
          comments: Faker::Lorem.sentence,
          check_in_time: Faker::Time.between(
            from: DateTime.now - 8.hours,
            to: DateTime.now - 4.hours
          )
        }
        header 'Authorization', @token
        post "v1/users/#{@user.id}/shifts.json", @params
      end

      it 'responds with a 403 status' do
        expect(last_response.status).to eq 403
      end
    end

    describe 'PUT #update' do
      before(:all) do
        @shift = @user.shifts.first
        @params = {
          comments: Faker::Lorem.sentence,
          check_in_time: Faker::Time.between(
            from: DateTime.now - 8.hours,
            to: DateTime.now - 4.hours
          ),
          check_out_time: Faker::Time.between(
            from: DateTime.now - 4.hours,
            to: DateTime.now
          )
        }
        header 'Authorization', @token
        put "/v1/shifts/#{@shift.id}.json", @params
      end

      it 'responds with a 403 status' do
        expect(last_response.status).to eq 403
      end
    end

    describe 'DELETE #destroy' do
      before(:all) do
        @shift = @user.shifts.first
        header 'Authorization', @token
        delete "v1/shifts/#{@shift.id}.json"
      end

      it 'responds with a 403 status' do
        expect(last_response.status).to eq 403
      end
    end
  end
end

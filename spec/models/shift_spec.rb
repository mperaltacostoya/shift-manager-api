# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Shift, type: :model do
  before(:all) do
    user = create(:employee_user)
    @shift = create(:closed_shift, user: user)
    @open_shift = create(:open_shift, user: user)
  end

  describe 'validations' do
    it 'is valid with valid atrributes' do
      expect(@shift).to be_valid
    end

    it 'is not valid without check_in_time' do
      @shift.check_in_time = nil
      expect(@shift).to_not be_valid
    end

    describe '.only_shift_open' do
      context 'when user has an open shift' do
        it 'is not valid' do
          user = create(:employee_user_with_open_shift)
          shift = build(:open_shift, user: user)
          expect { shift.save! }.to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: User already has an open shift')
        end
      end

      context 'when user does not have an open shift' do
        it 'is valid' do
          user = create(:employee_user_with_shifts)
          shift = create(:open_shift, user: user)
          expect(shift).to be_valid
        end
      end
    end
  end

  describe '.open?' do
    context 'when shift does not have check_out_time' do
      it 'should return true' do
        expect(@open_shift.open?).to be true
      end
    end

    context 'when shift has check_out_time' do
      it('should return false') do
        expect(@shift.open?).to be false
      end
    end
  end
end

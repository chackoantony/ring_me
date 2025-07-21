require 'rails_helper'

RSpec.describe Call, type: :model do
  describe 'validations' do
    describe 'to_number' do
      it 'is required' do
        expect(Call.new(to_number: nil)).to be_invalid
      end

      it 'accepts valid phone numbers with country code' do
        expect(Call.new(to_number: '+1234567890')).to be_valid
      end

      it 'rejects invalid phone number formats' do
        expect(Call.new(to_number: '123-456-7890')).to be_invalid
      end

      it 'rejects phone numbers starting with 0' do
        call = Call.new(to_number: '0123456789', status: :pending)
        expect(call).not_to be_valid
        expect(call.errors[:to_number]).to include('is invalid')
      end
    end

    describe 'status' do
      it 'is required' do
        expect(Call.new(status: nil)).to be_invalid
      end
    end

    describe 'sid' do
      it 'enforces uniqueness when present' do
        Call.create!(to_number: '+1234567890', status: :pending, sid: 'CA1234567890')

        duplicate_call = Call.new(to_number: '+9876543210', status: :pending, sid: 'CA1234567890')
        expect(duplicate_call).not_to be_valid
      end
    end

    describe 'body' do
      it 'rejects body exceeding 2000 character limit' do
        expect(Call.new(to_number: '+1234567890', status: :pending, body: 'a' * 2001)).to be_invalid
      end
    end
  end
end

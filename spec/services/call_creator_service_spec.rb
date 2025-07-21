require 'rails_helper'

RSpec.describe CallCreatorService do
  let(:call_obj) { create(:call) }
  let(:twilio_client) { instance_double('Twilio::REST::Client') }
  let(:twilio_call) { instance_double('Twilio::REST::Api::V2010::AccountContext::CallInstance', sid: 'CA1234567890abcdef', status: 'queued') }

  before do
    ENV['TWILIO_PHONE_NUMBER'] = '+15551234567'
    ENV['PUBLIC_URL'] = 'https://example.com'
    ENV['TWILIO_ACCOUNT_SID'] = 'test_sid'
    ENV['TWILIO_AUTH_TOKEN'] = 'test_token'
    allow(Twilio::REST::Client).to receive(:new).and_return(twilio_client)
  end

  describe '#call' do
    context 'when the call is created successfully' do
      before do
        allow(twilio_client).to receive_message_chain("calls.create").and_return(twilio_call)
      end

      it 'creates a Twilio call and updates the call object' do
        result = described_class.call(call_obj: call_obj)
        call_obj.reload

        expect(result).to be_success
        expect(call_obj.status).to eq('processing')
        expect(call_obj.twilio_status).to eq('queued')
        expect(call_obj.sid).to eq(twilio_call.sid)
      end
    end

    context 'when Twilio client raises an error' do
      before do
        allow(twilio_client).to receive_message_chain("calls.create").and_raise(instance_double(Twilio::REST::RestError))
      end

      it 'handles the error and updates call status to error' do
        result = described_class.call(call_obj: call_obj)
        call_obj.reload

        expect(result).to be_failure
        expect(call_obj.status).to eq('error')
      end
    end

    context 'when a generic exception occurs' do
      before do
        allow_any_instance_of(described_class).to receive(:make_twilio_call).and_raise(StandardError.new('Something went wrong'))
      end

      it 'handles the exception and updates call status to error' do
        result = described_class.call(call_obj: call_obj)
        call_obj.reload

        expect(result).to be_failure
        expect(call_obj.status).to eq('error')
      end
    end
  end
end

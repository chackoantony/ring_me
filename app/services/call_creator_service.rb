class CallCreatorService
  include Interactor

  delegate :client, :call_obj, to: :context

  before do
    context.client = Twilio::REST::Client.new ENV.fetch("TWILIO_ACCOUNT_SID"), ENV.fetch("TWILIO_AUTH_TOKEN")
  end

  def call
    twilio_call = make_twilio_call

    call_obj.update!(sid: twilio_call.sid, status: :processing, twilio_status: twilio_call.status)
  rescue => e
    call_obj.update!(status: :error)
    handle_exception(e)
    context.fail!(error: "Internal server error")
  end

  private

  def make_twilio_call
    client.calls.create(
      from: ENV.fetch("TWILIO_PHONE_NUMBER"),
      to: call_obj.to_number,
      url: "#{ENV.fetch('PUBLIC_URL')}/calls/#{call_obj.id}/voice.xml"
    )
  end

  def message
    call_obj.body.presence || "Hello, this is a test call from my Rails app!"
  end

  def handle_exception(e)
    Rails.logger.error("Error creating call: #{e.message}")
    # May be notifiy external exception service here
  end
end

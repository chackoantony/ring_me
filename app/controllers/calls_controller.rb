class CallsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:voice]

  def home
    @call = Call.new
  end

  def index
    @calls = Call.order(created_at: :desc).limit(10)
  end

  def create
    @call = Call.create(call_params)
    raise @call.errors.full_messages.first if @call.invalid?

    result = CallCreatorService.call(call_obj: @call)

    if result.success?
      redirect_to calls_path, notice: "Successfully queued call"
    else
      raise result.error
    end
  rescue => e
    flash.now[:alert] = e.message
    render :home
  end

  # Twilio hits this to get TwiML
  def voice
    call = Call.find(params[:id])
    response = Twilio::TwiML::VoiceResponse.new do |r|
      r.say message: call.body, voice: "Polly.Joanna"
    end
    render xml: response.to_s
  end

  private

  def call_params
    params.require(:call).permit(:to_number, :body)
  end
end

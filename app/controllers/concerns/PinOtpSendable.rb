module PinOtpSendable
  extend ActiveSupport::Concern

  def send_pin
    response = PaystackService::DebitCard.submit_pin(reference: params.require(:reference), pin: params.require(:pin))
    paystack_response(response)
  end

  def send_otp
    response = PaystackService::DebitCard.submit_otp(reference: params.require(:reference), otp: params.require(:otp))
    paystack_response(response)
  end
end

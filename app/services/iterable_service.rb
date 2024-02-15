require 'httparty'
require 'webmock'

class IterableService
  include HTTParty
  include WebMock::API
  WebMock.enable!

  BASE_URI = 'https://api.iterable.com/api'

  def initialize
    @event_track = "#{BASE_URI}/events/track"
    @email_target = "#{BASE_URI}/email/target"
  end

  def create_event(user, event)
    event_params = {
      email: user.email,
      userId: user.email,
      eventName: event.name,
      campaignId: event.id,
      createNewFields: true
    }

    stub_request(:post, @event_track).
      with(headers: { 'Accept' => '*/*', 'User-Agent' => 'Ruby' }).
      to_return(status: 200, body: event_params.to_json, headers: {})

    HTTParty.post(@event_track, body: event_params.to_json, headers: { 'Content-Type' => 'application/json' })
  end

  def email_notification(user, event)
    email_params = {
      campaignId: event.id,
      recipientEmail: user.email,
      recipientUserId: user.id,
      dataFields: { event_name: event.name, event_type: event.event_type },
      allowRepeatMarketingSends: true
    }

    stub_request(:post, @email_target).
      with(headers: { 'Accept' => '*/*', 'User-Agent' => 'Ruby' }).
      to_return(status: 200, body: { params: email_params, msg: 'Email notification Sent!', code: 'Success' }.to_json)

    HTTParty.post(@email_target, body: email_params.to_json, 
                   headers: { 'Content-Type' => 'application/json' })
  end
end

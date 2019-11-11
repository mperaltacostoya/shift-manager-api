# frozen_string_literal: true

# Helper to reuse code
module ApiHelper
  include Rack::Test::Methods

  def app
    Rails.application
  end
end

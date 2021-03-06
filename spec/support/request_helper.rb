# frozen_string_literal: true

# Helper to reuse code
module Requests
  module JsonHelpers
    def json_response
      JSON.parse(last_response.body)
    end
  end
end

class StocksController < ApplicationController
  include ActionController::Live

  def index
    response.headers['Content-Type'] = 'text/event-stream'
    sse = SSE.new(response.stream, retry: 300, event: "tick")

    loop do
      params["symbols"].split(",").each do |sym|
        sse.write({
          "symbol" => "#{sym}",
          "last" => "#{rand(0..500)}",
          "date" => "#{Time.now.to_i}"
        })
      end
    end
  ensure
    sse.close
  end
end

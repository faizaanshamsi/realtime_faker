class StocksController < ApplicationController
  include ActionController::Live

  def index
    response.headers['Content-Type'] = 'text/event-stream'
    sse = SSE.new(response.stream, retry: 300, event: "event-name")
    x = 0
    while true
      x += 1
      sse.write("#{x}")
      puts x
    end
  ensure
    sse.close
  end
end

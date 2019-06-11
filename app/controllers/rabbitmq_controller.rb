require 'bunny'

class RabbitmqController < ApplicationController

  def send_message
    connection = Bunny.new( host: ENV["RABBIT_MQ_URL"], port: ENV["RABBIT_MQ_PORT"], user: ENV["RABBIT_MQ_USER"], password: ENV["RABBIT_MQ_PASS"])
    connection.start


    channel = connection.create_channel
    queue = channel.queue('All Code Channel')

    channel.default_exchange.publish('Hello World!', routing_key: queue.name)

    connection.close

    render json: {status: "Works"}
  end

end

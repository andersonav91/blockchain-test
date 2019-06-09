require 'net/http'
require 'uri'
require 'json'

class EthereumController < ApplicationController

  # you need to config the ETHEREUM_RPC_URL
  def get_block_count
    @uri = URI.parse(ENV['ETHEREUM_RPC_URL'])

    http = Net::HTTP.new(@uri.host, @uri.port)
    request = Net::HTTP::Post.new(@uri.request_uri)
    http.use_ssl = (@uri.scheme == "https")
    request.content_type = 'application/json'
    request.body = get_body("eth_blockNumber")

    response = http.request(request).body
    resp = JSON.parse(response)
    raise JSONRPCError, resp['error'] if resp['error']
    render json: resp
  rescue => error
    render json: {error: error}
  end

  private

  def get_body(nameMethod, *args)
    post_body = { 'method' => nameMethod, 'params' => args, 'id' => 'jsonrpc' }.to_json
    return post_body
  end

end

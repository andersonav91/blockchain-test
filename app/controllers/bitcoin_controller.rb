require 'net/http'
require 'uri'
require 'json'

class BitcoinController < ApplicationController

  # you need to config the BITCOIN_RPC_URL, BITCOIN_RPC_USER and BITCOIN_RPC_PASS
  def get_block_count
    @uri = URI.parse(ENV['BITCOIN_RPC_URL'])
    @uri.user = ENV['BITCOIN_RPC_USER']
    @uri.password = ENV['BITCOIN_RPC_PASS']

    http = Net::HTTP.new(@uri.host, @uri.port)
    request = Net::HTTP::Post.new(@uri.request_uri)
    request.basic_auth @uri.user, @uri.password
    http.use_ssl = (@uri.scheme == "https")
    request.content_type = 'application/json'
    request.body = get_body("getblockchaininfo")

    response = http.request(request).body
    resp = JSON.parse(response)
    raise JSONRPCError, resp['error'] if resp['error']
    render json: resp
  rescue => error
    render json: {error: error}
  end

  def get_body(nameMethod, *args)
    post_body = { 'method' => nameMethod, 'params' => args, 'id' => 'jsonrpc' }.to_json
    return post_body
  end

end

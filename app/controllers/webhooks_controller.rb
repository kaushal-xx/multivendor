# frozen_string_literal: true

class WebhooksController < ApplicationController
  def order_create
  	Shop.first.set_store_session
    puts "**********************"
    puts params.inspect
    puts "*********************"
    render :nothing => true, :status => 200, :content_type => 'text/html'
  end
end

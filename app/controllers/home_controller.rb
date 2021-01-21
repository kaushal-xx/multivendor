# frozen_string_literal: true

class HomeController < ApplicationController
	before_action :authenticate_sme_user!
  def index

  end

  def profile

  end
end

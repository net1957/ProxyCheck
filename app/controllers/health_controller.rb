# frozen_string_literal: true

# Manage health checks
class HealthController < ApplicationController
  layout false

  def index
    # default always return OK. We assume rails is working
    # to check more (ex: db) add code here and return head :service_unavailable if check fail
    head :ok
  end
end

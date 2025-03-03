# frozen_string_literal: true

# Manage optimizer page
class OptimizeController < ApplicationController
  before_action :allowed?

  def new
    @optimizer = Forms::Optimizer.new
  end

  def create
    @optimizer = Forms::Optimizer.new(optimize_params)
    optimizer.valid? ? send_data(optimizer.result, filename: 'proxy.pac') : render(:new, status: :unprocessable_entity)
  end

  private

  attr_reader :optimizer

  def optimize_params
    params.expect(forms_optimizer: [:name])
  end

  def allowed?
    redirect_to root_path if ENV['NO_COMPRESS_BUTTON']
  end
end

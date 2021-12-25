# Manage optimizer page
class OptimizeController < ApplicationController
  before_action :allowed?

  def new
    @optimizer = Forms::Optimizer.new
  end

  def create
    @optimizer = Forms::Optimizer.new(optimize_params)
    optimizer.valid? ? result : render
  end

  private

  attr_reader :optimizer

  def result
    render json: { response: optimizer.result }
  end

  def optimize_params
    params.require(:forms_optimizer).permit(:name)
  end

  def allowed?
    redirect_to root_path if ENV['NO_COMPRESS_BUTTON']
  end
end

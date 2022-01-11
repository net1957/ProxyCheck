# frozen_string_literal: true

# Manage script page
class ScriptsController < ApplicationController
  def new
    @script = Forms::Script.new(ip: request.remote_ip)
  end

  def create
    @script = Forms::Script.new(script_params)
    script.valid? ? render(status: :ok) : render(:new, status: :unprocessable_entity)
  end

  private

  attr_reader :script

  def script_params
    params.require(:forms_script).permit(:ip, :name, :action, :url)
  end
end

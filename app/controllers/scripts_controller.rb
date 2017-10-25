# Manage home page
class ScriptsController < ApplicationController
  def new
    @script = Forms::Script.new(ip: request.remote_ip)
  end

  def create
    @script = Forms::Script.new(script_params)
    script.valid? ? result : render
  end

  private

  attr_reader :script

  def result
    case script_params[:action]
    when 'compress'
      render json: { response: script.compress }
    when 'url'
      render json: { response: script.proxies }
    else
      render json: { error: true }
    end
  end

  def script_params
    params.require(:forms_script).permit(:ip, :name, :action, :url)
  end
end

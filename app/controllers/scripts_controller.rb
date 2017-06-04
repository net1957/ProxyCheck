# encoding: utf-8

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
      render json: { response: url_response }
    else
      render json: { error: true }
    end
  end

  def url_response
    script_params[:url].split.each_with_object([]) { |url, a| a << { url: url, result: script.proxy(url) } }
  end

  def script_params
    params.require(:forms_script).permit(:ip, :name, :action, :url)
  end
end

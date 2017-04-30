# encoding: utf-8

# Manage home page
class HomeController < ApplicationController
  def index
    @script = Forms::Script.new(ip: request.remote_ip)
  end

  def script
    @script = Forms::Script.new(script_params)
    if @script.valid?
      result(script_params[:action])
    else
      render inline: "$('#form').html('<%= j (render 'form.html') %>').foundation();", content_type: 'text/javascript'
    end
  end

  # private

  def result(action)
    case action
    when 'compress' then
      render json: { response: @script.compress }
    when 'url' then
      render json: { response: script_params[:url].split.each_with_object([]) { |url, a| a << { url: url, result: @script.find_proxy(url) } } }
    else
      render json: { error: true }
    end
  end

  def script_params
    params.require(:forms_script).permit(:ip, :name, :action, :url)
  end
end

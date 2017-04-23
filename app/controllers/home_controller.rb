# encoding: utf-8

# Manage home page
class HomeController < ApplicationController
  def index
    @script = Forms::Script.new
  end

  def script
    @script = Forms::Script.new(script_params)
    if @script.invalid?
      puts @script.errors.messages
      render inline: "$('#form').html('<%= j (render 'form.html') %>').foundation();", content_type: 'text/javascript'

    elsif script_params[:action] == 'compress'
      render json: {parse: @script.compress}
    else
      render inline: "$('#form').html('<%= j (render 'urls.html') %>').foundation();", content_type: 'text/javascript'
    end
  end

  def url
    @script = Forms::Script.new(script_params)
    if @script.invalid?
      puts @script.errors.messages
      render inline: "$('#form').html('<%= j (render 'form.html') %>').foundation();", content_type: 'text/javascript'
    else
      urls = script_params[:url].split
      render json: urls.each_with_object([]) {|url,a| a << {url: url, result: @script.find_proxy(url)}}
    end
  end

  def script_params
    params.require(:forms_script).permit(:ip, :name, :action, :url)
  end

  def url_params
    params.require(:forms_url).permit(:url, :ip, :name, :action)
  end
end

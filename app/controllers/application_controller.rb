require 'net/http'

class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  def normalized
    local_path = Rails.root.join('lib', 'pages', params[:file] || request.path[1..-1])
    unless File.exist?(local_path)
      FileUtils.mkdir_p(File.dirname(local_path))
      File.binwrite(local_path, Net::HTTP.get(URI("http://jenrich.com.cn#{request.path}"))) 
    end
    render file: local_path, layout: false
  end

  def login
    sign_in(User.first)
    redirect_to index_path
  end

  def logout
    sign_out(User.first)
    redirect_to default_path
  end

  def do
    res = FaradayClient.execute(:post, request.path[1..-1], params.to_unsafe_h)
    if res.headers["content-type"] == "text/html;charset=UTF-8"
      render html: res.body.html_safe
    elsif res.headers["content-type"] == "application/json;charset=UTF-8"
      render json: res.body
    end
  end
end

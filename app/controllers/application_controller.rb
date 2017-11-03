class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler

  before_action {authenticate unless request.method == "OPTIONS"}

  private

  def authenticate
    authorization = request.headers['Authorization']
    unless authorization.nil?
      words = authorization.split(' ')
      if words.length == 2 && words[0] == 'Bearer'
        authenticated_token = Token.where(token: words[1]).first
        return unless authenticated_token.nil?
      end
    end
    json_response({ status: "UNAUTHENTICATED" }, :unauthorized)
  end
end

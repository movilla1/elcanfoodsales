# Put methods to login as a user different from the standard.

module AuthHelper
  def auth_header_for(user)
    { 'Authorization' => JsonWebToken.encode(user_id: user.id) }
  end
end
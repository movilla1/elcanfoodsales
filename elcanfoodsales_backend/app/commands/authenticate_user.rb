# frozen_string_literal: true

class AuthenticateUser
  prepend SimpleCommand

  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    user = api_user
    ::JsonWebToken.encode(user_id: user.id) if user
  end

  private

  attr_accessor :email, :password

  def api_user
    user = User.find_for_authentication(email: email)
    unless user.present?
      errors.add :message, "Invalid email / password - #{email}"
      return nil
    end

    # Verify the password. You can create a blank method for now.
    unless user.valid_password?(password)
      errors.add :message, 'Invalid email / password'
      return nil
    end

    user
  end
end

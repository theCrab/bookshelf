require 'bcrypt'

module Web::Controllers::Sessions
  class Signin
    include Web::Action
    include Hanami::Fumikiri::Skip

    params do
      param :signin do
        param :email,    presence: true
        param :password, presence: true
      end
    end

    def call(params)
      if params.valid?
        authenticate_user
        headers.merge!({ 'Authentication' => "Bearer #{@token}" })

        redirect_to "/"
      end
    end

    private
    def login_email
      params.get('signin.email').strip.downcase.gsub(/\s+/, '')
    end

    def login_password
      params.get('signin.password')
    end

    def user
      UserRepository.new.find_by_email(login_email)
    end

    def valid_password?
      BCrypt::Password.new(user.password_hash) == login_password
    end

    def authenticate_user
      if !user.nil? && valid_password?
        @token = create_token(user).result
      end
    end
  end
end

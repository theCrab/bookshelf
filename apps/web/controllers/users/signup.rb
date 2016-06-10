require 'pry'
module Web::Controllers::Users
  class Signup
    include Web::Action
    prepend Hanami::Fumikiri::Skip
    expose :user

    params do
      param :user do
        param :email,    presence: true
        param :password, presence: true
        param :username
      end
    end

    def call(params)
      if params.valid?
        @user = UserRepository.new.create(User.new(params[:user]))
        redirect_to '/'
      end
    end

  end
end

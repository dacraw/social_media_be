class AuthenticationController < ApplicationController
    skip_before_action :authenticate_user!, only: [:login]
    
    def login
        @user = User.find_by_email(authentication_params[:email])

        if @user.authenticate(authentication_params[:password])
            @token = encode_token(user_id: @user.id)
            render json: { message: "Successfully logged in", user: @user.as_json(only: [:name, :email, :id]), token: @token }, status: 200
        else
            render json: { message: "Incorrect credentials."}, status: 400
        end
    end

    def authentication_params
        params.require(:authentication).permit(:email, :password)
    end
end

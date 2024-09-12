class ApplicationController < ActionController::API
    before_action :authenticate_user!

    def encode_token(payload)
        payload["exp"] = exp = Time.now.to_i + 4 * 3600
        
        JWT.encode payload, Rails.application.credentials[:jwt_secret_key]
    end

    def decode_token
        auth = request.headers["Authorization"]

        if auth
            token = auth.split(" ").last
            
            begin
                JWT.decode token, Rails.application.credentials[:jwt_secret_key]
            rescue JWT::DecodeError
                nil
            end
        end
    end

    def current_user
        if decode_token
            user_id = decode_token[0]['user_id']
            @user = User.find_by_id(user_id)
        end
    end

    def authenticate_user!
        if current_user.nil?
            render json: { message: "Please sign in before continuing."}, status: :unauthorized
        end
    end
end

module JWTHelper
    def sign_in(user)
        post login_path, params: { authentication: { email: user.email, password: user.password }}

        JSON.parse(response.body)["token"]
    end
end
defmodule Schoolmanagementsystem.Auth.Guardian do
  use Guardian, otp_app: :Schoolmanagementsystem
  alias Schoolmanagementsystem.Users
  alias Schoolmanagementsystem.Admins


  def subject_for_token(user, _claims) do
    {:ok, to_string(user.id)}
  end
  def resource_from_claims(claims) do
    user = claims["sub"]
    |> Users.get_user!
    {:ok, user}
  end


  # def subject_for_token(admin, _claims) do
  #   {:ok, to_string(admin.id)}
  # end
  # def resource_from_claims(claims) do
  #   admin = claims["sub"]
  #   |> Admins.get_user!
  #   {:ok, admin}
  # end

end

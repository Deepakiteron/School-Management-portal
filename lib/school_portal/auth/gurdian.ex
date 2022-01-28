defmodule SchoolPortal.Auth.Guardian do
  use Guardian, otp_app: :school_portal

  alias SchoolPortal.Users
  alias SchoolPortal.Admins

  def subject_for_token(user, _claims) do
    {:ok, to_string(user.id)}
  end

  def resource_from_claims(%{"sub" => id}) do
    user = Users.get_user!(id)
    {:ok, user}
  rescue
    Ecto.NoResultsError -> {:error, :resource_not_found}
   end


   def subject_for_token(admin, _claims) do
    {:ok, to_string(admin.id)}
  end

  def resource_from_claims(%{"sub" => id}) do
    admin = Admins.get_admin!(id)
    {:ok, admin}
  rescue
    Ecto.NoResultsError -> {:error, :resource_not_found}
   end
end

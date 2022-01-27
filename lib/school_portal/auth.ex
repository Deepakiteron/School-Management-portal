defmodule SchoolPortal.Auth do

  alias Comeonin.Bcrypt
  alias SchoolPortal.Users.User
  alias SchoolPortal.Repo
  import Ecto.Query, only: [from: 2]


  def authenticate_user(email, plain_text_password) do
    query = from u in User, where: u.email == ^email
    Repo.one(query)
    |> check_password(plain_text_password)
  end
  defp check_password(nil, _), do: {:error, "Incorrect email or password"}
  defp check_password(user, plain_text_password) do
    case Bcrypt.checkpw(plain_text_password, user.password) do
      true -> {:ok, user}
      false -> {:error, "Incorrect email or password"}
    end
  end
end

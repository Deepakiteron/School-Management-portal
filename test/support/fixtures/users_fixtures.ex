defmodule SchoolPortal.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SchoolPortal.Users` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        address: "some address",
        age: 42,
        category_type: "some category_type",
        email: "some email",
        firstname: "some firstname",
        gender: "some gender",
        lastname: "some lastname",
        password: "some password",
        phone_number: "some phone_number"
      })
      |> SchoolPortal.Users.create_user()

    user
  end
end

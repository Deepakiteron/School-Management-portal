defmodule Schoolmanagementsystem.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Schoolmanagementsystem.Users` context.
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
        email: "some email",
        first_name: "some first_name",
        gender: "some gender",
        last_name: "some last_name",
        password: "some password",
        phone_number: "some phone_number",
        type: "some type"
      })
      |> Schoolmanagementsystem.Users.create_user()

    user
  end
end

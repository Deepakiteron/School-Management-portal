defmodule Schoolmanagementsystem.Authorization do
  alias __MODULE__
  # alias Schoolmanagementsystem.Users.User
  # alias Smsapp.Users.User
  # alias Pow.Plug
  # import Plug.Conn
  defstruct roles: nil, create: %{}, read: %{}, update: %{}, delete: %{}

  def can("student" = roles) do
    grant(roles)
    |> create(User)
    # |> read(Register)
  end

  def can("teacher" = roles) do
    grant(roles)
    |> create(User)
    # |> read(Register)
  end

  # def can("manager" = roles) do
  #   grant(roles)
  #   |> all(Register)
  # end

  def can("admin" = roles) do
    grant(roles)
    # |> all(Register)
    |> all(User)
  end

  def grant(roles), do: %Authorization{roles: roles}

  def read(authorization, resource), do: put_action(authorization, :read, resource)

  def create(authorization, resource), do: put_action(authorization, :create, resource)

  def update(authorization, resource), do: put_action(authorization, :update, resource)

  def delete(authorization, resource), do: put_action(authorization, :delete, resource)

  def all(authorization, resource) do
    authorization
    |> create(resource)
    |> read(resource)
    |> update(resource)
    |> delete(resource)
  end

  def read?(authorization, resource) do
    Map.get(authorization.read, resource, false)
  end

  def create?(authorization, resource) do
    Map.get(authorization.create, resource, false)
  end

  def update?(authorization, resource) do
    Map.get(authorization.update, resource, false)
  end

  def delete?(authorization, resource) do
    Map.get(authorization.delete, resource, false)
  end

  defp put_action(authorization, action, resource) do
    updated_action =
      authorization
      |> Map.get(action)
      |> Map.put(resource, true)

    Map.put(authorization, action, updated_action)
  end
end

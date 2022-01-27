defmodule Schoolmanagementsystem.Users.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Comeonin.Bcrypt
  alias Schoolmanagementsystem.Users.User

  schema "registers" do
    field :address, :string
    field :age, :integer
    field :email, :string
    field :first_name, :string
    field :gender, :string
    field :last_name, :string
    field :password, :string
    field :phone_number, :string
    field :type, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :age, :gender, :phone_number, :email, :password, :address, :type])
    |> validate_required([:first_name, :last_name, :age, :gender, :phone_number, :email, :password, :address, :type])
    |> validate_length(:first_name, min: 1, max: 20)
    |> validate_length(:last_name, min: 4, max: 20)
    |> validate_inclusion(:age, 5..50)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 4)
    |> unique_constraint(:email)
    |> put_pass_hash()
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, password: Bcrypt.hashpwsalt(password))
  end
  defp put_pass_hash(changeset), do: changeset
end

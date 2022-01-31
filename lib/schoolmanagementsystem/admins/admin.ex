defmodule Schoolmanagementsystem.Admins.Admin do
  use Ecto.Schema
  import Ecto.Changeset
  alias Schoolmanagementsystem.Admins.Admin
  alias Comeonin.Bcrypt

  schema "admins" do
    field :age, :integer
    field :email, :string
    field :name, :string
    field :password, :string
    field :role, :string

    timestamps()
  end

  @doc false
  def changeset(%Admin{} = admin, attrs) do
    admin
    |> cast(attrs, [:name, :age, :email, :password, :role])
    |> validate_required([:name, :age, :email, :password, :role])
    |> put_pass_hash()
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, password: Bcrypt.hashpwsalt(password))
  end

  defp put_pass_hash(changeset), do: changeset

end

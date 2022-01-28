defmodule Schoolmanagementsystem.Email do
  import Swoosh.Email

  def user_request_email(user) do
    new()
    |> from(user.email)
    |> to("kaarthi+admin@email.in")
    |> subject("Waiting")
    |> html_body("<p>Waiting</p>")
  end

  def user_accept_email(user) do
    new()
    |> from("kaarthi+admin@email.in")
    |> to(user.email)
    |> subject("Welcome User")
    |> html_body("<p>Thank you for registration</p>")
  end

end
